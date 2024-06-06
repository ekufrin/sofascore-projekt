<?php

namespace App\Controller;

use App\Entity\Tournament;
use App\Repository\TeamRepository;
use App\Repository\TournamentRepository;
use Knp\Component\Pager\PaginatorInterface as Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\Attribute\Groups;

class TournamentController extends AbstractController
{

    private $tournamentRepository;
    private $teamRepository;
    private $paginator;

    public function __construct(
        TournamentRepository $tournamentRepository,
        TeamRepository $teamRepository,
        Paginator $paginator
    ) {
        $this->tournamentRepository = $tournamentRepository;
        $this->teamRepository = $teamRepository;
        $this->paginator = $paginator;
    }

    #[Route('/tournament/detail/{id}', name: 'tournament_detail', methods: ['GET'])]
    #[Groups(['tournament_detail'])]
    public function detail(int $id): Tournament
    {
        $tournament = $this->tournamentRepository->findOneBy(['external_id' => $id]);
        if ($tournament === null) {
            throw $this->createNotFoundException('Tournament not found');
        }
        return $tournament;
    }

    #[Route('/tournament/{id}/events/{page}', name: 'tournament_events', methods: ['GET'])]
    #[Groups(['event_short_detail'])]
    public function events(int $id, int $page = 1): \Knp\Component\Pager\Pagination\PaginationInterface
    {
        $tournament = $this->tournamentRepository->findOneBy(['external_id' => $id]);
        if ($tournament === null) {
            throw $this->createNotFoundException('Tournament not found');
        }

        $events = $tournament->getEvents()->toArray();

        // Sortiranje po external id
        usort($events, function ($a, $b) {
            return $a->getExternalId() <=> $b->getExternalId();
        });

        return $this->paginator->paginate(
            $events,
            $page,
            10
        );
    }

    #[Route('/tournament/{id}/standings', name: 'tournament_standings', methods: ['GET'])]
    #[Groups(['standings'])]
    public function standings(int $id): array
    {
        $tournament = $this->tournamentRepository->findOneBy(['external_id' => $id]);
        if ($tournament === null) {
            throw $this->createNotFoundException('Tournament not found');
        }
        $events = $tournament->getEvents();

        $teamStandings = [];
        $teams = [];

        foreach ($events as $event) {
            if($event->getStatus() === 'finished'){
                $winnerCode = $event->getWinnerCode();
                $homeTeam = $event->getHomeTeam();
                $awayTeam = $event->getAwayTeam();

                if ($tournament->getSport()->getSlug() === 'football') {
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
                } elseif ($tournament->getSport()->getSlug() === 'basketball') {
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
                } elseif ($tournament->getSport()->getSlug() === 'american-football') {
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
                if ($tournament->getSport()->getSlug() === 'football') {
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
                } elseif ($tournament->getSport()->getSlug() === 'basketball') {
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
                elseif ($tournament->getSport()->getSlug() === 'american-football') {
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

        if(empty($teamStandings)){
            throw $this->createNotFoundException('No standings found for this tournament');
        }

        usort($teamStandings, function ($teamA, $teamB) use ($tournament) {
            if ($tournament->getSport()->getSlug() === 'football') {
                if ($teamA['Pts'] === $teamB['Pts']) {
                    return $teamB['GD'] <=> $teamA['GD'];
                }

                return $teamB['Pts'] <=> $teamA['Pts'];
            } elseif ($tournament->getSport()->getSlug() === 'basketball') {
                if ($teamA['victory%'] === $teamB['victory%']) {
                    return $teamB['Diff'] <=> $teamA['Diff'];
                }

                return $teamB['victory%'] <=> $teamA['victory%'];
            }
            elseif ($tournament->getSport()->getSlug() === 'american-football') {
                if ($teamA['PCT%'] === $teamB['PCT%']) {
                    return $teamB['Net Pts'] <=> $teamA['Net Pts'];
                }

                return $teamB['PCT%'] <=> $teamA['PCT%'];
            }
        });

        return $teamStandings;
    }
}