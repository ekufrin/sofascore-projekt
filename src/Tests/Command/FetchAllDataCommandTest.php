<?php

namespace App\Tests\Command;

use App\Command\FetchAllDataCommand;
use App\Entity\Country;
use App\Entity\Sport;
use App\Entity\Tournament;
use App\Message\FetchSportDataMessage;
use App\Service\Provider;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Exception\InvalidArgumentException;
use Symfony\Component\Console\Tester\CommandTester;
use Symfony\Component\Messenger\MessageBusInterface;

class FetchAllDataCommandTest extends TestCase
{
    public function testExecuteSportFoundAndDataFetched()
    {
        $apiClient = $this->createMock(Provider::class);
        $bus = $this->createMock(MessageBusInterface::class);
        $entityManager = $this->createMock(EntityManagerInterface::class);

        $sportName = 'Football';

        $apiClient->expects($this->exactly(2))
            ->method('fetchData')
            ->willReturnCallback(function ($input) {
                $tournamentsData = [
                    [
                        'id' => 1,
                        'name' => 'Premier League',
                        'slug' => 'premier-league',
                        'country' => ['id' => 1, 'name' => 'England']
                    ],
                    ['id' => 2, 'name' => 'La Liga', 'slug' => 'la-liga', 'country' => ['id' => 2, 'name' => 'Spain']]
                ];
                $sportsData = [
                    ['id' => 1, 'name' => 'Football', 'slug' => 'football'],
                    ['id' => 2, 'name' => 'Basketball', 'slug' => 'basketball']
                ];
                if ($input === 'sports') {
                    return $sportsData;
                }

                if ($input === 'sport/football/tournaments') {
                    return $tournamentsData;
                }

                throw new \Exception("Unexpected input: $input");
            });

        $sportRepository = $this->createMock(EntityRepository::class);
        $tournamentRepository = $this->createMock(EntityRepository::class);
        $countryRepository = $this->createMock(EntityRepository::class);

        $entityManager->expects($this->any())
            ->method('getRepository')
            ->willReturnMap([
                [Sport::class, $sportRepository],
                [Tournament::class, $tournamentRepository],
                [Country::class, $countryRepository]
            ]);

        $sport = new Sport();
        $sport->setExternalId(1);
        $sport->setName('Football');
        $sport->setSlug('football');

        $tournament = new Tournament();
        $tournament->setExternalId(1);
        $tournament->setName('Premier League');
        $tournament->setSlug('premier-league');
        $tournament->setSport($sport);

        $sportRepository->expects($this->once())
            ->method('findOneBy')
            ->with(['external_id' => 1])
            ->willReturn(null);

        $tournamentRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturn(null);

        $countryRepository->expects($this->any())
            ->method('findOneBy')
            ->willReturn(null);

        $entityManager->expects($this->exactly(3))
            ->method('persist')
            ->with($this->logicalOr(
                $this->isInstanceOf(Sport::class),
                $this->isInstanceOf(Country::class),
                $this->isInstanceOf(Tournament::class)
            ));

        $entityManager->expects($this->exactly(3))
            ->method('flush');

        $filePath = realpath(__DIR__ . '/../../json_data/tournaments_football.json');

        $bus->expects($this->exactly(2))
            ->method('dispatch')
            ->with($this->callback(function ($message) use ($filePath) {
                return $message instanceof FetchSportDataMessage &&
                    $message->getFilePath() === $filePath &&
                    $message->getTournamentId() === 1 &&
                    $message->getSportSlug() === 'football';
            }));

        $command = new FetchAllDataCommand($apiClient, $bus, $entityManager);

        $application = new Application();
        $application->add($command);

        $commandTester = new CommandTester($command);
        $commandTester->execute([
            'sportName' => $sportName
        ]);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('Data fetched successfully for sport Football!', $output);
    }

    public function testExecuteSportNotFound()
    {
        $apiClient = $this->createMock(Provider::class);
        $bus = $this->createMock(MessageBusInterface::class);
        $entityManager = $this->createMock(EntityManagerInterface::class);

        $sportName = 'UnknownSport';
        $sportsData = [
            ['id' => 1, 'name' => 'Football', 'slug' => 'football'],
            ['id' => 2, 'name' => 'Basketball', 'slug' => 'basketball']
        ];

        $apiClient->expects($this->once())
            ->method('fetchData')
            ->with('sports')
            ->willReturn($sportsData);

        $command = new FetchAllDataCommand($apiClient, $bus, $entityManager);

        $application = new Application();
        $application->add($command);

        $commandTester = new CommandTester($command);

        $this->expectException(InvalidArgumentException::class);
        $this->expectExceptionMessage('Sport UnknownSport not found!');

        $commandTester->execute([
            'sportName' => $sportName
        ]);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('Sport UnknownSport not found!', $output);
    }
}
