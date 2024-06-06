<?php

namespace App\Command;

use App\Entity\Country;
use App\Entity\Score;
use App\Entity\Sport;
use App\Entity\Team;
use App\Entity\Tournament;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use App\Service\Provider;
use App\Repository\EventRepository;
use Doctrine\ORM\EntityManagerInterface;

#[AsCommand(
    name: 'UpdateEventCommand',
    description: 'Update event information',
)]
class UpdateEventCommand extends Command
{
    private EventRepository $eventRepository;
    private Provider $provider;
    private EntityManagerInterface $entityManager;

    public function __construct(EventRepository $eventRepository, Provider $provider, EntityManagerInterface $entityManager)
    {
        $this->eventRepository = $eventRepository;
        $this->provider = $provider;
        $this->entityManager = $entityManager;

        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addArgument('external_id', InputArgument::REQUIRED, 'External ID of the event')
            ->addArgument('date', InputArgument::REQUIRED, 'Date of the event')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $external_id = $input->getArgument('external_id');
        $date = \DateTime::createFromFormat('Y-m-d H:i:s', $input->getArgument('date'));

        $event = $this->eventRepository->findOneBy(['external_id' => $external_id, 'startDate' => $date]);

        if ($event) {
            $updatedEventData = $this->provider->fetchData('event/' . $external_id);

            $sportRepository = $this->entityManager->getRepository(Sport::class);
            $tournamentRepository = $this->entityManager->getRepository(Tournament::class);
            $countryRepository = $this->entityManager->getRepository(Country::class);
            $teamRepository = $this->entityManager->getRepository(Team::class);
            $scoreRepository = $this->entityManager->getRepository(Score::class);



            $startDate = \DateTime::createFromFormat('Y-m-d\TH:i:sP', $updatedEventData['startDate']);
            $event->setStartDate($startDate);
            $event->setExternalId($updatedEventData['id']);
            $event->setRound($updatedEventData['round']?? null);
            $event->setStatus($updatedEventData['status']?? null);
            $event->setWinnerCode($updatedEventData['winnerCode']?? null);
            $event->setSlug($updatedEventData['slug']);

            $homeTeam = $teamRepository->findOneBy(['external_id' => $updatedEventData['homeTeam']['id']]);
            if (!$homeTeam) {
                $homeTeam = new Team();
                $homeTeam->setName($updatedEventData['homeTeam']['name']);
                $homeTeam->setExternalId($updatedEventData['homeTeam']['id']);
                $homeTeamCountry = $countryRepository->findOneBy(['external_id' => $updatedEventData['homeTeam']['country']['id']]);
                if (!$homeTeamCountry) {
                    $homeTeamCountry = new Country();
                    $homeTeamCountry->setName($updatedEventData['homeTeam']['country']['name']);
                    $homeTeamCountry->setExternalId($updatedEventData['homeTeam']['country']['id']);
                }
                $homeTeam->setCountry($homeTeamCountry);
            }

            $awayTeam = $teamRepository->findOneBy(['external_id' => $updatedEventData['awayTeam']['id']]);
            if (!$awayTeam) {
                $awayTeam = new Team();
                $awayTeam->setName($updatedEventData['awayTeam']['name']);
                $awayTeam->setExternalId($updatedEventData['awayTeam']['id']);
                $awayTeamCountry = $countryRepository->findOneBy(['external_id' => $updatedEventData['awayTeam']['country']['id']]);
                if (!$awayTeamCountry) {
                    $awayTeamCountry = new Country();
                    $awayTeamCountry->setName($updatedEventData['awayTeam']['country']['name']);
                    $awayTeamCountry->setExternalId($updatedEventData['awayTeam']['country']['id']);
                }
                $awayTeam->setCountry($awayTeamCountry);
            }

            $homeScore = $scoreRepository->findOneBy(['external_id' => $event->getHomeScore()->getExternalId()]);
            if ($homeScore) {
                $homeScore->setTotal($updatedEventData['homeScore']['total']?? null);
                $homeScore->setPeriod1($updatedEventData['homeScore']['period1']?? null);
                $homeScore->setPeriod2($updatedEventData['homeScore']['period2']?? null);
                $homeScore->setPeriod3($updatedEventData['homeScore']['period3']?? null);
                $homeScore->setPeriod4($updatedEventData['homeScore']['period4']?? null);
                $homeScore->setOvertime($updatedEventData['homeScore']['overtime']?? null);
            }

            $awayScore = $scoreRepository->findOneBy(['external_id' => $event->getAwayScore()->getExternalId()]);
            if ($awayScore) {
                $awayScore->setTotal($updatedEventData['awayScore']['total'] ?? null);
                $awayScore->setPeriod1($updatedEventData['awayScore']['period1']?? null);
                $awayScore->setPeriod2($updatedEventData['awayScore']['period2']?? null);
                $awayScore->setPeriod3($updatedEventData['awayScore']['period3'] ?? null);
                $awayScore->setPeriod4($updatedEventData['awayScore']['period4'] ?? null);
                $awayScore->setOvertime($updatedEventData['awayScore']['overtime'] ?? null);
            }
            $tournament = $tournamentRepository->findOneBy(['external_id' => $updatedEventData['tournament']['id']]);
            if (!$tournament) {
                $tournament = new Tournament();
                $tournament->setName($updatedEventData['tournament']['name']);
                $tournament->setExternalId($updatedEventData['tournament']['id']);
                $tournament->setSlug($updatedEventData['tournament']['slug']);
            }

            $sport = $sportRepository->findOneBy(['external_id' => $updatedEventData['tournament']['sport']['id']]);
            if (!$sport) {
                $sport = new Sport();
                $sport->setName($updatedEventData['tournament']['sport']['name']);
                $sport->setExternalId($updatedEventData['tournament']['sport']['id']);
                $sport->setSlug($updatedEventData['tournament']['sport']['slug']);
            }

            $country = $countryRepository->findOneBy(['external_id' => $updatedEventData['tournament']['country']['id']]);
            if (!$country) {
                $country = new Country();
                $country->setName($updatedEventData['tournament']['country']['name']);
                $country->setExternalId($updatedEventData['tournament']['country']['id']);
            }
            $tournament->setSport($sport);
            $tournament->setCountry($country);
            $event->setTournament($tournament);
            $event->setHomeScore($homeScore);
            $event->setAwayScore($awayScore);

            $this->entityManager->persist($event);
            $this->entityManager->persist($homeTeam);
            $this->entityManager->persist($awayTeam);
            $this->entityManager->persist($sport);
            $this->entityManager->persist($country);
            $this->entityManager->persist($tournament);
            $this->entityManager->persist($homeScore);
            $this->entityManager->persist($awayScore);
            $this->entityManager->flush();

            $io->success('Event updated successfully.');
        } else {
            $io->error('Event not found.');
        }

        return Command::SUCCESS;
    }
}