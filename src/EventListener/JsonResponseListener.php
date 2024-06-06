<?php

namespace App\EventListener;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Event\ViewEvent;
use Symfony\Component\Serializer\Attribute\Groups;
use Symfony\Component\Serializer\Normalizer\AbstractNormalizer;
use Symfony\Component\Serializer\SerializerInterface;

class JsonResponseListener
{
    private $serializer;

    public function __construct(SerializerInterface $serializer)
    {
        $this->serializer = $serializer;
    }
    public function onKernelView(ViewEvent $event):void
    {
        $value = $event->getControllerResult();
        $controllerEventAttributes = $event->controllerArgumentsEvent->getAttributes();
        $groups = $controllerEventAttributes[Groups::class][0]->getGroups();
        $context = [
            AbstractNormalizer::CIRCULAR_REFERENCE_HANDLER => function ($event) {
                return $event->getId();
            },
            AbstractNormalizer::GROUPS => $groups,
        ];

        $response = new Response($this->serializer->serialize($value, 'json', $context));
        $response->headers->set('Content-Type', 'application/json');

        $event->setResponse($response);
    }
}