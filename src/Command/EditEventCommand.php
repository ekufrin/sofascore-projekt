<?php

namespace App\Command;

use App\Entity\Event;
use App\Entity\Incident;
use App\Entity\Score;
use App\Entity\Team;
use App\Entity\Tournament;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'EditEvent',
    description: 'Edit existing event informations',
)]
class EditEventCommand extends Command
{

    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->entityManager = $entityManager;
    }

    protected function configure(): void
    {
        $this
            ->setDescription('Edits event information for a specific date and event ID')
            ->addArgument('eventExternalId', InputArgument::REQUIRED, 'The External ID of the event to edit')
            ->addArgument('date', InputArgument::REQUIRED, 'The date for which to edit the event (format: Y-m-d H:m)')
            ->addArgument('tournament_id', InputArgument::OPTIONAL, 'The new tournament ID for the event')
            ->addArgument('home_team_name', InputArgument::OPTIONAL, 'The new home team name for the event')
            ->addArgument('away_team_name', InputArgument::OPTIONAL, 'The new away team name for the event')
            ->addArgument('home_score', InputArgument::OPTIONAL, 'The new home score for the event')
            ->addArgument('away_score', InputArgument::OPTIONAL, 'The new away score for the event')
            ->addArgument('slug', InputArgument::OPTIONAL, 'The new slug for the event')
            ->addArgument('start_date', InputArgument::OPTIONAL, 'The new start date for the event')
            ->addArgument('round', InputArgument::OPTIONAL, 'The new round for the event')
            ->addArgument('status', InputArgument::OPTIONAL, 'The new status for the event')
            ->addArgument('winner_code', InputArgument::OPTIONAL, 'The new winner code for the event')
            ->addArgument('incident_id', InputArgument::OPTIONAL, 'The ID of the incident to edit')
            ->addArgument('incident_type', InputArgument::OPTIONAL, 'The new type for the incident')
            ->addArgument('incident_time', InputArgument::OPTIONAL, 'The new time for the incident')
            ->addArgument('player_id', InputArgument::OPTIONAL, 'The new player ID for the incident')
            ->addArgument('team_side', InputArgument::OPTIONAL, 'The new team side for the incident')
            ->addArgument('color', InputArgument::OPTIONAL, 'The new card color for the incident')
            ->addArgument('scoring_team', InputArgument::OPTIONAL, 'The new scoring team for the incident')
            ->addArgument('home_score_incident', InputArgument::OPTIONAL, 'The new home score for the incident')
            ->addArgument('away_score_incident', InputArgument::OPTIONAL, 'The new away score for the incident')
            ->addArgument('goal_type', InputArgument::OPTIONAL, 'The new goal type for the incident')
            ->addArgument('text', InputArgument::OPTIONAL, 'The new text for the incident');

    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $eventId = $input->getArgument('eventExternalId');
        $date = $input->getArgument('date');

        $event = $this->entityManager->getRepository(Event::class)->findOneBy(
            ['external_id' => $eventId, 'startDate' => new \DateTime($date)]
        );

        if ($event === null) {
            throw new \Symfony\Component\Console\Exception\InvalidArgumentException('No event found for the given ID and date');
        }

        if ($input->getArgument('tournament_id')) {
            $tournament = $this->entityManager->getRepository(Tournament::class)->findOneBy(
                ['external_id' => $input->getArgument('tournament_id')]
            );
            if ($tournament !== null) {
                $event->setTournament($tournament);
            }
        }
        if ($input->getArgument('home_team_name')) {
            $homeTeam = $event->getHomeTeam();
            if ($homeTeam !== null) {
                $homeTeam->setName($input->getArgument('home_team_name'));
                $this->entityManager->persist($homeTeam);
            }
        }
        if ($input->getArgument('away_team_name')) {
            $awayTeam = $event->getAwayTeam();
            if ($awayTeam !== null) {
                $awayTeam->setName($input->getArgument('away_team_name'));
                $this->entityManager->persist($awayTeam);
            }
        }
        if ($input->getArgument('home_score')) {
            $homeScore = $event->getHomeScore();
            if ($homeScore !== null) {
                $homeScore->setTotal($input->getArgument('home_score'));
                $this->entityManager->persist($homeScore);
            }
        }
        if ($input->getArgument('away_score')) {
            $awayScore = $event->getAwayScore();
            if ($awayScore !== null) {
                $awayScore->setTotal($input->getArgument('away_score'));
                $this->entityManager->persist($awayScore);
            }
        }
        if ($input->getArgument('slug')) {
            $event->setSlug($input->getArgument('slug'));
        }
        if ($input->getArgument('start_date')) {
            $event->setStartDate(new \DateTime($input->getArgument('start_date')));
        }
        if ($input->getArgument('round')) {
            $event->setRound($input->getArgument('round'));
        }
        if ($input->getArgument('status')) {
            $event->setStatus($input->getArgument('status'));
        }
        if ($input->getArgument('winner_code')) {
            $event->setWinnerCode($input->getArgument('winner_code'));
        }

        if ($input->getArgument('incident_id')) {
            $incident = $this->entityManager->getRepository(Incident::class)->findOneBy(
                ['external_id' => $input->getArgument('incident_id')]
            );
            if ($incident !== null) {
                if ($input->getArgument('incident_type')) {
                    $incident->setType($input->getArgument('incident_type'));
                }
                if ($input->getArgument('incident_time')) {
                    $incident->setTime($input->getArgument('incident_time'));
                }
                if($input->getArgument('player_id')) {
                    $incident->setPlayerId($input->getArgument('player_id'));
                }
                if($input->getArgument('team_side')) {
                    $incident->setTeamSide($input->getArgument('team_side'));
                }
                if($input->getArgument('color')) {
                    $incident->setColor($input->getArgument('color'));
                }
                if($input->getArgument('scoring_team')) {
                    $incident->setScoringTeam($input->getArgument('scoring_team'));
                }
                if($input->getArgument('home_score_incident')) {
                    $incident->setHomeScore($input->getArgument('home_score_incident'));
                }
                if($input->getArgument('away_score_incident')) {
                    $incident->setAwayScore($input->getArgument('away_score_incident'));
                }
                if($input->getArgument('goal_type')) {
                    $incident->setGoalType($input->getArgument('goal_type'));
                }
                if($input->getArgument('text')) {
                    $incident->setText($input->getArgument('text'));
                }
                $this->entityManager->persist($incident);
            }
        }

        $this->entityManager->persist($event);
        $this->entityManager->flush();

        $io->success('Event edited successfully');

        return Command::SUCCESS;
    }
}