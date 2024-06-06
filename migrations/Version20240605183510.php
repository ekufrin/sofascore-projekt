<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240605183510 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA733D1A3E7 FOREIGN KEY (tournament_id) REFERENCES tournament (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA79C4C13F6 FOREIGN KEY (home_team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA745185D02 FOREIGN KEY (away_team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA777EEF35C FOREIGN KEY (home_score_id) REFERENCES score (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA7CDE79117 FOREIGN KEY (away_score_id) REFERENCES score (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE incident ADD CONSTRAINT FK_3D03A11A99E6F5DF FOREIGN KEY (player_id) REFERENCES player (external_id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('DROP INDEX uniq_98197a659f75d7b0');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT player_pkey');
        $this->addSql('ALTER TABLE player ADD CONSTRAINT FK_98197A65F92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE player ADD CONSTRAINT FK_98197A65296CD8AE FOREIGN KEY (team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE player ADD PRIMARY KEY (external_id)');
        $this->addSql('ALTER TABLE played_events ADD CONSTRAINT FK_7653F93899E6F5DF FOREIGN KEY (player_id) REFERENCES player (external_id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE played_events ADD CONSTRAINT FK_7653F93871F7E88B FOREIGN KEY (event_id) REFERENCES event (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE tournament ADD CONSTRAINT FK_BD5FB8D9AC78BCF8 FOREIGN KEY (sport_id) REFERENCES sport (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE tournament ADD CONSTRAINT FK_BD5FB8D9F92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT FK_98197A65F92F3E70');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT FK_98197A65296CD8AE');
        $this->addSql('DROP INDEX player_pkey');
        $this->addSql('CREATE UNIQUE INDEX uniq_98197a659f75d7b0 ON player (external_id)');
        $this->addSql('ALTER TABLE player ADD PRIMARY KEY (id, external_id)');
        $this->addSql('ALTER TABLE incident DROP CONSTRAINT FK_3D03A11A99E6F5DF');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA733D1A3E7');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA79C4C13F6');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA745185D02');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA777EEF35C');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA7CDE79117');
        $this->addSql('ALTER TABLE played_events DROP CONSTRAINT FK_7653F93899E6F5DF');
        $this->addSql('ALTER TABLE played_events DROP CONSTRAINT FK_7653F93871F7E88B');
        $this->addSql('ALTER TABLE tournament DROP CONSTRAINT FK_BD5FB8D9AC78BCF8');
        $this->addSql('ALTER TABLE tournament DROP CONSTRAINT FK_BD5FB8D9F92F3E70');
    }
}
