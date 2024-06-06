<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240605215919 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE player_events_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE player_events (id INT NOT NULL, player_id INT NOT NULL, event_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_CC87C19499E6F5DF ON player_events (player_id)');
        $this->addSql('CREATE INDEX IDX_CC87C19471F7E88B ON player_events (event_id)');
        $this->addSql('ALTER TABLE player_events ADD CONSTRAINT FK_CC87C19499E6F5DF FOREIGN KEY (player_id) REFERENCES player (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE player_events ADD CONSTRAINT FK_CC87C19471F7E88B FOREIGN KEY (event_id) REFERENCES event (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE player_events_id_seq CASCADE');
        $this->addSql('ALTER TABLE player_events DROP CONSTRAINT FK_CC87C19499E6F5DF');
        $this->addSql('ALTER TABLE player_events DROP CONSTRAINT FK_CC87C19471F7E88B');
        $this->addSql('DROP TABLE player_events');
    }
}
