<?php

namespace App\Entity;

use App\Repository\PlayerRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;

#[ORM\Entity(repositoryClass: PlayerRepository::class)]
class Player
{

    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['event_detail','team_detail','player_detail'])]
    private ?string $name = null;

    #[ORM\Column(length: 255)]
    private ?string $slug = null;

    #[ORM\Column(length: 255)]
    #[Groups(['event_detail','player_detail'])]
    private ?string $position = null;

    #[ORM\ManyToOne(inversedBy: 'players')]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['event_detail','team_detail','player_detail'])]
    private ?Country $country = null;

    #[ORM\OneToMany(targetEntity: Incident::class, mappedBy: 'player')]
    private Collection $incidents;

    #[ORM\Column]
    #[Groups(['event_detail','player_detail'])]
    private ?int $external_id = null;

    #[ORM\ManyToOne(inversedBy: 'players')]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['player_detail'])]
    private ?Team $team = null;

    /**
     * @var Collection<int, PlayerEvents>
     */
    #[ORM\OneToMany(targetEntity: PlayerEvents::class, mappedBy: 'player')]
    private Collection $playerEvents;

    public function __construct()
    {
        $this->incidents = new ArrayCollection();
        $this->playerEvents = new ArrayCollection();
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

    public function getSlug(): ?string
    {
        return $this->slug;
    }

    public function setSlug(string $slug): static
    {
        $this->slug = $slug;

        return $this;
    }

    public function getPosition(): ?string
    {
        return $this->position;
    }

    public function setPosition(string $position): static
    {
        $this->position = $position;

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

    /**
     * @return Collection<int, Incident>
     */
    public function getIncidents(): Collection
    {
        return $this->incidents;
    }

    public function addIncident(Incident $incident): static
    {
        if (!$this->incidents->contains($incident)) {
            $this->incidents->add($incident);
            $incident->setPlayer($this);
        }

        return $this;
    }

    public function removeIncident(Incident $incident): static
    {
        if ($this->incidents->removeElement($incident)) {
            // set the owning side to null (unless already changed)
            if ($incident->getPlayer() === $this) {
                $incident->setPlayer(null);
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

    public function getTeam(): ?Team
    {
        return $this->team;
    }

    public function setTeam(?Team $team): static
    {
        $this->team = $team;

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
            $playerEvent->setPlayer($this);
        }

        return $this;
    }

    public function removePlayerEvent(PlayerEvents $playerEvent): static
    {
        if ($this->playerEvents->removeElement($playerEvent)) {
            // set the owning side to null (unless already changed)
            if ($playerEvent->getPlayer() === $this) {
                $playerEvent->setPlayer(null);
            }
        }

        return $this;
    }
}
