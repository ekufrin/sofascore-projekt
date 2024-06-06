<?php

namespace App\Command;

use App\Entity\Country;
use App\Entity\Sport;
use App\Entity\Tournament;
use App\Message\FetchSportDataMessage;
use App\Service\Provider;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Symfony\Component\Messenger\MessageBusInterface;

#[AsCommand(
    name: 'FetchAllData',
    description: 'Fetch all data from Provider',
)]
class FetchAllDataCommand extends Command
{

    private $apiClient;
    private $bus;
    private $entityManager;

    public function __construct(Provider $apiClient, MessageBusInterface $bus,EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->apiClient = $apiClient;
        $this->bus = $bus;
        $this->entityManager = $entityManager;
    }

    protected function configure(): void
    {
        $this->setDescription('Fetches all data from SofaScore API')
            ->addArgument('sportName', InputArgument::REQUIRED, 'Type name of sport for which you want to fetch data.');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
            $io = new SymfonyStyle($input, $output);

            $sportName = $input->getArgument('sportName');

            $sportsData = $this->apiClient->fetchData('sports');

            $sportData = array_filter($sportsData, function($sport) use ($sportName) {
                return $sport['name'] === $sportName;});

        if (!empty($sportData)) {
            $sportData = reset($sportData);

            $sport = $this->entityManager->getRepository(Sport::class)->findOneBy(
                ['external_id' => $sportData['id']]
            );
            if ($sport === null) {
                $sport = new Sport();
                $sport->setExternalId($sportData['id']);
                $sport->setName($sportData['name']);
                $sport->setSlug($sportData['slug']);
                $this->entityManager->persist($sport);
            }

            $tournaments = $this->apiClient->fetchData('sport/' . $sport->getSlug() . '/tournaments');
            $filePath = __DIR__ . '/../../src/json_data/tournaments_' . $sport->getSlug() . '.json';
            file_put_contents($filePath, json_encode($tournaments));

            foreach ($tournaments as $tournamentData) {
                $tournament = $this->entityManager->getRepository(Tournament::class)->findOneBy(
                    ['external_id' => $tournamentData['id']]
                );
                if ($tournament === null) {
                    $tournament = new Tournament();
                    $tournament->setExternalId($tournamentData['id']);
                    $tournament->setName($tournamentData['name']);
                    $tournament->setSlug($tournamentData['slug']);
                    $tournament->setSport($sport);
                }

                $country = $this->entityManager->getRepository(Country::class)->findOneBy(
                    ['external_id' => $tournamentData['country']['id']]
                );

                if ($country === null) {
                    $country = new Country();
                    $country->setExternalId($tournamentData['country']['id']);
                    $country->setName($tournamentData['country']['name']);
                    $this->entityManager->persist($country);
                }

                $tournament->setCountry($country);

                $this->entityManager->persist($tournament);
                $this->entityManager->flush();

                $io->info('Fetching tournament: ' . $tournament->getName() . '...'  . PHP_EOL);
                $this->bus->dispatch(new FetchSportDataMessage($filePath, $tournament->getExternalId(), $tournament->getSport()->getSlug()));

            }
            $io->success('Data fetched successfully for sport ' . $sportName . '!');
        }else{
            throw new \Symfony\Component\Console\Exception\InvalidArgumentException('Sport ' . $sportName .' not found!' . PHP_EOL . 'Please check the name of the sport and try again.');
        }

        $this->entityManager->flush();

        return Command::SUCCESS;
    }
}