<?php

namespace App\Controller;

use App\Entity\Player;
use App\Repository\PlayerRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\Attribute\Groups;

class PlayerController extends AbstractController
{
    private PlayerRepository $playerRepository;
    private $paginator;

    public function __construct(PlayerRepository $playerRepository, PaginatorInterface $paginator)
    {
        $this->playerRepository = $playerRepository;
        $this->paginator = $paginator;
    }
    #[Route('/player/detail/{id}', name: 'player_detail',methods: ['GET'])]
    #[Groups('player_detail')]
    public function detail(int $id): Player
    {
        $player = $this->playerRepository->findOneBy(['external_id' => $id]);
        if($player === null){
            throw $this->createNotFoundException('Player not found');
        }
        return $player;
    }

    #[Route('/player/search/{name}', name: 'player_search', methods: ['GET'])]
    #[Groups('player_detail')]
    public function search(string $name): Player
    {
        $name = strtolower($name);
        $team = $this->playerRepository->createQueryBuilder('t')
            ->where('LOWER(t.name) LIKE :name')
            ->setParameter('name', '%' . $name . '%')
            ->getQuery()
            ->getOneOrNullResult();
        if (empty($team)) {
            throw $this->createNotFoundException('Player not found');
        }
        return $team;
    }

    #[Route('/player/{id}/events/{page}', name: 'player_events', methods: ['GET'])]
    #[Groups('player_events')]
    public function events(int $id, int $page = 1): \Knp\Component\Pager\Pagination\PaginationInterface
    {
        $player = $this->playerRepository->findOneBy(['external_id' => $id]);
        if($player === null){
            throw $this->createNotFoundException('Player not found');
        }

        $events = $player->getPlayerEvents();

        if ($events->isEmpty()) {
            throw $this->createNotFoundException('No events found for this player');
        }


        return $this->paginator->paginate(
            $events,
            $page,
            10
        );
    }
}