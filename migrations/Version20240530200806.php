<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240530200806 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE incident ADD scoring_team VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE incident ADD home_score INT DEFAULT NULL');
        $this->addSql('ALTER TABLE incident ADD away_score INT DEFAULT NULL');
        $this->addSql('ALTER TABLE incident ADD goal_type VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE incident ADD text VARCHAR(255) DEFAULT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE incident DROP scoring_team');
        $this->addSql('ALTER TABLE incident DROP home_score');
        $this->addSql('ALTER TABLE incident DROP away_score');
        $this->addSql('ALTER TABLE incident DROP goal_type');
        $this->addSql('ALTER TABLE incident DROP text');
    }
}
