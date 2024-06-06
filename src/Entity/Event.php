<?php

namespace App\Entity;

use App\Repository\EventRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;

#[ORM\Entity(repositoryClass: EventRepository::class)]
class Event
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['event_detail','team_detail','event_short_detail','player_events'])]
    private ?string $slug = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE, nullable: true)]
    #[Groups(['event_detail','team_detail','event_short_detail','player_events'])]
    private ?\DateTimeInterface $startDate = null;

    #[ORM\Column]
    private ?int $round = null;

    #[ORM\ManyToOne(inversedBy: 'events')]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['event_detail'])]
    private ?Tournament $tournament = null;

    #[ORM\ManyToOne(inversedBy: 'homeEvents')]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['event_detail','event_short_detail','player_events'])]
    private ?Team $homeTeam = null;

    #[ORM\ManyToOne(inversedBy: 'awayEvents')]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['event_detail','event_short_detail','player_events'])]
    private ?Team $awayTeam = null;

    #[ORM\Column(length: 255)]
    #[Groups(['event_detail','team_detail','event_short_detail','player_events'])]
    private ?string $status = null;

    #[ORM\ManyToOne(inversedBy: 'homeEvents')]
    #[ORM\JoinColumn(nullable: true)]
    #[Groups(['event_detail','event_short_detail','player_events'])]
    private ?Score $homeScore = null;

    #[ORM\ManyToOne(inversedBy: 'awayEvents')]
    #[ORM\JoinColumn(nullable: true)]
    #[Groups(['event_detail','event_short_detail','player_events'])]
    private ?Score $awayScore = null;

    #[ORM\Column(length: 255, nullable: true)]
    #[Groups(['event_detail','event_short_detail','player_events'])]
    private ?string $winnerCode = null;

    #[ORM\Column]
    #[Groups(['event_detail','team_detail','event_short_detail','player_events'])]
    private ?int $external_id = null;


    /**
     * @var Collection<int, PlayerEvents>
     */
    #[ORM\OneToMany(targetEntity: PlayerEvents::class, mappedBy: 'event')]
    private Collection $playerEvents;

    public function __construct()
    {
        $this->playerEvents = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(int $id): static
    {
        $this->id = $id;

        return $this;
    }

    public function getSlug(): ?string
    {
        return $this->slug;
    }

    public function setSlug(string $slug): static
    {
        $this->slug = $slug;

        return $this;
    }

    public function getStartDate(): ?\DateTimeInterface
    {
        return $this->startDate;
    }

    public function setStartDate(?\DateTimeInterface $startDate): static
    {
        $this->startDate = $startDate;

        return $this;
    }

    public function getRound(): ?int
    {
        return $this->round;
    }

    public function setRound(int $round): static
    {
        $this->round = $round;

        return $this;
    }

    public function getTournament(): ?Tournament
    {
        return $this->tournament;
    }

    public function setTournament(?Tournament $tournament): static
    {
        $this->tournament = $tournament;

        return $this;
    }

    public function getHomeTeam(): ?Team
    {
        return $this->homeTeam;
    }

    public function setHomeTeam(?Team $homeTeam): static
    {
        $this->homeTeam = $homeTeam;

        return $this;
    }

    public function getAwayTeam(): ?Team
    {
        return $this->awayTeam;
    }

    public function setAwayTeam(?Team $awayTeam): static
    {
        $this->awayTeam = $awayTeam;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): static
    {
        $this->status = $status;

        return $this;
    }

    public function getHomeScore(): ?Score
    {
        return $this->homeScore;
    }

    public function setHomeScore(?Score $homeScore): static
    {
        $this->homeScore = $homeScore;

        return $this;
    }

    public function getAwayScore(): ?Score
    {
        return $this->awayScore;
    }

    public function setAwayScore(?Score $awayScore): static
    {
        $this->awayScore = $awayScore;

        return $this;
    }

    public function getWinnerCode(): ?string
    {
        return $this->winnerCode;
    }

    public function setWinnerCode(?string $winnerCode): static
    {
        $this->winnerCode = $winnerCode;

        return $this;
    }

    public function getExternalId(): ?int
    {
        return $this->external_id;
    }

    public function setExternalId(int $external_id): static
    {
        $this->external_id = $external_id;

        return $this;
    }

    public function addPlayer(Player $player): self
    {
        if (!$this->players->contains($player)) {
            $this->players[] = $player;
            $player->addPlayedEvent($this);
        }

        return $this;
    }

    /**
     * @return Collection<int, PlayerEvents>
     */
    public function getPlayerEvents(): Collection
    {
        return $this->playerEvents;
    }

    public function addPlayerEvent(PlayerEvents $playerEvent): static
    {
        if (!$this->playerEvents->contains($playerEvent)) {
            $this->playerEvents->add($playerEvent);
            $playerEvent->setEvent($this);
        }

        return $this;
    }

    public function removePlayerEvent(PlayerEvents $playerEvent): static
    {
        if ($this->playerEvents->removeElement($playerEvent)) {
            // set the owning side to null (unless already changed)
            if ($playerEvent->getEvent() === $this) {
                $playerEvent->setEvent(null);
            }
        }

        return $this;
    }



}
