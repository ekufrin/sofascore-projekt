<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240526180159 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE country_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE player_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE score_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE team_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE country (id INT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE player (id INT NOT NULL, country_id INT NOT NULL, name VARCHAR(255) NOT NULL, slug VARCHAR(255) NOT NULL, position VARCHAR(255) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_98197A65F92F3E70 ON player (country_id)');
        $this->addSql('CREATE TABLE score (id INT NOT NULL, total INT DEFAULT NULL, period1 INT DEFAULT NULL, period2 INT DEFAULT NULL, period3 INT DEFAULT NULL, period4 INT DEFAULT NULL, overtime INT DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE team (id INT NOT NULL, country_id INT NOT NULL, name VARCHAR(255) NOT NULL, manager_name VARCHAR(255) DEFAULT NULL, venue VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_C4E0A61FF92F3E70 ON team (country_id)');
        $this->addSql('CREATE TABLE messenger_messages (id BIGSERIAL NOT NULL, body TEXT NOT NULL, headers TEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, available_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, delivered_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_75EA56E0FB7336F0 ON messenger_messages (queue_name)');
        $this->addSql('CREATE INDEX IDX_75EA56E0E3BD61CE ON messenger_messages (available_at)');
        $this->addSql('CREATE INDEX IDX_75EA56E016BA31DB ON messenger_messages (delivered_at)');
        $this->addSql('CREATE OR REPLACE FUNCTION notify_messenger_messages() RETURNS TRIGGER AS $$
            BEGIN
                PERFORM pg_notify(\'messenger_messages\', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$ LANGUAGE plpgsql;');
        $this->addSql('DROP TRIGGER IF EXISTS notify_trigger ON messenger_messages;');
        $this->addSql('CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON messenger_messages FOR EACH ROW EXECUTE PROCEDURE notify_messenger_messages();');
        $this->addSql('ALTER TABLE player ADD CONSTRAINT FK_98197A65F92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE team ADD CONSTRAINT FK_C4E0A61FF92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD home_score_id INT NOT NULL');
        $this->addSql('ALTER TABLE event ADD away_score_id INT NOT NULL');
        $this->addSql('ALTER TABLE event ADD round INT NOT NULL');
        $this->addSql('ALTER TABLE event ADD status VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE event ADD winner_code VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE event DROP home_score');
        $this->addSql('ALTER TABLE event DROP away_score');
        $this->addSql('ALTER TABLE event ALTER id DROP DEFAULT');
        $this->addSql('ALTER TABLE event ALTER tournament_id SET NOT NULL');
        $this->addSql('ALTER TABLE event ALTER home_team_id TYPE INT');
        $this->addSql('ALTER TABLE event ALTER away_team_id TYPE INT');
        $this->addSql('ALTER TABLE event ALTER start_date DROP NOT NULL');
        $this->addSql('ALTER TABLE event RENAME COLUMN external_id TO slug');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA79C4C13F6 FOREIGN KEY (home_team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA745185D02 FOREIGN KEY (away_team_id) REFERENCES team (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA777EEF35C FOREIGN KEY (home_score_id) REFERENCES score (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA7CDE79117 FOREIGN KEY (away_score_id) REFERENCES score (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_3BAE0AA79C4C13F6 ON event (home_team_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA745185D02 ON event (away_team_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA777EEF35C ON event (home_score_id)');
        $this->addSql('CREATE INDEX IDX_3BAE0AA7CDE79117 ON event (away_score_id)');
        $this->addSql('ALTER TABLE sport DROP external_id');
        $this->addSql('ALTER TABLE sport ALTER id DROP DEFAULT');
        $this->addSql('ALTER TABLE tournament ADD country_id INT NOT NULL');
        $this->addSql('ALTER TABLE tournament DROP external_id');
        $this->addSql('ALTER TABLE tournament ALTER id DROP DEFAULT');
        $this->addSql('ALTER TABLE tournament ALTER sport_id SET NOT NULL');
        $this->addSql('ALTER TABLE tournament ADD CONSTRAINT FK_BD5FB8D9F92F3E70 FOREIGN KEY (country_id) REFERENCES country (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_BD5FB8D9F92F3E70 ON tournament (country_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE tournament DROP CONSTRAINT FK_BD5FB8D9F92F3E70');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA777EEF35C');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA7CDE79117');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA79C4C13F6');
        $this->addSql('ALTER TABLE event DROP CONSTRAINT FK_3BAE0AA745185D02');
        $this->addSql('DROP SEQUENCE country_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE player_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE score_id_seq CASCADE');
        $this->addSql('DROP SEQUENCE team_id_seq CASCADE');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT FK_98197A65F92F3E70');
        $this->addSql('ALTER TABLE team DROP CONSTRAINT FK_C4E0A61FF92F3E70');
        $this->addSql('DROP TABLE country');
        $this->addSql('DROP TABLE player');
        $this->addSql('DROP TABLE score');
        $this->addSql('DROP TABLE team');
        $this->addSql('DROP TABLE messenger_messages');
        $this->addSql('DROP INDEX IDX_3BAE0AA79C4C13F6');
        $this->addSql('DROP INDEX IDX_3BAE0AA745185D02');
        $this->addSql('DROP INDEX IDX_3BAE0AA777EEF35C');
        $this->addSql('DROP INDEX IDX_3BAE0AA7CDE79117');
        $this->addSql('ALTER TABLE event ADD external_id VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE event ADD home_score INT DEFAULT NULL');
        $this->addSql('ALTER TABLE event ADD away_score INT DEFAULT NULL');
        $this->addSql('ALTER TABLE event DROP home_score_id');
        $this->addSql('ALTER TABLE event DROP away_score_id');
        $this->addSql('ALTER TABLE event DROP slug');
        $this->addSql('ALTER TABLE event DROP round');
        $this->addSql('ALTER TABLE event DROP status');
        $this->addSql('ALTER TABLE event DROP winner_code');
        $this->addSql('CREATE SEQUENCE event_id_seq');
        $this->addSql('SELECT setval(\'event_id_seq\', (SELECT MAX(id) FROM event))');
        $this->addSql('ALTER TABLE event ALTER id SET DEFAULT nextval(\'event_id_seq\')');
        $this->addSql('ALTER TABLE event ALTER tournament_id DROP NOT NULL');
        $this->addSql('ALTER TABLE event ALTER home_team_id TYPE VARCHAR(255)');
        $this->addSql('ALTER TABLE event ALTER away_team_id TYPE VARCHAR(255)');
        $this->addSql('ALTER TABLE event ALTER start_date SET NOT NULL');
        $this->addSql('ALTER TABLE sport ADD external_id VARCHAR(255) NOT NULL');
        $this->addSql('CREATE SEQUENCE sport_id_seq');
        $this->addSql('SELECT setval(\'sport_id_seq\', (SELECT MAX(id) FROM sport))');
        $this->addSql('ALTER TABLE sport ALTER id SET DEFAULT nextval(\'sport_id_seq\')');
        $this->addSql('DROP INDEX IDX_BD5FB8D9F92F3E70');
        $this->addSql('ALTER TABLE tournament ADD external_id VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE tournament DROP country_id');
        $this->addSql('CREATE SEQUENCE tournament_id_seq');
        $this->addSql('SELECT setval(\'tournament_id_seq\', (SELECT MAX(id) FROM tournament))');
        $this->addSql('ALTER TABLE tournament ALTER id SET DEFAULT nextval(\'tournament_id_seq\')');
        $this->addSql('ALTER TABLE tournament ALTER sport_id DROP NOT NULL');
    }
}
