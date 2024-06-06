<?php

namespace App\Entity;

use App\Repository\ScoreRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;

#[ORM\Entity(repositoryClass: ScoreRepository::class)]
class Score
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['event_detail','event_short_detail','player_events'])]
    private ?int $total = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['player_events'])]
    private ?int $period1 = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['player_events'])]
    private ?int $period2 = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['player_events'])]
    private ?int $period3 = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['player_events'])]
    private ?int $period4 = null;

    #[ORM\Column(nullable: true)]
    #[Groups(['player_events'])]
    private ?int $overtime = null;

    #[ORM\OneToMany(targetEntity: Event::class, mappedBy: 'homeScore')]
    private Collection $homeEvents;

    #[ORM\OneToMany(targetEntity: Event::class, mappedBy: 'awayScore')]
    private Collection $awayEvents;

    #[ORM\Column]
    private ?int $external_id = null;

    public function __construct()
    {
        $this->homeEvents = new ArrayCollection();
        $this->awayEvents = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTotal(): ?int
    {
        return $this->total;
    }

    public function setTotal(?int $total): static
    {
        $this->total = $total;

        return $this;
    }

    public function getPeriod1(): ?int
    {
        return $this->period1;
    }

    public function setPeriod1(?int $period1): static
    {
        $this->period1 = $period1;

        return $this;
    }

    public function getPeriod2(): ?int
    {
        return $this->period2;
    }

    public function setPeriod2(?int $period2): static
    {
        $this->period2 = $period2;

        return $this;
    }

    public function getPeriod3(): ?int
    {
        return $this->period3;
    }

    public function setPeriod3(?int $period3): static
    {
        $this->period3 = $period3;

        return $this;
    }

    public function getPeriod4(): ?int
    {
        return $this->period4;
    }

    public function setPeriod4(?int $period4): static
    {
        $this->period4 = $period4;

        return $this;
    }

    public function getOvertime(): ?int
    {
        return $this->overtime;
    }

    public function setOvertime(?int $overtime): static
    {
        $this->overtime = $overtime;

        return $this;
    }

    /**
     * @return Collection<int, Event>
     */
    public function getEvents(): Collection
    {
        return $this->events;
    }

    public function addEvent(Event $event): static
    {
        if (!$this->events->contains($event)) {
            $this->events->add($event);
            $event->setHomeScore($this);
        }

        return $this;
    }

    public function removeEvent(Event $event): static
    {
        if ($this->events->removeElement($event)) {
            // set the owning side to null (unless already changed)
            if ($event->getHomeScore() === $this) {
                $event->setHomeScore(null);
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
}
