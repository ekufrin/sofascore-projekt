<?php

namespace App\Controller;

use App\Entity\Event;
use App\Repository\EventRepository;
use Knp\Component\Pager\PaginatorInterface as Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\Attribute\Groups;

class EventController extends AbstractController
{
    private $eventRepository;
    private $paginator;

    public function __construct(EventRepository $eventRepository, Paginator $paginator)
    {
        $this->eventRepository = $eventRepository;
        $this->paginator = $paginator;
    }

    #[Route('/event/detail/{id}', name: 'event_detail', methods: ['GET'])]
    #[Groups(['event_detail'])]
    public function detail(int $id): Event
    {
        $event = $this->eventRepository->findOneBy(['external_id' => $id]);
        if($event === null){
            throw $this->createNotFoundException('Event not found');
        }
        return $event;
    }

    #[Route('/event/sport/{slug}/date/{date}/page/{page}', name: 'event_sport_date', methods: ['GET'])]
    #[Groups(['event_short_detail'])]
    public function events(string $slug, string $date, int $page = 1): \Knp\Component\Pager\Pagination\PaginationInterface
    {
        $date = \DateTime::createFromFormat('Y-m-d H:i:s', urldecode($date));

        $events = $this->eventRepository->findBy([
            'startDate' => $date
        ]);
        if($events === null){
            throw $this->createNotFoundException('Tournament not found');
        }

        foreach ($events as $event) {
            if($event->getTournament()->getSport()->getSlug() !== $slug){
                unset($events[array_search($event, $events)]);
            }
        }

        // Sortiranje po external id
        usort($events, function($a, $b) {
            return $a->getExternalId() <=> $b->getExternalId();
        });

        return $this->paginator->paginate(
            $events,
            $page,
            10
        );
    }
}