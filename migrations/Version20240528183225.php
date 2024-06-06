<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240528183225 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE country ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE event ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE incident ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE player ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE score ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE sport ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE team ADD external_id INT NOT NULL');
        $this->addSql('ALTER TABLE tournament ADD external_id INT NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE player DROP external_id');
        $this->addSql('ALTER TABLE score DROP external_id');
        $this->addSql('ALTER TABLE event DROP external_id');
        $this->addSql('ALTER TABLE country DROP external_id');
        $this->addSql('ALTER TABLE tournament DROP external_id');
        $this->addSql('ALTER TABLE sport DROP external_id');
        $this->addSql('ALTER TABLE team DROP external_id');
        $this->addSql('ALTER TABLE incident DROP external_id');
    }
}
