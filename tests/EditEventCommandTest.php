<?php
// tests/Command/EditEventCommandTest.php

namespace App\Tests;

use App\Command\EditEventCommand;
use App\Entity\Event;
use App\Entity\Team;
use App\Entity\Score;
use App\Entity\Tournament;
use App\Repository\EventRepository;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\Persistence\ObjectRepository;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Tester\CommandTester;
use Symfony\Component\Console\Exception\InvalidArgumentException;

class EditEventCommandTest extends KernelTestCase
{
    private $entityManager;
    private $eventRepository;
    private $tournamentRepository;
    private $teamRepository;
    private $scoreRepository;

    protected function setUp(): void
    {
        $this->entityManager = $this->createMock(EntityManagerInterface::class);
        $this->eventRepository = $this->createMock(EventRepository::class);
        $this->tournamentRepository = $this->createMock(EventRepository::class);
        $this->teamRepository = $this->createMock(EventRepository::class);
        $this->scoreRepository = $this->createMock(EventRepository::class);
    }

    public function testExecuteWithNoEventFound()
    {
        $this->eventRepository
            ->expects($this->once())
            ->method('findOneBy')
            ->willReturn(null);

        $this->entityManager
            ->method('getRepository')
            ->willReturnMap([
                [Event::class, $this->eventRepository],
            ]);

        $application = new Application();
        $application->add(new EditEventCommand($this->entityManager));

        $command = $application->find('EditEvent');
        $commandTester = new CommandTester($command);

        $this->expectException(InvalidArgumentException::class);
        $this->expectExceptionMessage('No event found for the given ID and date');

        $commandTester->execute([
            'eventId' => '12345',
            'date' => '2023-01-01 10:00',
        ]);
    }

    public function testExecuteWithEventFound()
    {
        $event = $this->createMock(Event::class);
        $homeTeam = $this->createMock(Team::class);
        $awayTeam = $this->createMock(Team::class);
        $homeScore = $this->createMock(Score::class);
        $awayScore = $this->createMock(Score::class);
        $tournament = $this->createMock(Tournament::class);

        $this->eventRepository
            ->expects($this->once())
            ->method('findOneBy')
            ->willReturn($event);

        $this->tournamentRepository
            ->expects($this->any())
            ->method('findOneBy')
            ->willReturn($tournament);

        $this->entityManager
            ->method('getRepository')
            ->willReturnMap([
                [Event::class, $this->eventRepository],
                [Tournament::class, $this->tournamentRepository],
                [Team::class, $this->teamRepository],
                [Score::class, $this->scoreRepository],
            ]);

        $event->method('getHomeTeam')->willReturn($homeTeam);
        $event->method('getAwayTeam')->willReturn($awayTeam);
        $event->method('getHomeScore')->willReturn($homeScore);
        $event->method('getAwayScore')->willReturn($awayScore);

        $homeTeam->expects($this->any())->method('setName');
        $awayTeam->expects($this->any())->method('setName');
        $homeScore->expects($this->any())->method('setTotal');
        $awayScore->expects($this->any())->method('setTotal');
        $event->expects($this->any())->method('setTournament');
        $event->expects($this->any())->method('setSlug');
        $event->expects($this->any())->method('setStartDate');
        $event->expects($this->any())->method('setRound');
        $event->expects($this->any())->method('setStatus');
        $event->expects($this->any())->method('setWinnerCode');

        $this->entityManager->expects($this->atLeastOnce())->method('persist');
        $this->entityManager->expects($this->once())->method('flush');

        $application = new Application();
        $application->add(new EditEventCommand($this->entityManager));

        $command = $application->find('EditEvent');
        $commandTester = new CommandTester($command);

        $commandTester->execute([
            'eventId' => '12345',
            'date' => '2023-01-01 10:00',
            'tournament_id' => '54321',
            'home_team_name' => 'New Home Team',
            'away_team_name' => 'New Away Team',
            'home_score' => '2',
            'away_score' => '3',
            'slug' => 'new-event-slug',
            'start_date' => '2023-01-02 15:00',
            'round' => '2',
            'status' => 'finished',
            'winner_code' => 'away',
        ]);

        $output = $commandTester->getDisplay();
        $this->assertStringContainsString('Event updated successfully', $output);
    }
}
