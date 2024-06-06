<?php

namespace App\Tests\Command;

use App\Command\UpdateEventCommand;
use App\Entity\Country;
use App\Entity\Event;
use App\Entity\Score;
use App\Entity\Sport;
use App\Entity\Team;
use App\Entity\Tournament;
use App\Repository\EventRepository;
use App\Service\Provider;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Tester\CommandTester;

class UpdateEventCommandTest extends TestCase
{
    public function testExecuteEventFoundAndUpdated()
    {
        $entityManager = $this->createMock(EntityManagerInterface::class);
        $eventRepository = $this->createMock(EventRepository::class);
        $provider = $this->createMock(Provider::class);

        $date = new \DateTime('2024-05-26 19:10:00');

        $homeTeam = new Team();
        $homeTeam->setExternalId(1);
        $homeTeam->setName('Dinamo');

        $awayTeam = new Team();
        $awayTeam->setExternalId(2);
        $awayTeam->setName('Rijeka');

        $homeScore = new Score();
        $homeScore->setExternalId(1);
        $homeScore->setTotal(3);

        $awayScore = new Score();
        $awayScore->setExternalId(2);
        $awayScore->setTotal(1);

        $event = new Event();
        $event->setExternalId(123);
        $event->setStartDate($date);
        $event->setHomeTeam($homeTeam);
        $event->setAwayTeam($awayTeam);
        $event->setHomeScore($homeScore);
        $event->setAwayScore($awayScore);

        $updatedEventData = [
            'id' => 123,
            'startDate' => '2024-05-26T19:10:00+00:00',
            'round' => '23',
            'status' => 'finished',
            'winnerCode' => 'home',
            'slug' => 'dinamo-rijeka',
            'homeTeam' => [
                'id' => 1,
                'name' => 'Dinamo',
                'country' => [
                    'id' => 1,
                    'name' => 'Croatia'
                ]
            ],
            'awayTeam' => [
                'id' => 2,
                'name' => 'Rijeka',
                'country' => [
                    'id' => 2,
                    'name' => 'Croatia'
                ]
            ],
            'homeScore' => [
                'total' => 3,
                'period1' => 1,
                'period2' => 2,
                'period3' => null,
                'period4' => null,
                'overtime' => null
            ],
            'awayScore' => [
                'total' => 1,
                'period1' => 1,
                'period2' => 0,
                'period3' => null,
                'period4' => null,
                'overtime' => null
            ],
            'tournament' => [
                'id' => 1,
                'name' => 'HNL',
                'slug' => 'hnl',
                'sport' => [
                    'id' => 1,
                    'name' => 'Football',
                    'slug' => 'football'
                ],
                'country' => [
                    'id' => 1,
                    'name' => 'Croatia'
                ]
            ]
        ];

        $eventRepository->expects($this->once())
            ->method('findOneBy')
            ->with(['external_id' => 123, 'startDate' => $date])
            ->willReturn($event);

        $provider->expects($this->once())
            ->method('fetchData')
            ->with('event/123')
            ->willReturn($updatedEventData);

        // Mock repositories for dependent entities
        $sportRepository = $this->createMock(EntityRepository::class);
        $tournamentRepository = $this->createMock(EntityRepository::class);
        $countryRepository = $this->createMock(EntityRepository::class);
        $teamRepository = $this->createMock(EntityRepository::class);
        $scoreRepository = $this->createMock(EntityRepository::class);

        $entityManager->expects($this->any())
            ->method('getRepository')
            ->willReturnMap([
                [Sport::class, $sportRepository],
                [Tournament::class, $tournamentRepository],
                [Country::class, $countryRepository],
                [Team::class, $teamRepository],
                [Score::class, $scoreRepository]
            ]);

        // Return mocked entities where necessary
        $sportRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturn(null);

        $tournamentRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturn(null);

        $countryRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturn(null);

        $teamRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturnCallback(function($criteria) use ($homeTeam, $awayTeam) {
                if ($criteria['external_id'] === 1) {
                    return $homeTeam;
                } elseif ($criteria['external_id'] === 2) {
                    return $awayTeam;
                }
                return null;
            });

        $scoreRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturnCallback(function($criteria) use ($homeScore, $awayScore) {
                if ($criteria['external_id'] === 1) {
                    return $homeScore;
                } elseif ($criteria['external_id'] === 2) {
                    return $awayScore;
                }
                return null;
            });

        $command = new UpdateEventCommand($eventRepository, $provider, $entityManager);

        $application = new Application();
        $application->add($command);

        $commandTester = new CommandTester($command);
        $commandTester->execute([
            'external_id' => 123,
            'date' => '2024-05-26 19:10:00'
        ]);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('Event updated successfully.', $output);
    }

    public function testExecuteEventNotFound()
    {
        $entityManager = $this->createMock(EntityManagerInterface::class);
        $eventRepository = $this->createMock(EventRepository::class);
        $provider = $this->createMock(Provider::class);

        $date = new \DateTime('2024-05-26 19:10:00');

        $eventRepository->expects($this->once())
            ->method('findOneBy')
            ->with(['external_id' => 123, 'startDate' => $date])
            ->willReturn(null);

        $command = new UpdateEventCommand($eventRepository, $provider, $entityManager);

        $application = new Application();
        $application->add($command);

        $commandTester = new CommandTester($command);
        $commandTester->execute([
            'external_id' => 123,
            'date' => '2024-05-26 19:10:00'
        ]);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('Event not found.', $output);
    }
}