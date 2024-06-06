<?php

namespace App\MessageHandler;

use App\Entity\Country;
use App\Entity\Event;
use App\Entity\Incident;
use App\Entity\Player;
use App\Entity\PlayerEvents;
use App\Entity\Score;
use App\Entity\Team;
use App\Entity\Tournament;
use App\Message\FetchSportDataMessage;
use App\Service\Provider;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;

#[AsMessageHandler]
class FetchSportDataMessageHandler
{
    private EntityManagerInterface $entityManager;
    private Provider $apiClient;

    public function __construct(EntityManagerInterface $entityManager, Provider $apiClient)
    {
        $this->entityManager = $entityManager;
        $this->apiClient = $apiClient;
    }

    public function __invoke(FetchSportDataMessage $message): void
    {
        $tournamentId = $message->getTournamentId();
        $n = 0;
        $allEvents = [];
        while (true) {
            $pastEvents = $this->apiClient->fetchData("tournament/{$tournamentId}/events/last/{$n}");
            $nextEvents = $this->apiClient->fetchData("tournament/{$tournamentId}/events/next/{$n}");

            if (empty($pastEvents) && empty($nextEvents)) {
                break;
            }

            $allEvents = array_merge($allEvents, $pastEvents, $nextEvents);
            $n++;
        }
        foreach ($allEvents as $finishedEvent) {
            $tournament = $this->entityManager->getRepository(Tournament::class)->findOneBy(
                ['external_id' => $finishedEvent['tournament']['id']]
            );
            $event = new Event();
            $event->setExternalId($finishedEvent['id']);
            $event->setSlug($finishedEvent['slug']);
            $event->setTournament($tournament);
            $event->setStartDate(new \DateTime($finishedEvent['startDate']));
            $event->setStatus($finishedEvent['status']);
            $event->setRound($finishedEvent['round']);
            $event->setWinnerCode($finishedEvent['winnerCode'] ?? null);

            $homeScore = new Score();
            $awayScore = new Score();

            $homeTeam = $this->createTeam($finishedEvent['homeTeam']);
            $awayTeam = $this->createTeam($finishedEvent['awayTeam']);

            $homeScore->setExternalId($finishedEvent['id']);
            $homeScore->setTotal($finishedEvent['homeScore']['total'] ?? null);
            $homeScore->setPeriod1($finishedEvent['homeScore']['period1'] ?? null);
            $homeScore->setPeriod2($finishedEvent['homeScore']['period2'] ?? null);
            $homeScore->setPeriod3($finishedEvent['homeScore']['period3'] ?? null);
            $homeScore->setPeriod4($finishedEvent['homeScore']['period4'] ?? null);
            $homeScore->setOvertime($finishedEvent['homeScore']['overtime'] ?? null);

            $awayScore->setExternalId($finishedEvent['id']);
            $awayScore->setPeriod1($finishedEvent['awayScore']['period1'] ?? null);
            $awayScore->setPeriod2($finishedEvent['awayScore']['period2'] ?? null);
            $awayScore->setPeriod3($finishedEvent['awayScore']['period3'] ?? null);
            $awayScore->setPeriod4($finishedEvent['awayScore']['period4'] ?? null);
            $awayScore->setOvertime($finishedEvent['awayScore']['overtime'] ?? null);
            $awayScore->setTotal($finishedEvent['awayScore']['total'] ?? null);

            $event->setHomeTeam($homeTeam);
            $event->setAwayTeam($awayTeam);
            $event->setHomeScore($homeScore);
            $event->setAwayScore($awayScore);

            $this->entityManager->persist($event);
            $this->entityManager->persist($homeScore);
            $this->entityManager->persist($awayScore);
            $this->entityManager->persist($homeTeam);
            $this->entityManager->persist($awayTeam);
            $this->entityManager->flush();

            $this->fetchAndCreatePlayers($homeTeam);
            $this->fetchAndCreatePlayers($awayTeam);

            set_time_limit(300);
            $incidents = $this->apiClient->fetchData("event/{$event->getExternalId()}/incidents");

            if(empty($incidents)){
                $this->entityManager->flush();
                continue;
            }

            foreach ($incidents as $incidentData) {
                $incident = new Incident();
                if (isset($incidentData['player'])) {
                    $incident->setPlayer($this->entityManager->getRepository(Player::class)->findOneBy(
                        ['external_id' => $incidentData['player']['id']]
                    ));}
                $incident->setExternalId($incidentData['id']);
                $incident->setType($incidentData['type']);
                $incident->setTime($incidentData['time']);
                // Goal
                $incident->setScoringTeam($incidentData['scoringTeam'] ?? null);
                $incident->setHomeScore($incidentData['homeScore'] ?? null);
                $incident->setAwayScore($incidentData['awayScore'] ?? null);
                $incident->setGoalType($incidentData['goalType'] ?? null);
                // Card
                $incident->setColor($incidentData['color'] ?? null);
                $incident->setTeamSide($incidentData['teamSide'] ?? null);
                // Period
                $incident->setText($incidentData['text'] ?? null);

                $this->entityManager->persist($incident);
            }

            $this->entityManager->flush();
        }
    }

    private function createCountry($countryData): Country
    {
        $country = $this->entityManager->getRepository(Country::class)->findOneBy(
            ['external_id' => $countryData['id']]
        );

        if ($country === null) {
            $country = new Country();
            $country->setExternalId($countryData['id']);
            $country->setName($countryData['name']);
            $this->entityManager->persist($country);
        }

        return $country;
    }

    private function createTeam($teamData): Team
    {
        $team = $this->entityManager->getRepository(Team::class)->findOneBy(
            ['external_id' => $teamData['id']]
        );

        if ($team === null) {
            $team = new Team();
            $team->setExternalId($teamData['id']);
            $team->setName($teamData['name']);
            $team->setCountry($this->createCountry($teamData['country']));
            $this->entityManager->persist($team);
        }

        return $team;
    }

    private function fetchAndCreatePlayers(Team $team): void
    {
        $teamPlayers = $this->apiClient->fetchData("team/{$team->getExternalId()}/players");

        foreach ($teamPlayers as $playerData) {
            $existingPlayer = $this->entityManager->getRepository(Player::class)->findOneBy(
                ['external_id' => $playerData['id']]
            );

            if ($existingPlayer === null) {
                $player = new Player();
                $player->setExternalId($playerData['id']);
                $player->setName($playerData['name']);
                $player->setSlug($playerData['slug']);
                $playerCountry = $this->createCountry($playerData['country']);
                $player->setCountry($playerCountry);
                $player->setPosition($playerData['position']);
                $player->setTeam($team);
                $this->entityManager->persist($player);
                $this->entityManager->flush();
            }

            $this->fetchAndCreatePlayerEvents($playerData);
        }
    }

    private function fetchAndCreatePlayerEvents($playerData): void
    {
        $playerEventsPage = 0;

        while (true) {
            $playerEvents = $this->apiClient->fetchData("player/{$playerData['id']}/events/last/{$playerEventsPage}");

            if (empty($playerEvents)) {
                break;
            }

            foreach ($playerEvents as $playerEventData) {
                $existingEvent = $this->entityManager->getRepository(Event::class)->findOneBy(
                    ['external_id' => $playerEventData['id']]
                );
                $player = $this->entityManager->getRepository(Player::class)->findOneBy(['external_id' => $playerData['id']]);

                $existingPlayerEvent = $this->entityManager->getRepository(PlayerEvents::class)->findOneBy(
                    ['player' => $player, 'event' => $existingEvent]
                );

                if ($existingEvent !== null && $existingEvent->getStatus() !== 'finished') {
                    continue;
                }

                if ($player !== null and $existingEvent !== null and $existingPlayerEvent === null) {
                    $pEvent = new PlayerEvents();
                    $pEvent->setPlayer($player);
                    $pEvent->setEvent($existingEvent);
                    $this->entityManager->persist($pEvent);
                }
            }

            $this->entityManager->flush();
            $playerEventsPage++;
        }
    }
}