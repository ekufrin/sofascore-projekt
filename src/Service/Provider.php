<?php

namespace App\Service;

use Symfony\Contracts\HttpClient\HttpClientInterface;

class Provider
{
    private HttpClientInterface $httpClient;
    private string $baseUrl;

    public function __construct(HttpClientInterface $httpClient, $baseUrl)
    {
        $this->httpClient = $httpClient;
        $this->baseUrl = $baseUrl;
    }

    public function fetchData(string $endpoint): array
    {
        $response = $this->httpClient->request('GET', $this->baseUrl . $endpoint);
        return $response->toArray();
    }
}