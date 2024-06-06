<?php

namespace App\Tests\Command;

use App\Command\CalculateStandingCommand;
use App\Entity\Event;
use App\Entity\Score;
use App\Entity\Sport;
use App\Entity\Team;
use App\Entity\Tournament;
use App\Repository\EventRepository;
use App\Repository\TeamRepository;
use Doctrine\ORM\EntityManagerInterface;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Tester\CommandTester;

class CalculateStandingCommandTest extends TestCase
{
    public function testExecuteWithFinishedEvents()
    {
        $entityManager = $this->createMock(EntityManagerInterface::class);
        $teamRepository = $this->createMock(TeamRepository::class);
        $eventRepository = $this->createMock(EventRepository::class);

        $date = new \DateTime('2024-05-26 19:10:00');

        $homeTeam = new Team();
        $homeTeam->setExternalId(1);
        $homeTeam->setName('Home Team');

        $awayTeam = new Team();
        $awayTeam->setExternalId(2);
        $awayTeam->setName('Away Team');

        $sport = new Sport();
        $sport->setSlug('football');

        $tournament = new Tournament();
        $tournament->setSport($sport);

        $event = new Event();
        $event->setStatus('finished');
        $event->setStartDate($date);
        $event->setHomeTeam($homeTeam);
        $event->setAwayTeam($awayTeam);
        $event->setTournament($tournament);
        $event->setWinnerCode('home');

        $homeScore = new Score();
        $homeScore->setTotal(2);

        $awayScore = new Score();
        $awayScore->setTotal(1);

        $event->setHomeScore($homeScore);
        $event->setAwayScore($awayScore);

        $eventRepository->expects($this->once())
            ->method('findBy')
            ->with(['status' => 'finished', 'startDate' => $date])
            ->willReturn([$event]);

        $entityManager->expects($this->once())
            ->method('getRepository')
            ->with(Event::class)
            ->willReturn($eventRepository);

        $teamRepository->expects($this->exactly(2))
            ->method('findOneBy')
            ->willReturnCallback(function($criteria) use ($homeTeam, $awayTeam) {
                if ($criteria['external_id'] === 1) {
                    return $homeTeam;
                } elseif ($criteria['external_id'] === 2) {
                    return $awayTeam;
                }
                return null;
            });

        $command = new CalculateStandingCommand($entityManager, $teamRepository);

        $application = new Application();
        $application->add($command);

        $commandTester = new CommandTester($command);
        $commandTester->execute(['date' => '2024-05-26 19:10:00']);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('Standings have been calculated', $output);


    }

    public function testExecuteWithNoFinishedEvents()
    {
        $entityManager = $this->createMock(EntityManagerInterface::class);
        $teamRepository = $this->createMock(TeamRepository::class);
        $eventRepository = $this->createMock(EventRepository::class);

        $date = new \DateTime('2024-06-15 13:20:00');

        $eventRepository->expects($this->once())
            ->method('findBy')
            ->with(['status' => 'finished', 'startDate' => $date])
            ->willReturn([]);

        $entityManager->expects($this->once())
            ->method('getRepository')
            ->with(Event::class)
            ->willReturn($eventRepository);

        $command = new CalculateStandingCommand($entityManager, $teamRepository);

        $application = new Application();
        $application->add($command);

        $commandTester = new CommandTester($command);
        $commandTester->execute(['date' => '2024-06-15 13:20:00']);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('No finished events on this date', $output);
    }
}
