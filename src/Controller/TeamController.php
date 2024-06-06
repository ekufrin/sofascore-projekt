<?php

namespace App\Controller;

use App\Entity\Team;
use App\Repository\TeamRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\Attribute\Groups;

class TeamController extends AbstractController
{
    private TeamRepository $teamRepository;
    private $paginator;

    public function __construct(TeamRepository $teamRepository, PaginatorInterface $paginator)
    {
        $this->teamRepository = $teamRepository;
        $this->paginator = $paginator;
    }

    #[Route('/team/detail/{id}', name: 'team_detail', methods: ['GET'])]
    #[Groups('team_detail')]
    public function detail(int $id): Team
    {
        $team = $this->teamRepository->findOneBy(['external_id' => $id]);
        if ($team === null) {
            throw $this->createNotFoundException('Team not found');
        }
        return $team;
    }

    #[Route('/team/{id}/events/{page}', name: 'team_events', methods: ['GET'])]
    #[Groups(['event_short_detail'])]
    public function events(int $id, int $page = 1): \Knp\Component\Pager\Pagination\PaginationInterface
    {
        $team = $this->teamRepository->findOneBy(['external_id' => $id]);
        if ($team === null) {
            throw $this->createNotFoundException('Team not found');
        }

        $events = $team->getHomeEvents()->toArray();
        $events = array_merge($events, $team->getAwayEvents()->toArray());

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

    #[Route('/team/search/{name}', name: 'team_search', methods: ['GET'])]
    #[Groups('team_detail')]
    public function search(string $name): Team
    {
        $name = strtolower($name);
        $team = $this->teamRepository->createQueryBuilder('t')
            ->where('LOWER(t.name) LIKE :name')
            ->setParameter('name', '%' . $name . '%')
            ->getQuery()
            ->getOneOrNullResult();
        if (empty($team)) {
            throw $this->createNotFoundException('Team not found');
        }
        return $team;
    }
}