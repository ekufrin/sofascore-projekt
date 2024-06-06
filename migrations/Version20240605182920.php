<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240605182920 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP SEQUENCE player_id_seq CASCADE');
        $this->addSql('DROP INDEX uniq_98197a659f75d7b0');
        $this->addSql('ALTER TABLE player DROP CONSTRAINT player_pkey');
        $this->addSql('ALTER TABLE player ADD PRIMARY KEY (id, external_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('CREATE SEQUENCE player_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('DROP INDEX player_pkey');
        $this->addSql('CREATE UNIQUE INDEX uniq_98197a659f75d7b0 ON player (external_id)');
        $this->addSql('ALTER TABLE player ADD PRIMARY KEY (id)');
    }
}
