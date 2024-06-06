<?php

namespace App\Entity;

use App\Repository\TeamRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;

#[ORM\Entity(repositoryClass: TeamRepository::class)]
class Team
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['event_detail','tournament_detail','team_detail','player_detail','event_short_detail','standings','player_events'])]
    private ?string $name = null;

    #[ORM\ManyToOne(inversedBy: 'teams')]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['team_detail','event_short_detail'])]
    private ?Country $country = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $managerName = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $venue = null;

    #[ORM\OneToMany(targetEntity: Event::class, mappedBy: 'homeTeam')]
    #[Groups('team_detail')]
    private Collection $homeEvents;

    #[ORM\OneToMany(targetEntity: Event::class, mappedBy: 'awayTeam')]
    #[Groups('team_detail')]
    private Collection $awayEvents;
    #[ORM\Column]
    #[Groups(['tournament_detail','team_detail','player_detail'])]
    private ?int $external_id = null;

    #[ORM\OneToMany(targetEntity: Player::class, mappedBy: 'team')]
    #[Groups(['event_detail','team_detail'])]
    private Collection $players;

    public function __construct()
    {
        $this->homeEvents = new ArrayCollection();
        $this->awayEvents = new ArrayCollection();
        $this->players = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getCountry(): ?Country
    {
        return $this->country;
    }

    public function setCountry(?Country $country): static
    {
        $this->country = $country;

        return $this;
    }

    public function getManagerName(): ?string
    {
        return $this->managerName;
    }

    public function setManagerName(?string $managerName): static
    {
        $this->managerName = $managerName;

        return $this;
    }

    public function getVenue(): ?string
    {
        return $this->venue;
    }

    public function setVenue(?string $venue): static
    {
        $this->venue = $venue;

        return $this;
    }

    /**
     * @return Collection<int, Event>
     */
    public function getHomeEvents(): Collection
    {
        return $this->homeEvents;
    }

    /**
     * @return Collection<int, Event>
     */
    public function getAwayEvents(): Collection
    {
        return $this->awayEvents;
    }

    public function addEvent(Event $event): static
    {
        if (!$this->events->contains($event)) {
            $this->events->add($event);
            $event->setHomeTeam($this);
        }

        return $this;
    }

    public function removeEvent(Event $event): static
    {
        if ($this->events->removeElement($event)) {
            // set the owning side to null (unless already changed)
            if ($event->getHomeTeam() === $this) {
                $event->setHomeTeam(null);
            }
        }

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

    /**
     * @return Collection<int, Player>
     */
    public function getPlayers(): Collection
    {
        return $this->players;
    }

    public function addPlayer(Player $player): static
    {
        if (!$this->players->contains($player)) {
            $this->players->add($player);
            $player->setTeam($this);
        }

        return $this;
    }

    public function removePlayer(Player $player): static
    {
        if ($this->players->removeElement($player)) {
            if ($player->getTeam() === $this) {
                $player->setTeam(null);
            }
        }

        return $this;
    }
}
