<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240605184849 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE country_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE event_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE incident_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE player_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE score_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE sport_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE team_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE tournament_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE country (id INT NOT NULL, name VARCHAR(255) NOT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE event (id INT NOT NULL, tournament_id INT NOT NULL, home_team_id INT NOT NULL, away_team_id INT NOT NULL, home_score_id INT DEFAULT NULL, away_score_id INT DEFAULT NULL, slug VARCHAR(255) NOT NULL, start_date TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, round INT NOT NULL, status VARCHAR(255) NOT NULL, winner_code VARCHAR(255) DEFAULT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_3BAE0AA733D1A3E7 ON event (tournament_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA79C4C13F6 ON event (home_team_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA745185D02 ON event (away_team_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA777EEF35C ON event (home_score_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA7CDE79117 ON event (away_score_id)');
        $this->addSql('CREATE TABLE incident (id INT NOT NULL, player_id INT DEFAULT NULL, team_side VARCHAR(255) DEFAULT NULL, color VARCHAR(255) DEFAULT NULL, time INT DEFAULT NULL, type VARCHAR(255) NOT NULL, external_id INT NOT NULL, scoring_team VARCHAR(255) DEFAULT NULL, home_score INT DEFAULT NULL, away_score INT DEFAULT NULL, goal_type VARCHAR(255) DEFAULT NULL, text VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_3D03A11A99E6F5DF ON incident (player_id)');
        $this->addSql('CREATE TABLE player (id INT NOT NULL, country_id INT NOT NULL, team_id INT NOT NULL, name VARCHAR(255) NOT NULL, slug VARCHAR(255) NOT NULL, position VARCHAR(255) NOT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_98197A65F92F3E70 ON player (country_id)');
        $this->addSql('CREATE INDEX IDX_98197A65296CD8AE ON player (team_id)');
        $this->addSql('CREATE TABLE played_events (player_id INT NOT NULL, event_id INT NOT NULL, PRIMARY KEY(player_id, event_id))');
        $this->addSql('CREATE INDEX IDX_7653F93899E6F5DF ON played_events (player_id)');
        $this->addSql('CREATE INDEX IDX_7653F93871F7E88B ON played_events (event_id)');
        $this->addSql('CREATE TABLE score (id INT NOT NULL, total INT DEFAULT NULL, period1 INT DEFAULT NULL, period2 INT DEFAULT NULL, period3 INT DEFAULT NULL, period4 INT DEFAULT NULL, overtime INT DEFAULT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE sport (id INT NOT NULL, name VARCHAR(255) NOT NULL, slug VARCHAR(255) NOT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE team (id INT NOT NULL, country_id INT NOT NULL, name VARCHAR(255) NOT NULL, manager_name VARCHAR(255) DEFAULT NULL, venue VARCHAR(255) DEFAULT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_C4E0A61FF92F3E70 ON team (country_id)');
        $this->addSql('CREATE TABLE tournament (id INT NOT NULL, sport_id INT NOT NULL, country_id INT NOT NULL, name VARCHAR(255) NOT NULL, slug VARCHAR(255) NOT NULL, external_id INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_BD5FB8D9AC78BCF8 ON tournament (sport_id)');
        $this->addSql('CREATE INDEX IDX_BD5FB8D9F92F3E70 ON tournament (country_id)');
        $this->addSql('CREATE TABLE messenger_messages (id BIGSERIAL NOT NULL, body TEXT NOT NULL, headers TEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, available_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, delivered_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_75EA56E0FB7336F0 ON messenger_messages (queue_name)');
        $this->addSql('CREATE INDEX IDX_75EA56E0E3BD61CE ON messenger_messages (available_at)');
        $this->addSql('CREATE INDEX IDX_75EA56E016BA31DB ON messenger_messages (delivered_at)');
        $this->addSql('COMMENT ON COLUMN messenger_messages.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN messenger_messages.available_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN messenger_messages.delivered_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE OR REPLACE FUNCTION notify_messenger_messages() RETURNS TRIGGER AS $$
            BEGIN
                PERFORM pg_notify(\'messenger_messages\', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$ LANGUAGE plpgsql;');
        $this->addSql('DROP TRIGGER IF EXISTS notify_trigger ON messenger_messages;');
        $this->addSql('CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON messenger_messages FOR EACH ROW EXECUTE PROCEDURE notify_messenger_messages();');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA733D1A3E7 FOREIGN KEY (tournament_id) REFERENCES tournament (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA79C4C13F6 FOREIGN KEY (home_team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA745185D02 FOREIGN KEY (away_team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA777EEF35C FOREIGN KEY (home_score_id) REFERENCES score (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA7CDE79117 FOREIGN KEY (away_score_id) REFERENCES score (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE incident ADD CONSTRAINT FK_3D03A11A99E6F5DF FOREIGN KEY (player_id) REFERENCES player (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE player ADD CONSTRAINT FK_98197A65F92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE player ADD CONSTRAINT FK_98197A65296CD8AE FOREIGN KEY (team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE played_events ADD CONSTRAINT FK_7653F93899E6F5DF FOREIGN KEY (player_id) REFERENCES player (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE played_events ADD CONSTRAINT FK_7653F93871F7E88B FOREIGN KEY (event_id) REFERENCES event (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE team ADD CONSTRAINT FK_C4E0A61FF92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE tournament ADD CONSTRAINT FK_BD5FB8D9AC78BCF8 FOREIGN KEY (sport_id) REFERENCES sport (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE tournament ADD CONSTRAINT FK_BD5FB8D9F92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE country_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE event_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE incident_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE player_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE score_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE sport_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE team_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE tournament_id_seq CASCADE');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA733D1A3E7');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA79C4C13F6');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA745185D02');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA777EEF35C');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA7CDE79117');
        $this->addSql('ALTER TABLE incident DROP CONSTRAINT FK_3D03A11A99E6F5DF');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT FK_98197A65F92F3E70');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT FK_98197A65296CD8AE');
        $this->addSql('ALTER TABLE played_events DROP CONSTRAINT FK_7653F93899E6F5DF');
        $this->addSql('ALTER TABLE played_events DROP CONSTRAINT FK_7653F93871F7E88B');
        $this->addSql('ALTER TABLE team DROP CONSTRAINT FK_C4E0A61FF92F3E70');
        $this->addSql('ALTER TABLE tournament DROP CONSTRAINT FK_BD5FB8D9AC78BCF8');
        $this->addSql('ALTER TABLE tournament DROP CONSTRAINT FK_BD5FB8D9F92F3E70');
        $this->addSql('DROP TABLE country');
        $this->addSql('DROP TABLE event');
        $this->addSql('DROP TABLE incident');
        $this->addSql('DROP TABLE player');
        $this->addSql('DROP TABLE played_events');
        $this->addSql('DROP TABLE score');
        $this->addSql('DROP TABLE sport');
        $this->addSql('DROP TABLE team');
        $this->addSql('DROP TABLE tournament');
        $this->addSql('DROP TABLE messenger_messages');
    }
}
