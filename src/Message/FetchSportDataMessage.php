<?php

namespace App\Message;

class FetchSportDataMessage
{

    private string $filePath;
    private int $tournamentId;
    private string $sportSlug;

    public function __construct(string $filePath, int $tournamentId, string $sportSlug)
    {
        $this->filePath = $filePath;
        $this->tournamentId = $tournamentId;
        $this->sportSlug = $sportSlug;
    }

    public function getFilePath(): string
    {
        return $this->filePath;
    }

    public function getTournamentId(): int
    {
        return $this->tournamentId;
    }

    public function getSportSlug(): string
    {
        return $this->sportSlug;
    }
}