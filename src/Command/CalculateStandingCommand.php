<?php

namespace App\Command;

use App\Entity\Event;
use App\Entity\Team;
use App\Repository\TeamRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'CalculateStanding',
    description: 'Command for calculating the standings for a specific date.',
)]
class CalculateStandingCommand extends Command
{

    private $entityManager;
    private $teamRepository;

    public function __construct(EntityManagerInterface $entityManager, TeamRepository $teamRepository)
    {
        $this->entityManager = $entityManager;
        $this->teamRepository = $teamRepository;

        parent::__construct();
    }
    protected function configure(): void
    {
        $this
            ->setDescription('Calculate the standings for a specific date.')
            ->addArgument('date', InputArgument::REQUIRED, 'The date for which to calculate the standings.');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $date = new \DateTime($input->getArgument('date'));

        $events = $this->entityManager->getRepository(Event::class)->findBy(
            ['status' => 'finished', 'startDate' => $date]
        );

        if(empty($events)){
            $io->error('No finished events on this date.');
            return Command::FAILURE;
        }

        $teams = [];

        foreach ($events as $event) {
            if($event->getStatus() === 'finished'){
                $winnerCode = $event->getWinnerCode();
                $homeTeam = $event->getHomeTeam();
                $awayTeam = $event->getAwayTeam();
                $sportSlug = $event->getTournament()->getSport()->getSlug();
                if ($sportSlug === 'football') {
                    if ($winnerCode === 'home') {
                        $teams[$homeTeam->getExternalId()]['points'] = ($teams[$homeTeam->getExternalId(
                            )]['points'] ?? 0) + 3;
                        $teams[$homeTeam->getExternalId()]['wins'] = ($teams[$homeTeam->getExternalId()]['wins'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['losses'] = ($teams[$awayTeam->getExternalId(
                            )]['losses'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['goalsFor'] = ($teams[$homeTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsAgainst'] = ($teams[$homeTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getHomeScore()->getTotal();
                    } elseif ($winnerCode === 'away') {
                        $teams[$awayTeam->getExternalId()]['points'] = ($teams[$awayTeam->getExternalId(
                            )]['points'] ?? 0) + 3;
                        $teams[$awayTeam->getExternalId()]['wins'] = ($teams[$awayTeam->getExternalId()]['wins'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['losses'] = ($teams[$homeTeam->getExternalId(
                            )]['losses'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getAwayScore()->getTotal();
                    } elseif ($winnerCode === 'draw') {
                        $teams[$homeTeam->getExternalId()]['points'] = ($teams[$homeTeam->getExternalId(
                            )]['points'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['points'] = ($teams[$awayTeam->getExternalId(
                            )]['points'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['draws'] = ($teams[$homeTeam->getExternalId(
                            )]['draws'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['draws'] = ($teams[$awayTeam->getExternalId(
                            )]['draws'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['goalsFor'] = ($teams[$homeTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsAgainst'] = ($teams[$homeTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getHomeScore()->getTotal();
                    }
                } elseif ($sportSlug === 'basketball') {
                    if ($winnerCode === 'home') {
                        $teams[$homeTeam->getExternalId()]['points'] = ($teams[$homeTeam->getExternalId(
                            )]['points'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['wins'] = ($teams[$homeTeam->getExternalId()]['wins'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['losses'] = ($teams[$awayTeam->getExternalId(
                            )]['losses'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['goalsFor'] = ($teams[$homeTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsAgainst'] = ($teams[$homeTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getHomeScore()->getTotal();
                    } elseif ($winnerCode === 'away') {
                        $teams[$awayTeam->getExternalId()]['points'] = ($teams[$awayTeam->getExternalId(
                            )]['points'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['wins'] = ($teams[$awayTeam->getExternalId()]['wins'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['losses'] = ($teams[$homeTeam->getExternalId(
                            )]['losses'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsFor'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsFor'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['goalsAgainst'] = ($teams[$awayTeam->getExternalId(
                            )]['goalsAgainst'] ?? 0) + $event->getAwayScore()->getTotal();
                    }
                } elseif ($sportSlug === 'american-football') {
                    if ($winnerCode === 'home') {
                        $teams[$homeTeam->getExternalId()]['points'] = ($teams[$homeTeam->getExternalId()]['points'] ?? 0) + 2;
                        $teams[$homeTeam->getExternalId()]['wins'] = ($teams[$homeTeam->getExternalId()]['wins'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['losses'] = ($teams[$awayTeam->getExternalId()]['losses'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['scoredPoints'] = ($teams[$homeTeam->getExternalId()]['scoredPoints'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['concededPoints'] = ($teams[$homeTeam->getExternalId()]['concededPoints'] ?? 0) + $event->getAwayScore()->getTotal();
                    } elseif ($winnerCode === 'away') {
                        $teams[$awayTeam->getExternalId()]['points'] = ($teams[$awayTeam->getExternalId()]['points'] ?? 0) + 2;
                        $teams[$awayTeam->getExternalId()]['wins'] = ($teams[$awayTeam->getExternalId()]['wins'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['losses'] = ($teams[$homeTeam->getExternalId()]['losses'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['scoredPoints'] = ($teams[$awayTeam->getExternalId()]['scoredPoints'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['concededPoints'] = ($teams[$awayTeam->getExternalId()]['concededPoints'] ?? 0) + $event->getHomeScore()->getTotal();
                    } elseif ($winnerCode === 'draw') {
                        $teams[$homeTeam->getExternalId()]['points'] = ($teams[$homeTeam->getExternalId()]['points'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['points'] = ($teams[$awayTeam->getExternalId()]['points'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['draws'] = ($teams[$homeTeam->getExternalId()]['draws'] ?? 0) + 1;
                        $teams[$awayTeam->getExternalId()]['draws'] = ($teams[$awayTeam->getExternalId()]['draws'] ?? 0) + 1;
                        $teams[$homeTeam->getExternalId()]['scoredPoints'] = ($teams[$homeTeam->getExternalId()]['scoredPoints'] ?? 0) + $event->getHomeScore()->getTotal();
                        $teams[$homeTeam->getExternalId()]['concededPoints'] = ($teams[$homeTeam->getExternalId()]['concededPoints'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['scoredPoints'] = ($teams[$awayTeam->getExternalId()]['scoredPoints'] ?? 0) + $event->getAwayScore()->getTotal();
                        $teams[$awayTeam->getExternalId()]['concededPoints'] = ($teams[$awayTeam->getExternalId()]['concededPoints'] ?? 0) + $event->getHomeScore()->getTotal();
                    }
                }
            }
        }

        foreach ($teams as $external_id => $teamStats) {
            $team = $this->teamRepository->findOneBy(['external_id' => $external_id]);
            if ($team !== null) {
                if ($sportSlug === 'football') {
                    $teamStandings[] = [
                        'team_name' => $team->getName(),
                        'GP' => ($teamStats['wins'] ?? 0) + ($teamStats['draws'] ?? 0) + ($teamStats['losses'] ?? 0),
                        'W' => $teamStats['wins'] ?? 0,
                        'D' => $teamStats['draws'] ?? 0,
                        'L' => $teamStats['losses']?? 0,
                        'GF' => $teamStats['goalsFor'] ?? 0,
                        'GA' => $teamStats['goalsAgainst'] ?? 0,
                        'GD' => ($teamStats['goalsFor'] ?? 0) - ($teamStats['goalsAgainst']?? 0),
                        'Pts' => $teamStats['points']?? 0,
                    ];
                } elseif ($sportSlug === 'basketball') {
                    $teamStandings[] = [
                        'team_name' => $team->getName(),
                        'victory%' => (($teamStats['wins']??0) + ($teamStats['losses']??0)) != 0 ? round(($teamStats['wins'] ?? 0) / (($teamStats['wins']??0) + ($teamStats['losses']??0)) * 100,1) : 0,
                        'Gp' => ($teamStats['wins']??0) + ($teamStats['losses']??0),
                        'Gw' => $teamStats['wins']??0,
                        'GL' => $teamStats['losses']??0,
                        'Pts+' => $teamStats['goalsFor']??0,
                        'Pts-' => $teamStats['goalsAgainst']??0,
                        'Pts+ /g' => (($teamStats['wins']??0) + ($teamStats['losses']??0)) != 0 ? round(($teamStats['goalsFor']??0) / (($teamStats['wins']??0) + ($teamStats['losses']??0)) * 100,1) : 0,
                        'Pts- /g' => (($teamStats['wins']??0) + ($teamStats['losses']??0)) != 0 ? round(($teamStats['goalsAgainst']??0) / (($teamStats['wins']??0) + ($teamStats['losses']??0))* 100,1) : 0,
                        'Diff' => ($teamStats['goalsFor']??0) - ($teamStats['goalsAgainst']??0),
                    ];
                }
                elseif ($sportSlug === 'american-football') {
                    $teamStandings[] = [
                        'team_name' => $team->getName(),
                        'W' => $teamStats['wins'] ?? 0,
                        'L' => $teamStats['losses']?? 0,
                        'T' => $teamStats['draws'] ?? 0,
                        'PCT%' => (($teamStats['wins']??0) + ($teamStats['losses']??0) + ($teamStats['draws'] ?? 0)) != 0 ? round((($teamStats['wins']??0) + (($teamStats['draws']??0)*0.5)) / (($teamStats['wins']??0) + ($teamStats['losses']??0) + ($teamStats['draws'] ?? 0)) * 100,3) : 0,
                        'PF' => $teamStats['scoredPoints']??0,
                        'PA' => $teamStats['concededPoints']??0,
                        'Net Pts' => ($teamStats['scoredPoints']??0) - ($teamStats['concededPoints']??0),
                    ];
                }
            }
        }


        usort($teamStandings, function ($teamA, $teamB) use ($sportSlug) {
            if (array_key_exists('Pts', $teamA)) {
                if ($teamA['Pts'] === $teamB['Pts']) {
                    return $teamB['GF'] <=> $teamA['GF'];
                }

                return $teamB['Pts'] <=> $teamA['Pts'];
            } elseif (array_key_exists('victory%', $teamA)) {
                if ($teamA['victory%'] === $teamB['victory%']) {
                    return $teamB['Diff'] <=> $teamA['Diff'];
                }

                return $teamB['victory%'] <=> $teamA['victory%'];
            }
            elseif (array_key_exists('PCT%', $teamA)) {
                if ($teamA['PCT%'] === $teamB['PCT%']) {
                    return $teamB['Net Pts'] <=> $teamA['Net Pts'];
                }

                return $teamB['PCT%'] <=> $teamA['PCT%'];
            }
        });

        file_put_contents(__DIR__ . '/../../src/json_data/standings_' . $date->format('Y-m-d') . '.json', json_encode($teamStandings));
        $io->success('Standings have been calculated and saved to standings_' . $date->format('Y-m-d') . '.json');
        return Command::SUCCESS;
    }
}
