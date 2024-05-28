-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 19 Avril 2024 à 17:21
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `xpress_connect_dev`
--

-- --------------------------------------------------------

--
-- Structure de la table `activation_cna`
--

CREATE TABLE IF NOT EXISTS `activation_cna` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activated_by` int(11) DEFAULT NULL,
  `distributeur_id` int(11) DEFAULT NULL,
  `msisdn_history_id` int(11) DEFAULT NULL,
  `msisdn` int(11) NOT NULL,
  `sim` bigint(20) NOT NULL,
  `digitalised` tinyint(1) DEFAULT '0',
  `action_at` datetime NOT NULL,
  `channel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brand` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `piece_identif` smallint(6) DEFAULT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pays` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_3E6A4C93E5B80C40` (`msisdn_history_id`),
  KEY `IDX_3E6A4C93255FA5E4` (`activated_by`),
  KEY `IDX_3E6A4C9329EB7ACA` (`distributeur_id`),
  KEY `IDX_3E6A4C93485C6A59` (`action_at`),
  KEY `IDX_3E6A4C932ECAC210` (`sim`),
  KEY `IDX_3E6A4C93D8AB44` (`msisdn`),
  KEY `IDX_3E6A4C93A2F98E47` (`channel`),
  KEY `IDX_3E6A4C931C52F958` (`brand`),
  KEY `IDX_3E6A4C932ECAC210485C6A59` (`sim`,`action_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `administratorcontact_report`
--

CREATE TABLE IF NOT EXISTS `administratorcontact_report` (
  `administratorcontact_id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  PRIMARY KEY (`administratorcontact_id`,`report_id`),
  KEY `IDX_A20923CFD6A72D6` (`administratorcontact_id`),
  KEY `IDX_A20923CF4BD2A4C0` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `administrator_contact`
--

CREATE TABLE IF NOT EXISTS `administrator_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone` int(11) NOT NULL,
  `email` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_297DEBD7444F97DD` (`phone`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Structure de la table `anomalie`
--

CREATE TABLE IF NOT EXISTS `anomalie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `automatic` tinyint(1) DEFAULT '0',
  `code` int(11) DEFAULT NULL,
  `products` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `impact_input_bscs` tinyint(1) NOT NULL DEFAULT '0',
  `impact_loading` tinyint(1) NOT NULL DEFAULT '0',
  `inputImpacted` int(11) DEFAULT NULL,
  `hideInput` tinyint(1) NOT NULL DEFAULT '0',
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `impact_commissionnement` tinyint(1) DEFAULT '0',
  `remonter` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_715AA19C5E237E06` (`name`),
  UNIQUE KEY `UNIQ_715AA19C77153098` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=108 ;

-- --------------------------------------------------------

--
-- Structure de la table `anomalie_contradictorys`
--

CREATE TABLE IF NOT EXISTS `anomalie_contradictorys` (
  `contradictory_with_me_id` int(11) NOT NULL,
  `contradictorys_id` int(11) NOT NULL,
  PRIMARY KEY (`contradictory_with_me_id`,`contradictorys_id`),
  KEY `IDX_398FD6BA1586215E` (`contradictory_with_me_id`),
  KEY `IDX_398FD6BAC4BD76C9` (`contradictorys_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `blacklist`
--

CREATE TABLE IF NOT EXISTS `blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cin` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_3B175385ABE530DA` (`cin`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Structure de la table `bon_livraison`
--

CREATE TABLE IF NOT EXISTS `bon_livraison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distributeur_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `ref_bl` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_bl_distributeur` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `nb_contract` int(11) DEFAULT '0',
  `raised_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `siteCna_id` int(11) DEFAULT NULL,
  `franchise_id` int(11) DEFAULT NULL,
  `last_contract` int(11) DEFAULT NULL,
  `charged_by_id` int(11) DEFAULT NULL,
  `validated_by_id` int(11) DEFAULT NULL,
  `is_pos` tinyint(1) NOT NULL DEFAULT '1',
  `produit` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `offre_id` int(11) DEFAULT NULL,
  `contract_debut` bigint(20) DEFAULT NULL,
  `contract_fin` bigint(20) DEFAULT NULL,
  `contract_loaded` int(11) DEFAULT '0',
  `nb_contract_distributeur` int(11) DEFAULT '0',
  `validated_at` datetime DEFAULT NULL,
  `isDigitalised` tinyint(1) DEFAULT '0',
  `withAnomalie` tinyint(1) DEFAULT '0',
  `istransfert` tinyint(1) DEFAULT '0',
  `siteCnaMere_id` int(11) DEFAULT NULL,
  `ref_bar_code` bigint(20) DEFAULT NULL,
  `isopened` tinyint(1) DEFAULT '0',
  `affectedAt` datetime DEFAULT NULL,
  `transferred_at` datetime DEFAULT NULL,
  `nbContractLoaded` int(11) DEFAULT '0',
  `charged_by_copie_id` int(11) DEFAULT NULL,
  `validated_by_copie_id` int(11) DEFAULT NULL,
  `siteCnaCopie_id` int(11) DEFAULT NULL,
  `status_changed_by` int(11) DEFAULT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `nbContractAccepted` int(11) DEFAULT '0',
  `received_at` datetime DEFAULT NULL,
  `receivedBy_id` int(11) DEFAULT NULL,
  `nb_contract_saisie` int(11) DEFAULT '0',
  `nbContractWithAnomalie` int(11) DEFAULT '0',
  `nb_contract_activated` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_31A531A44AF4A090` (`siteCna_id`),
  KEY `IDX_31A531A47E3C61F9` (`owner_id`),
  KEY `IDX_31A531A4B03A8386` (`created_by_id`),
  KEY `IDX_31A531A4896DBBDE` (`updated_by_id`),
  KEY `IDX_ref_bl` (`ref_bl`),
  KEY `IDX_31A531A429EB7ACA` (`distributeur_id`),
  KEY `IDX_31A531A4523CAB89` (`franchise_id`),
  KEY `IDX_31A531A4BF18B1C6` (`charged_by_id`),
  KEY `IDX_31A531A4C69DE5E5` (`validated_by_id`),
  KEY `IDX_31A531A44CC8505A` (`offre_id`),
  KEY `IDX_31A531A45E7EDB42` (`siteCnaMere_id`),
  KEY `IDX_31A531A4334DEA77` (`siteCnaCopie_id`),
  KEY `IDX_31A531A49944F02F` (`charged_by_copie_id`),
  KEY `IDX_31A531A45448FB6A` (`validated_by_copie_id`),
  KEY `IDX_31A531A411EF8919` (`status_changed_by`),
  KEY `IDX_31A531A4E6C5D2A3` (`receivedBy_id`),
  KEY `IDX_bl_raised_at` (`raised_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=139 ;

-- --------------------------------------------------------

--
-- Structure de la table `bon_livraison_audit`
--

CREATE TABLE IF NOT EXISTS `bon_livraison_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `distributeur_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `ref_bl` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_bl_distributeur` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `nb_contract` int(11) DEFAULT '0',
  `raised_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `siteCna_id` int(11) DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `franchise_id` int(11) DEFAULT NULL,
  `last_contract` int(11) DEFAULT NULL,
  `charged_by_id` int(11) DEFAULT NULL,
  `validated_by_id` int(11) DEFAULT NULL,
  `is_pos` tinyint(1) DEFAULT '1',
  `produit` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `offre_id` int(11) DEFAULT NULL,
  `contract_debut` bigint(20) DEFAULT NULL,
  `contract_fin` bigint(20) DEFAULT NULL,
  `contract_loaded` int(11) DEFAULT '0',
  `nb_contract_distributeur` int(11) DEFAULT '0',
  `validated_at` datetime DEFAULT NULL,
  `isDigitalised` tinyint(1) DEFAULT '0',
  `withAnomalie` tinyint(1) DEFAULT '0',
  `istransfert` tinyint(1) DEFAULT '0',
  `siteCnaMere_id` int(11) DEFAULT NULL,
  `ref_bar_code` bigint(20) DEFAULT NULL,
  `isopened` tinyint(1) DEFAULT '0',
  `affectedAt` datetime DEFAULT NULL,
  `transferred_at` datetime DEFAULT NULL,
  `nbContractLoaded` int(11) DEFAULT '0',
  `charged_by_copie_id` int(11) DEFAULT NULL,
  `validated_by_copie_id` int(11) DEFAULT NULL,
  `siteCnaCopie_id` int(11) DEFAULT NULL,
  `status_changed_by` int(11) DEFAULT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `nbContractAccepted` int(11) DEFAULT '0',
  `received_at` datetime DEFAULT NULL,
  `receivedBy_id` int(11) DEFAULT NULL,
  `nb_contract_saisie` int(11) DEFAULT '0',
  `nbContractWithAnomalie` int(11) DEFAULT '0',
  `nb_contract_activated` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`rev`),
  KEY `FK_31A531A411EF8919_audit` (`status_changed_by`),
  KEY `FK_31A531A44AF4A090_audit` (`siteCna_id`),
  KEY `FK_31A531A4334DEA77_audit` (`siteCnaCopie_id`),
  KEY `FK_31A531A45E7EDB42_audit` (`siteCnaMere_id`),
  KEY `FK_31A531A429EB7ACA_audit` (`distributeur_id`),
  KEY `FK_31A531A44CC8505A_audit` (`offre_id`),
  KEY `FK_31A531A4523CAB89_audit` (`franchise_id`),
  KEY `FK_31A531A47E3C61F9_audit` (`owner_id`),
  KEY `FK_31A531A4E6C5D2A3_audit` (`receivedBy_id`),
  KEY `FK_31A531A4B03A8386_audit` (`created_by_id`),
  KEY `FK_31A531A4896DBBDE_audit` (`updated_by_id`),
  KEY `FK_31A531A4BF18B1C6_audit` (`charged_by_id`),
  KEY `FK_31A531A4C69DE5E5_audit` (`validated_by_id`),
  KEY `FK_31A531A49944F02F_audit` (`charged_by_copie_id`),
  KEY `FK_31A531A45448FB6A_audit` (`validated_by_copie_id`),
  KEY `rev_ae5d45b08c5df154f9fdd9a53ceb2724_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bordereau`
--

CREATE TABLE IF NOT EXISTS `bordereau` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distributeur_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL,
  `site_cna_id` int(11) DEFAULT NULL,
  `ref_bordereau` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ref_bar_code` bigint(20) DEFAULT NULL,
  `nb_contracts` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `closed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F7B4C56129EB7ACA` (`distributeur_id`),
  KEY `IDX_F7B4C561DE12AB56` (`created_by`),
  KEY `IDX_F7B4C56188F6E01` (`closed_by`),
  KEY `IDX_F7B4C56173943760` (`site_cna_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `bordereau_audit`
--

CREATE TABLE IF NOT EXISTS `bordereau_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `distributeur_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL,
  `site_cna_id` int(11) DEFAULT NULL,
  `ref_bordereau` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_bar_code` bigint(20) DEFAULT NULL,
  `nb_contracts` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_4f210964d618a5ce87333bf4913f0b49_idx` (`rev`),
  KEY `FK_F7B4C56129EB7ACA_audit` (`distributeur_id`),
  KEY `FK_F7B4C561DE12AB56_audit` (`created_by`),
  KEY `FK_F7B4C56188F6E01_audit` (`closed_by`),
  KEY `FK_F7B4C56173943760_audit` (`site_cna_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `brand`
--

CREATE TABLE IF NOT EXISTS `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci,
  `range_from` bigint(20) DEFAULT NULL,
  `range_to` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1C52F9585E237E06` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- Structure de la table `brand_dsa`
--

CREATE TABLE IF NOT EXISTS `brand_dsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codeBrand` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nbprefixs` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_7DD496EE5E237E06` (`name`),
  UNIQUE KEY `UNIQ_7DD496EEB65DCC86` (`codeBrand`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Structure de la table `brand_dsa_audit`
--

CREATE TABLE IF NOT EXISTS `brand_dsa_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nbprefixs` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `codeBrand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_f959425d1d29e876e28782af2f33a143_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `campagne`
--

CREATE TABLE IF NOT EXISTS `campagne` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `titre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci,
  `montant` double DEFAULT NULL,
  `comptbonus` int(11) DEFAULT NULL,
  `pwdbonus` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_539B5D167E3C61F9` (`owner_id`),
  KEY `IDX_date_from` (`date_from`),
  KEY `IDX_date_to` (`date_to`),
  KEY `IDX_enabled` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `campagne_user`
--

CREATE TABLE IF NOT EXISTS `campagne_user` (
  `campagne_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`campagne_id`,`user_id`),
  KEY `IDX_66A14A8916227374` (`campagne_id`),
  KEY `IDX_66A14A89A76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `check_bon_livraison`
--

CREATE TABLE IF NOT EXISTS `check_bon_livraison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_bl` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `check_contract`
--

CREATE TABLE IF NOT EXISTS `check_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_contract` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `check_update_bscs`
--

CREATE TABLE IF NOT EXISTS `check_update_bscs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_contract` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id_contract` (`id_contract`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `configbonlivraison`
--

CREATE TABLE IF NOT EXISTS `configbonlivraison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `products` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `configbscs`
--

CREATE TABLE IF NOT EXISTS `configbscs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateFrom` datetime NOT NULL,
  `dateFin` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure de la table `configbscs_audit`
--

CREATE TABLE IF NOT EXISTS `configbscs_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `dateFrom` datetime DEFAULT NULL,
  `dateFin` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_3b12411018b68df4030de1537bfd7d9e_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contract_archive`
--

CREATE TABLE IF NOT EXISTS `contract_archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sim` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imei` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_appel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_autorisation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_order` int(11) DEFAULT NULL,
  `ref_bon_livraison` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remonted_at` datetime DEFAULT NULL,
  `offre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `produit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_Archive_sim` (`sim`),
  KEY `IDX_Archive_imei` (`imei`),
  KEY `IDX_Archive_numFixe` (`num_appel`),
  KEY `IDX_Archive_numAutorisation` (`num_autorisation`),
  KEY `IDX_Archive_remontedAt` (`remonted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `contrat_drc`
--

CREATE TABLE IF NOT EXISTS `contrat_drc` (
  `id` bigint(45) NOT NULL AUTO_INCREMENT,
  `DATE_SIM_SWAP` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `heure_operation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NUMERO_SERIE_SIM_NORMALISE` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NUMERO_APPEL` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CIN_RC_PASS` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `cx_history`
--

CREATE TABLE IF NOT EXISTS `cx_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sim` bigint(20) DEFAULT NULL,
  `action_at` datetime NOT NULL,
  `user_bscs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sim_pack_id` bigint(20) DEFAULT NULL,
  `msisdn_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `campagne_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `brand_dsa_id` int(11) DEFAULT NULL,
  `offre_dsa_id` int(11) DEFAULT NULL,
  `isDigitalised` tinyint(1) DEFAULT '0',
  `action` smallint(6) NOT NULL,
  `extra_info` longtext COLLATE utf8_unicode_ci,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `piece_identif` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pays` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isDsa` tinyint(1) DEFAULT '0',
  `imsi` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A4F1F897D429DFE8` (`msisdn_id`),
  KEY `IDX_A4F1F897A76ED395` (`user_id`),
  KEY `IDX_A4F1F89716227374` (`campagne_id`),
  KEY `IDX_A4F1F89784EA4054` (`sim_pack_id`),
  KEY `IDX_A4F1F89744F5D008` (`brand_id`),
  KEY `IDX_A4F1F8975C786BA` (`brand_dsa_id`),
  KEY `IDX_A4F1F897E1C59A9F` (`offre_dsa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Structure de la table `cx_msisdn`
--

CREATE TABLE IF NOT EXISTS `cx_msisdn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` bigint(20) DEFAULT NULL,
  `msisdn_virtual` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `delegation`
--

CREATE TABLE IF NOT EXISTS `delegation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gouvernorat_id` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_292F436D75B74E2D` (`gouvernorat_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=260 ;

-- --------------------------------------------------------

--
-- Structure de la table `digitalcontrat_anomalie`
--

CREATE TABLE IF NOT EXISTS `digitalcontrat_anomalie` (
  `digitalcontract_id` int(11) NOT NULL,
  `anomalie_id` int(11) NOT NULL,
  PRIMARY KEY (`digitalcontract_id`,`anomalie_id`),
  KEY `IDX_1FF38D8A2AD06BAB` (`digitalcontract_id`),
  KEY `IDX_1FF38D8AAEEAB197` (`anomalie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digitalstatday`
--

CREATE TABLE IF NOT EXISTS `digitalstatday` (
  `date` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `nbTotalContract` int(11) DEFAULT '0',
  `nbOperationActivation` int(11) DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) DEFAULT '0',
  `totalDurationPrevalidation` int(11) DEFAULT '0',
  `nbContractCompliance` int(11) DEFAULT '0',
  `totalDurationRemonte` int(11) DEFAULT '0',
  `nbTotalContractRemonte` int(11) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`date`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digitalstathour`
--

CREATE TABLE IF NOT EXISTS `digitalstathour` (
  `date` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `nbTotalContract` int(11) DEFAULT '0',
  `nbOperationActivation` int(11) DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) DEFAULT '0',
  `totalDurationPrevalidation` int(11) DEFAULT '0',
  `nbContractCompliance` int(11) DEFAULT '0',
  `totalDurationRemonte` int(11) DEFAULT '0',
  `nbTotalContractRemonte` int(11) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`date`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digitalstatmonth`
--

CREATE TABLE IF NOT EXISTS `digitalstatmonth` (
  `date` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `nbTotalContract` int(11) DEFAULT '0',
  `nbOperationActivation` int(11) DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) DEFAULT '0',
  `totalDurationPrevalidation` int(11) DEFAULT '0',
  `nbContractCompliance` int(11) DEFAULT '0',
  `totalDurationRemonte` int(11) DEFAULT '0',
  `nbTotalContractRemonte` int(11) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`date`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digitalstatweek`
--

CREATE TABLE IF NOT EXISTS `digitalstatweek` (
  `date` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `nbTotalContract` int(11) DEFAULT '0',
  `nbOperationActivation` int(11) DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) DEFAULT '0',
  `totalDurationPrevalidation` int(11) DEFAULT '0',
  `nbContractCompliance` int(11) DEFAULT '0',
  `totalDurationRemonte` int(11) DEFAULT '0',
  `nbTotalContractRemonte` int(11) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`date`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digitalstatyear`
--

CREATE TABLE IF NOT EXISTS `digitalstatyear` (
  `date` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `nbTotalContract` int(11) DEFAULT '0',
  `nbOperationActivation` int(11) DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) DEFAULT '0',
  `totalDurationPrevalidation` int(11) DEFAULT '0',
  `nbContractCompliance` int(11) DEFAULT '0',
  `totalDurationRemonte` int(11) DEFAULT '0',
  `nbTotalContractRemonte` int(11) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`date`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digital_config`
--

CREATE TABLE IF NOT EXISTS `digital_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `limit_remonte_contract` int(11) NOT NULL DEFAULT '2',
  `ocr_via` tinyint(1) NOT NULL DEFAULT '0',
  `limit_prevalide_contract` int(11) NOT NULL DEFAULT '5',
  `limit_non_prevalide_contract` int(11) NOT NULL DEFAULT '5',
  `max_nb_contract_offline_non_remonte` int(11) NOT NULL DEFAULT '500',
  `max_delai_remonte_contract_offline` int(11) NOT NULL DEFAULT '17',
  `seuil_nb_contract_offline_non_remonte` int(11) NOT NULL DEFAULT '100',
  `seuil_delai_remonte_contract_offline` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `digital_config_audit`
--

CREATE TABLE IF NOT EXISTS `digital_config_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `limit_remonte_contract` int(11) DEFAULT '2',
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `ocr_via` tinyint(1) DEFAULT '0',
  `limit_prevalide_contract` int(11) DEFAULT '5',
  `limit_non_prevalide_contract` int(11) DEFAULT '5',
  `max_nb_contract_offline_non_remonte` int(11) DEFAULT '500',
  `max_delai_remonte_contract_offline` int(11) DEFAULT '17',
  `seuil_nb_contract_offline_non_remonte` int(11) DEFAULT '100',
  `seuil_delai_remonte_contract_offline` int(11) DEFAULT '1',
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_ffb6428dd51c15911cb79d8eecf59ad1_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digital_contract`
--

CREATE TABLE IF NOT EXISTS `digital_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_bon_livraison_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `pos_id` int(11) DEFAULT NULL,
  `dispenser_id` int(11) DEFAULT NULL,
  `piece_identif` smallint(6) DEFAULT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_recto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_verso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passeport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `residence` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `place_birth` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `msisdn` int(11) DEFAULT NULL,
  `channel` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `discr` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `sim` bigint(20) DEFAULT NULL,
  `imei` bigint(20) DEFAULT NULL,
  `accpeted` smallint(6) DEFAULT NULL,
  `pays` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_contract` smallint(6) DEFAULT NULL,
  `num_fixe` int(11) DEFAULT NULL,
  `num_autorisation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dirnum` int(11) DEFAULT NULL,
  `piece_identif_act` smallint(6) DEFAULT NULL,
  `cin_pp_act` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isConforme` tinyint(1) DEFAULT '0',
  `isDigitalised` tinyint(1) DEFAULT '0',
  `isAutomaticValidated` tinyint(1) DEFAULT '0',
  `dateLimitePrevalidation` datetime DEFAULT NULL,
  `datePrevalidation` datetime DEFAULT NULL,
  `dateAffectation` datetime DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '1',
  `pi_saisie` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_saisie` datetime DEFAULT NULL,
  `anomalys` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `gouvernorat_id` int(11) DEFAULT NULL,
  `localite_id` int(11) DEFAULT NULL,
  `langue` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `titre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rue` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_rue` int(11) DEFAULT NULL,
  `nationalite` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `situation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexe` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_pi_saisie` int(11) DEFAULT NULL,
  `impactPieceIdentif` tinyint(1) DEFAULT '0',
  `impactCin_pp` tinyint(1) DEFAULT '0',
  `impactNumFixe` tinyint(1) DEFAULT '0',
  `numAppel` int(11) DEFAULT NULL,
  `impactSim` tinyint(1) DEFAULT '0',
  `impactImei` tinyint(1) DEFAULT '0',
  `impactNumAutorisation` tinyint(1) DEFAULT '0',
  `remonted_at` datetime DEFAULT NULL,
  `dateLimiteRemontee` datetime DEFAULT NULL,
  `isConformeRemonted` tinyint(1) DEFAULT '0',
  `operation_id` int(11) DEFAULT NULL,
  `nb_anomalie` int(11) DEFAULT '0',
  `agentSaisie` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dispenserAct` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passeportVerso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contractVerso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `markedAnomaly` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `piReconnu` tinyint(1) DEFAULT '0',
  `town_id` int(11) DEFAULT NULL,
  `houseNo` int(11) DEFAULT NULL,
  `cityOrBuilding` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `floorNo` int(11) DEFAULT NULL,
  `emailAddr` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telNo1` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `countryPasseport` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'TN',
  `nationalityPasseport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numSimInfo` bigint(20) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status_changed_by` int(11) DEFAULT NULL,
  `loaded_by` int(11) DEFAULT NULL,
  `accepted_by` int(11) DEFAULT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `loaded_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `ref_bordereau_id` int(11) DEFAULT NULL,
  `saisie_by` int(11) DEFAULT NULL,
  `status_contract` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `upload_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_retour` datetime DEFAULT NULL,
  `tentative_bscs` int(11) NOT NULL DEFAULT '0',
  `message_bscs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tentative_ocr` int(11) DEFAULT NULL,
  `message_ocr` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_97A439C309C719FE97310B` (`num_contract`,`ref_bon_livraison_id`),
  KEY `IDX_97A439CE97310B` (`ref_bon_livraison_id`),
  KEY `IDX_97A439CDE12AB56` (`created_by`),
  KEY `IDX_97A439C41085FAE` (`pos_id`),
  KEY `IDX_97A439C5115AEEB` (`dispenser_id`),
  KEY `IDX_97A439C75B74E2D` (`gouvernorat_id`),
  KEY `IDX_97A439C924DD2B5` (`localite_id`),
  KEY `IDX_sim` (`sim`),
  KEY `IDX_imei` (`imei`),
  KEY `IDX_numFixe` (`num_fixe`),
  KEY `IDX_numAutorisation` (`num_autorisation`),
  KEY `IDX_isDigitalised` (`isDigitalised`),
  KEY `IDX_isAutomaticValidated` (`isAutomaticValidated`),
  KEY `IDX_remontedAt` (`remonted_at`),
  KEY `IDX_dateLimiteRemontee` (`dateLimiteRemontee`),
  KEY `IDX_datePrevalidation` (`datePrevalidation`),
  KEY `IDX_97A439C75E23604` (`town_id`),
  KEY `IDX_operation_id_sim` (`operation_id`,`discr`),
  KEY `IDX_97A439C16FE72E1` (`updated_by`),
  KEY `IDX_97A439C11EF8919` (`status_changed_by`),
  KEY `IDX_97A439C1755EF4D` (`loaded_by`),
  KEY `IDX_97A439CBD57FA7C` (`accepted_by`),
  KEY `IDX_97A439CB121F6BD` (`ref_bordereau_id`),
  KEY `IDX_97A439C21D686FF` (`saisie_by`),
  KEY `IDX_discr` (`discr`),
  KEY `IDX_id_discr` (`id`,`discr`),
  KEY `IDX_status_id_discr` (`status`,`isDigitalised`,`discr`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=24878 ;

-- --------------------------------------------------------

--
-- Structure de la table `digital_contract_audit`
--

CREATE TABLE IF NOT EXISTS `digital_contract_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `ref_bon_livraison_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `pos_id` int(11) DEFAULT NULL,
  `dispenser_id` int(11) DEFAULT NULL,
  `piece_identif` smallint(6) DEFAULT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_recto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_verso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passeport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `residence` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contract` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `place_birth` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `msisdn` int(11) DEFAULT NULL,
  `channel` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `discr` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sim` bigint(20) DEFAULT NULL,
  `imei` bigint(20) DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `accpeted` smallint(6) DEFAULT NULL,
  `pays` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_contract` smallint(6) DEFAULT NULL,
  `num_fixe` int(11) DEFAULT NULL,
  `num_autorisation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dirnum` int(11) DEFAULT NULL,
  `piece_identif_act` smallint(6) DEFAULT NULL,
  `cin_pp_act` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isConforme` tinyint(1) DEFAULT '0',
  `isDigitalised` tinyint(1) DEFAULT '0',
  `isAutomaticValidated` tinyint(1) DEFAULT '0',
  `dateLimitePrevalidation` datetime DEFAULT NULL,
  `datePrevalidation` datetime DEFAULT NULL,
  `dateAffectation` datetime DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '1',
  `pi_saisie` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_saisie` datetime DEFAULT NULL,
  `anomalys` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `gouvernorat_id` int(11) DEFAULT NULL,
  `localite_id` int(11) DEFAULT NULL,
  `langue` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `titre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rue` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_rue` int(11) DEFAULT NULL,
  `nationalite` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `situation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexe` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_pi_saisie` int(11) DEFAULT NULL,
  `impactPieceIdentif` tinyint(1) DEFAULT '0',
  `impactCin_pp` tinyint(1) DEFAULT '0',
  `impactNumFixe` tinyint(1) DEFAULT '0',
  `numAppel` int(11) DEFAULT NULL,
  `impactSim` tinyint(1) DEFAULT '0',
  `impactImei` tinyint(1) DEFAULT '0',
  `impactNumAutorisation` tinyint(1) DEFAULT '0',
  `remonted_at` datetime DEFAULT NULL,
  `dateLimiteRemontee` datetime DEFAULT NULL,
  `isConformeRemonted` tinyint(1) DEFAULT '0',
  `operation_id` int(11) DEFAULT NULL,
  `nb_anomalie` int(11) DEFAULT '0',
  `agentSaisie` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dispenserAct` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passeportVerso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contractVerso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `markedAnomaly` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `piReconnu` tinyint(1) DEFAULT '0',
  `town_id` int(11) DEFAULT NULL,
  `houseNo` int(11) DEFAULT NULL,
  `cityOrBuilding` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `floorNo` int(11) DEFAULT NULL,
  `emailAddr` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telNo1` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `countryPasseport` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'TN',
  `nationalityPasseport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numSimInfo` bigint(20) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status_changed_by` int(11) DEFAULT NULL,
  `loaded_by` int(11) DEFAULT NULL,
  `accepted_by` int(11) DEFAULT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `loaded_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `ref_bordereau_id` int(11) DEFAULT NULL,
  `saisie_by` int(11) DEFAULT NULL,
  `status_contract` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `upload_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_retour` datetime DEFAULT NULL,
  `tentative_bscs` int(11) DEFAULT '0',
  `message_bscs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `FK_97A439C75B74E2D_audit` (`gouvernorat_id`),
  KEY `FK_97A439C924DD2B5_audit` (`localite_id`),
  KEY `FK_97A439C75E23604_audit` (`town_id`),
  KEY `FK_97A439CE97310B_audit` (`ref_bon_livraison_id`),
  KEY `FK_97A439C16FE72E1_audit` (`updated_by`),
  KEY `FK_97A439CDE12AB56_audit` (`created_by`),
  KEY `FK_97A439C11EF8919_audit` (`status_changed_by`),
  KEY `FK_97A439C1755EF4D_audit` (`loaded_by`),
  KEY `FK_97A439CBD57FA7C_audit` (`accepted_by`),
  KEY `FK_97A439C41085FAE_audit` (`pos_id`),
  KEY `FK_97A439C5115AEEB_audit` (`dispenser_id`),
  KEY `rev_760792d2504eb9f85750f24876e93e93_idx` (`rev`),
  KEY `FK_97A439CB121F6BD_audit` (`ref_bordereau_id`),
  KEY `FK_97A439C21D686FF_audit` (`saisie_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `digital_stat_day`
--

CREATE TABLE IF NOT EXISTS `digital_stat_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `user` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `children` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nbTotalContract` int(11) NOT NULL DEFAULT '0',
  `nbOperationActivation` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) NOT NULL DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) NOT NULL DEFAULT '0',
  `totalDurationPrevalidation` int(11) NOT NULL DEFAULT '0',
  `nbContractCompliance` int(11) NOT NULL DEFAULT '0',
  `totalDurationRemonte` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractRemonte` int(11) NOT NULL DEFAULT '0',
  `groupeType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_date` (`date`),
  KEY `IDX_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2881 ;

-- --------------------------------------------------------

--
-- Structure de la table `digital_stat_hour`
--

CREATE TABLE IF NOT EXISTS `digital_stat_hour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `nbOperationActivation` int(11) NOT NULL DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) NOT NULL DEFAULT '0',
  `totalDurationRemonte` int(11) NOT NULL DEFAULT '0',
  `totalDurationPrevalidation` int(11) NOT NULL DEFAULT '0',
  `user` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `children` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nbTotalContract` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) NOT NULL DEFAULT '0',
  `nbContractCompliance` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractRemonte` int(11) NOT NULL DEFAULT '0',
  `groupeType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_date` (`date`),
  KEY `IDX_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=61921 ;

-- --------------------------------------------------------

--
-- Structure de la table `digital_stat_month`
--

CREATE TABLE IF NOT EXISTS `digital_stat_month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `user` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `children` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nbTotalContract` int(11) NOT NULL DEFAULT '0',
  `nbOperationActivation` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) NOT NULL DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) NOT NULL DEFAULT '0',
  `totalDurationPrevalidation` int(11) NOT NULL DEFAULT '0',
  `nbContractCompliance` int(11) NOT NULL DEFAULT '0',
  `totalDurationRemonte` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractRemonte` int(11) NOT NULL DEFAULT '0',
  `groupeType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_date` (`date`),
  KEY `IDX_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=481 ;

-- --------------------------------------------------------

--
-- Structure de la table `digital_stat_week`
--

CREATE TABLE IF NOT EXISTS `digital_stat_week` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `user` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `children` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nbTotalContract` int(11) NOT NULL DEFAULT '0',
  `nbOperationActivation` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) NOT NULL DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) NOT NULL DEFAULT '0',
  `totalDurationPrevalidation` int(11) NOT NULL DEFAULT '0',
  `nbContractCompliance` int(11) NOT NULL DEFAULT '0',
  `totalDurationRemonte` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractRemonte` int(11) NOT NULL DEFAULT '0',
  `groupeType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_date` (`date`),
  KEY `IDX_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=961 ;

-- --------------------------------------------------------

--
-- Structure de la table `digital_stat_year`
--

CREATE TABLE IF NOT EXISTS `digital_stat_year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `user` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `children` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `nbTotalContract` int(11) NOT NULL DEFAULT '0',
  `nbOperationActivation` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractPrevalidated` int(11) NOT NULL DEFAULT '0',
  `nbContractAutoPrevalidated` int(11) NOT NULL DEFAULT '0',
  `totalDurationPrevalidation` int(11) NOT NULL DEFAULT '0',
  `nbContractCompliance` int(11) NOT NULL DEFAULT '0',
  `totalDurationRemonte` int(11) NOT NULL DEFAULT '0',
  `nbTotalContractRemonte` int(11) NOT NULL DEFAULT '0',
  `groupeType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_date` (`date`),
  KEY `IDX_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=161 ;

-- --------------------------------------------------------

--
-- Structure de la table `distributor_stock_history`
--

CREATE TABLE IF NOT EXISTS `distributor_stock_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `stock_history_global` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `stock_history_detail` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_324D3095A76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `download`
--

CREATE TABLE IF NOT EXISTS `download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_by` int(11) DEFAULT NULL,
  `queue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `from_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL DEFAULT '0',
  `nb_lines` int(11) NOT NULL DEFAULT '0',
  `total_lines` int(11) NOT NULL DEFAULT '0',
  `short_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nb_download` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_816CE026DE12AB56` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `dsa_stock_seuil`
--

CREATE TABLE IF NOT EXISTS `dsa_stock_seuil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seuil_sim_dsa` int(11) NOT NULL DEFAULT '10',
  `seuil_msisdn_dsa` int(11) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `dsa_stock_seuil_audit`
--

CREATE TABLE IF NOT EXISTS `dsa_stock_seuil_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `seuil_sim_dsa` int(11) DEFAULT '10',
  `seuil_msisdn_dsa` int(11) DEFAULT '10',
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_4f6a1eb1ade70bb1cb37dacd253bcbd8_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `echange_sims`
--

CREATE TABLE IF NOT EXISTS `echange_sims` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_from` int(11) DEFAULT NULL,
  `user_to` int(11) DEFAULT NULL,
  `pack_id` bigint(20) DEFAULT NULL,
  `qtte` int(11) NOT NULL,
  `action` smallint(6) NOT NULL,
  `actionAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C5E3308DC39BEDB9` (`user_from`),
  KEY `IDX_C5E3308DCFD06601` (`user_to`),
  KEY `IDX_C5E3308D1919B217` (`pack_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=27 ;

-- --------------------------------------------------------

--
-- Structure de la table `echec_bscs_ema`
--

CREATE TABLE IF NOT EXISTS `echec_bscs_ema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imported_at` datetime NOT NULL,
  `sim` bigint(20) NOT NULL,
  `msisdn` int(11) DEFAULT NULL,
  `service_class` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code_retour_bscs` int(11) DEFAULT NULL,
  `message_retour_bscs` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_BAD2E7CB2ECAC210` (`sim`),
  UNIQUE KEY `UNIQ_BAD2E7CB4439F478` (`service_class`),
  UNIQUE KEY `UNIQ_BAD2E7CBD8AB44` (`msisdn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `eligibility`
--

CREATE TABLE IF NOT EXISTS `eligibility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maximum_number_sim` int(11) NOT NULL,
  `number_month` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `eligibility_audit`
--

CREATE TABLE IF NOT EXISTS `eligibility_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `maximum_number_sim` int(11) DEFAULT NULL,
  `number_month` int(11) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_37d01411080db344dd74bb8e6876dc0e_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `external_stock_operation`
--

CREATE TABLE IF NOT EXISTS `external_stock_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CODE_ETT` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `DES_ETT` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_PUBLITEL` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DES_PUBLITEL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_OP` datetime NOT NULL,
  `NS_DEBUT` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `NS_FIN` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `QTE` int(11) NOT NULL,
  `TYPE_OP` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `MESSAGE` longtext COLLATE utf8_unicode_ci,
  `ETAT` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_date_op` (`DATE_OP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Déclencheurs `external_stock_operation`
--
DROP TRIGGER IF EXISTS `log_interfacage_trigger`;
DELIMITER //
CREATE TRIGGER `log_interfacage_trigger` AFTER INSERT ON `external_stock_operation`
 FOR EACH ROW begin
  INSERT INTO `log_interfacage` ( `CODE_ETT`, `DES_ETT`, `CODE_PUBLITEL`, `DES_PUBLITEL`, `DATE_OP`, `NS_DEBUT`, `NS_FIN`, `QTE`, `TYPE_OP`) VALUES (new.CODE_ETT, new.DES_ETT, new.CODE_PUBLITEL, new.DES_PUBLITEL, new.DATE_OP, new.NS_DEBUT, new.NS_FIN, new.QTE, new.TYPE_OP);
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `fos_group`
--

CREATE TABLE IF NOT EXISTS `fos_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `parent_stocks` int(11) DEFAULT NULL,
  `countuser` int(11) NOT NULL,
  `customer_charge` tinyint(1) DEFAULT NULL,
  `type_cna` smallint(6) DEFAULT NULL,
  `is_one_time_session` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4B019DDB5E237E06` (`name`),
  KEY `IDX_4B019DDBC54C8C93` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=47 ;

-- --------------------------------------------------------

--
-- Structure de la table `fos_user`
--

CREATE TABLE IF NOT EXISTS `fos_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_user_id` int(11) DEFAULT NULL,
  `gouvernorat_id` int(11) DEFAULT NULL,
  `delegation_id` int(11) DEFAULT NULL,
  `code_postal_id` int(11) DEFAULT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `allowreport` tinyint(1) DEFAULT NULL,
  `allow_mobile_sell` int(11) DEFAULT NULL,
  `allow_webservice_sell` int(11) DEFAULT NULL,
  `cin` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otp` tinyint(1) NOT NULL,
  `email_responsable` longtext COLLATE utf8_unicode_ci,
  `fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `oldpassword` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `prefix` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8_unicode_ci,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notification` longtext COLLATE utf8_unicode_ci NOT NULL,
  `code_conventionnel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` int(11) DEFAULT NULL,
  `matricule_fiscal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userDistributor_id` int(11) DEFAULT NULL,
  `digitalised` tinyint(1) DEFAULT '0',
  `activation_story` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userDistributorBO_id` int(11) DEFAULT NULL,
  `hierarchy` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `withChild` tinyint(1) DEFAULT '0',
  `motif_desactivation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logged` tinyint(1) DEFAULT NULL,
  `session_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mapping_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_bo` int(11) DEFAULT NULL,
  `nb_contract_offline_nonRemonte` int(11) DEFAULT NULL,
  `delai_remonte_contract_offline` int(11) DEFAULT NULL,
  `max_nb_contract_offline_nonRemonte` int(11) DEFAULT NULL,
  `max_delai_remonte_contract_offline` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_957A647992FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_957A6479F85E0677` (`username`),
  UNIQUE KEY `UNIQ_957A6479A13CAFFE` (`userDistributor_id`),
  KEY `IDX_957A6479D526A7D3` (`parent_user_id`),
  KEY `IDX_957A647975B74E2D` (`gouvernorat_id`),
  KEY `IDX_957A647956CBBCF5` (`delegation_id`),
  KEY `IDX_957A6479B2B59251` (`code_postal_id`),
  KEY `IDX_cin` (`cin`),
  KEY `IDX_phone` (`phone`),
  KEY `IDX_username` (`username`),
  KEY `IDX_enabled` (`enabled`),
  KEY `IDX_957A647946781D86` (`userDistributorBO_id`),
  KEY `IDX_957A647953FCFE54` (`code_bo`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15947 ;

-- --------------------------------------------------------

--
-- Structure de la table `fos_user_user_group`
--

CREATE TABLE IF NOT EXISTS `fos_user_user_group` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `IDX_B3C77447A76ED395` (`user_id`),
  KEY `IDX_B3C77447FE54D947` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `franchise`
--

CREATE TABLE IF NOT EXISTS `franchise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distributeur_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `mapping_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_66F6CE2A5E237E06` (`name`),
  KEY `IDX_66F6CE2A29EB7ACA` (`distributeur_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

--
-- Structure de la table `geolocation`
--

CREATE TABLE IF NOT EXISTS `geolocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operation_activation_id` int(11) DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9DC0E5B41834EE96` (`operation_activation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `gouvernorat`
--

CREATE TABLE IF NOT EXISTS `gouvernorat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `code_default` int(11) DEFAULT NULL,
  `labelBscs` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- Structure de la table `historique_user`
--

CREATE TABLE IF NOT EXISTS `historique_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_user_id` int(11) NOT NULL,
  `action_user_login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `result_user_id` int(11) NOT NULL,
  `result_user_login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `modification` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_modif` datetime NOT NULL,
  `story` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cause` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=139197 ;

-- --------------------------------------------------------

--
-- Structure de la table `import_sims`
--

CREATE TABLE IF NOT EXISTS `import_sims` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `imported_at` datetime NOT NULL,
  `status_text` longtext COLLATE utf8_unicode_ci,
  `status` smallint(6) NOT NULL,
  `checksum` longtext COLLATE utf8_unicode_ci NOT NULL,
  `nbr_ligne` int(11) DEFAULT NULL,
  `nbr_packs` int(11) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `forceUpdate` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_EBBBFB2DA76ED395` (`user_id`),
  KEY `IDX_status` (`status`),
  KEY `IDX_filename` (`filename`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1062 ;

-- --------------------------------------------------------

--
-- Structure de la table `infocentreactivation`
--

CREATE TABLE IF NOT EXISTS `infocentreactivation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `BSCS_CUST_CODE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NUM_SIM_INFO` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `MSISDN` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_ACTIVATION` datetime NOT NULL,
  `CODE_CONTRACT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `BSCS_CO_ACTIVATED` datetime NOT NULL,
  `USER_LOGIN` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_PIECE_IDENT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NUM_PIECE_IDENT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_POS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `SYSTEME_SOURCE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DIST` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_DIST` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_CHGT` datetime DEFAULT NULL,
  `CONTR_PACK` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `OFFRE_PRODUIT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NUM_SIM_INFO` (`NUM_SIM_INFO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `infocentresaisie`
--

CREATE TABLE IF NOT EXISTS `infocentresaisie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NUMERO_APPEL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NUMERO_SERIE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_SAISIE` datetime NOT NULL,
  `LOGIN` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NOM_PRENOM` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_CONTRAT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CODE_CLIENT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `TYPE_PIECE_IDENT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `NUM_PIECE_IDENT` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `DATE_CHGT` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NUMERO_SERIE` (`NUMERO_SERIE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `info_bscs`
--

CREATE TABLE IF NOT EXISTS `info_bscs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) DEFAULT NULL,
  `town_id` int(11) DEFAULT NULL,
  `gouvernorat_id` int(11) DEFAULT NULL,
  `localite_id` int(11) DEFAULT NULL,
  `type_pi_saisie` int(11) DEFAULT NULL,
  `pi_saisie` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nationalityPasseport` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `titre` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sexe` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `situation` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `langue` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pays` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rue` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `houseNo` int(11) DEFAULT NULL,
  `cityOrBuilding` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `floorNo` int(11) DEFAULT NULL,
  `emailAddr` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telNo1` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nationalite` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_contract` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_386BFCF12576E0FD` (`contract_id`),
  KEY `IDX_386BFCF175E23604` (`town_id`),
  KEY `IDX_386BFCF175B74E2D` (`gouvernorat_id`),
  KEY `IDX_386BFCF1924DD2B5` (`localite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `localite`
--

CREATE TABLE IF NOT EXISTS `localite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delegation_id` int(11) DEFAULT NULL,
  `code_postal` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5D7E4A956CBBCF5` (`delegation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4063 ;

-- --------------------------------------------------------

--
-- Structure de la table `log_action`
--

CREATE TABLE IF NOT EXISTS `log_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_ip` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` int(11) NOT NULL,
  `discriminator` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `site_cna_id` int(11) DEFAULT NULL,
  `site` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `action_by_id` int(11) NOT NULL,
  `digital_contract_id` int(11) DEFAULT NULL,
  `rev_contract_id` int(11) DEFAULT NULL,
  `bon_livraison_id` int(11) DEFAULT NULL,
  `rev_bl_id` int(11) DEFAULT NULL,
  `action_key` bigint(20) NOT NULL,
  `bordereau_id` int(11) DEFAULT NULL,
  `rev_bordereau_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5236DF3073943760` (`site_cna_id`),
  KEY `IDX_5236DF304D29ECB8` (`action_by_id`),
  KEY `rev_bl_id` (`rev_bl_id`),
  KEY `rev_contract_id` (`rev_contract_id`),
  KEY `IDX_5236DF30F9CC00496B78BEAB` (`digital_contract_id`,`rev_contract_id`),
  KEY `IDX_5236DF30D8D16068D9357EA5` (`bon_livraison_id`,`rev_bl_id`),
  KEY `IDX_5236DF3055D5304ED793CAD1` (`bordereau_id`,`rev_bordereau_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `log_interfacage`
--

CREATE TABLE IF NOT EXISTS `log_interfacage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CODE_ETT` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `DES_ETT` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_PUBLITEL` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DES_PUBLITEL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_OP` datetime NOT NULL,
  `NS_DEBUT` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `NS_FIN` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `QTE` int(11) NOT NULL,
  `TYPE_OP` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `ETAT` int(11) NOT NULL DEFAULT '0',
  `MESSAGE` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_date_op` (`DATE_OP`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=112787 ;

-- --------------------------------------------------------

--
-- Structure de la table `mailadress`
--

CREATE TABLE IF NOT EXISTS `mailadress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_offre_id` int(11) DEFAULT NULL,
  `mailAdress` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AAE68FAB911F9112` (`mail_offre_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `mailoffre`
--

CREATE TABLE IF NOT EXISTS `mailoffre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contenu` longtext COLLATE utf8_unicode_ci NOT NULL,
  `nbmailoffre` int(11) NOT NULL,
  `updated_at` datetime NOT NULL,
  `nb_days` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `mail_ema_maj`
--

CREATE TABLE IF NOT EXISTS `mail_ema_maj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone` int(11) DEFAULT NULL,
  `mailAdress` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8C87EA0D444F97DD` (`phone`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `maj_bscs_ema`
--

CREATE TABLE IF NOT EXISTS `maj_bscs_ema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doMAJBscs` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `message_reply`
--

CREATE TABLE IF NOT EXISTS `message_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `code` int(11) NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `channel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=44 ;

-- --------------------------------------------------------

--
-- Structure de la table `mobile_dsa`
--

CREATE TABLE IF NOT EXISTS `mobile_dsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blocking_time` int(11) NOT NULL,
  `maximum_number_size` int(11) NOT NULL,
  `maximum_number_msisdn_dsa` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `mobile_dsa_audit`
--

CREATE TABLE IF NOT EXISTS `mobile_dsa_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `blocking_time` int(11) DEFAULT NULL,
  `maximum_number_size` int(11) DEFAULT NULL,
  `maximum_number_msisdn_dsa` int(11) DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_38d65215382bc16609fb1796497935ad_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `msisdn`
--

CREATE TABLE IF NOT EXISTS `msisdn` (
  `msisdn` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `sim_pack_id` bigint(20) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `sim` bigint(20) NOT NULL,
  `imsi` bigint(20) DEFAULT NULL,
  `imported_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sold_at` datetime DEFAULT NULL,
  `cutoff_at` datetime DEFAULT NULL,
  `sold` smallint(6) NOT NULL,
  `cutoff` smallint(6) NOT NULL,
  `isDsa` tinyint(1) DEFAULT '0',
  `brand_dsa_id` int(11) DEFAULT NULL,
  `offre_dsa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`msisdn`),
  UNIQUE KEY `UNIQ_D8AB442ECAC210` (`sim`),
  UNIQUE KEY `UNIQ_D8AB441719CC2F` (`imsi`),
  KEY `IDX_D8AB44A76ED395` (`user_id`),
  KEY `IDX_D8AB4484EA4054` (`sim_pack_id`),
  KEY `IDX_D8AB4444F5D008` (`brand_id`),
  KEY `sold_idx` (`sold`),
  KEY `IDX_D8AB445C786BA` (`brand_dsa_id`),
  KEY `IDX_D8AB44E1C59A9F` (`offre_dsa_id`),
  KEY `sold_at_idx` (`sold_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `msisdn_dsa`
--

CREATE TABLE IF NOT EXISTS `msisdn_dsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn` bigint(20) NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `locked_at` datetime DEFAULT NULL,
  `second_lock` tinyint(1) DEFAULT '0',
  `second_locked_at` datetime DEFAULT NULL,
  `brand_dsa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4BE9EA135C786BA` (`brand_dsa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Structure de la table `msisdn_history`
--

CREATE TABLE IF NOT EXISTS `msisdn_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `campagne_id` int(11) DEFAULT NULL,
  `sim_pack_id` bigint(20) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `sim` bigint(20) NOT NULL,
  `action_at` datetime NOT NULL,
  `action` smallint(6) NOT NULL,
  `extra_info` longtext COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `piece_identif` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pays` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isDigitalised` tinyint(1) DEFAULT '0',
  `brand_dsa_id` int(11) DEFAULT NULL,
  `isDsa` tinyint(1) DEFAULT '0',
  `imsi` bigint(20) DEFAULT NULL,
  `offre_dsa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_45E444F7D429DFE8` (`msisdn_id`),
  KEY `IDX_45E444F7A76ED395` (`user_id`),
  KEY `IDX_45E444F716227374` (`campagne_id`),
  KEY `IDX_45E444F784EA4054` (`sim_pack_id`),
  KEY `IDX_45E444F744F5D008` (`brand_id`),
  KEY `action_at_idx` (`action_at`),
  KEY `action_idx` (`action`),
  KEY `IDX_45E444F75C786BA` (`brand_dsa_id`),
  KEY `IDX_45E444F7E1C59A9F` (`offre_dsa_id`),
  KEY `IDX_45E444F747CC8C922ECAC210` (`action`,`sim`),
  KEY `sim_idx` (`sim`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=583807 ;

-- --------------------------------------------------------

--
-- Structure de la table `msisdn_provisioning`
--

CREATE TABLE IF NOT EXISTS `msisdn_provisioning` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msisdn_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `sim` bigint(20) NOT NULL,
  `action_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_53F9C412D429DFE8` (`msisdn_id`),
  KEY `IDX_53F9C412A76ED395` (`user_id`),
  KEY `IDX_53F9C41244F5D008` (`brand_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3109716 ;

-- --------------------------------------------------------

--
-- Structure de la table `notification_stock`
--

CREATE TABLE IF NOT EXISTS `notification_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `stock_disponible_nbr` int(11) NOT NULL,
  `stock_disponible_percent` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `readed` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8D82B399A76ED395` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

CREATE TABLE IF NOT EXISTS `offre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `produit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `mapping_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_AF86866F2B36786B` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=385 ;

-- --------------------------------------------------------

--
-- Structure de la table `offre_dsa`
--

CREATE TABLE IF NOT EXISTS `offre_dsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_dsa_id` int(11) NOT NULL,
  `label_offers` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `trade_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_code` int(11) DEFAULT NULL,
  `status_offers` tinyint(1) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `sms` longtext COLLATE utf8_unicode_ci,
  `rp_shdes` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_xml` longtext COLLATE utf8_unicode_ci,
  `nbreUtilisation` int(11) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT NULL,
  `desactivated_by` int(11) DEFAULT NULL,
  `activated_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `desactivated_at` datetime DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `statusOnAt` datetime DEFAULT NULL,
  `statusOffAt` datetime DEFAULT NULL,
  `statusOn_by` int(11) DEFAULT NULL,
  `statusOff_by` int(11) DEFAULT NULL,
  `specific_offre` tinyint(1) NOT NULL DEFAULT '0',
  `distributer_status` int(1) NOT NULL DEFAULT '0',
  `distributers` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `franchise_status` int(1) NOT NULL DEFAULT '0',
  `franchises` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `ett_status` int(1) NOT NULL DEFAULT '0',
  `etts` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6E1ED93C3CD809FD` (`trade_name`),
  UNIQUE KEY `UNIQ_6E1ED93C15EE4763` (`trade_code`),
  KEY `IDX_6E1ED93C5C786BA` (`brand_dsa_id`),
  KEY `IDX_6E1ED93CDE12AB56` (`created_by`),
  KEY `IDX_6E1ED93C4E5BB1E2` (`desactivated_by`),
  KEY `IDX_6E1ED93C255FA5E4` (`activated_by`),
  KEY `IDX_6E1ED93CBBA9CC0A` (`statusOn_by`),
  KEY `IDX_6E1ED93C23632774` (`statusOff_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `offre_dsa_audit`
--

CREATE TABLE IF NOT EXISTS `offre_dsa_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `brand_dsa_id` int(11) DEFAULT NULL,
  `label_offers` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trade_code` int(11) DEFAULT NULL,
  `status_offers` tinyint(1) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `sms` longtext COLLATE utf8_unicode_ci,
  `content_xml` longtext COLLATE utf8_unicode_ci,
  `rp_shdes` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nbreUtilisation` int(11) DEFAULT '0',
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `desactivated_by` int(11) DEFAULT NULL,
  `activated_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `desactivated_at` datetime DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `statusOnAt` datetime DEFAULT NULL,
  `statusOffAt` datetime DEFAULT NULL,
  `statusOn_by` int(11) DEFAULT NULL,
  `statusOff_by` int(11) DEFAULT NULL,
  `specific_offre` tinyint(1) NOT NULL DEFAULT '0',
  `distributer_status` int(1) NOT NULL DEFAULT '0',
  `distributers` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `franchise_status` int(1) NOT NULL DEFAULT '0',
  `franchises` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `ett_status` int(1) NOT NULL DEFAULT '0',
  `etts` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_3cfc7fc487b7a5e4a0092ead3d99abda_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `old_sim`
--

CREATE TABLE IF NOT EXISTS `old_sim` (
  `numero` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `sim` bigint(20) NOT NULL,
  `sold_at` datetime DEFAULT NULL,
  `sold` smallint(6) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `IDX_B1F3F928A76ED395` (`user_id`),
  KEY `oldsims_idx` (`numero`,`user_id`,`sold`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `operation_activation`
--

CREATE TABLE IF NOT EXISTS `operation_activation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `msisdn` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `text_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sim` bigint(20) DEFAULT NULL,
  `channel` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `piece_identif` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pays` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dirnum` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `offre_id` int(11) DEFAULT NULL,
  `isDsa` tinyint(1) DEFAULT '0',
  `brand_dsa_id` int(11) DEFAULT NULL,
  `isEma` tinyint(1) DEFAULT '0',
  `syncBscs` tinyint(1) DEFAULT '0',
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `zone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_52FF0FAAA76ED395` (`user_id`),
  KEY `IDX_52FF0FAA44F5D008` (`brand_id`),
  KEY `IDX_msisdn` (`msisdn`),
  KEY `IDX_status` (`status`),
  KEY `IDX_created_at` (`created_at`),
  KEY `IDX_52FF0FAA4CC8505A` (`offre_id`),
  KEY `IDX_52FF0FAA5C786BA` (`brand_dsa_id`),
  KEY `IDX_52FF0FAA7B00651CA76ED39543625D9F` (`status`,`user_id`,`updated_at`),
  KEY `IDX_52FF0FAA7B00651C68A3281CC5AC246F8B8E8428` (`status`,`cin_pp`,`piece_identif`,`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=639609 ;

-- --------------------------------------------------------

--
-- Structure de la table `performance_pos`
--

CREATE TABLE IF NOT EXISTS `performance_pos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pos_id` int(11) DEFAULT NULL,
  `stock_init` int(11) NOT NULL DEFAULT '0',
  `stock_recu` int(11) NOT NULL DEFAULT '0',
  `stock_vendu` int(11) NOT NULL DEFAULT '0',
  `stock_restant` int(11) NOT NULL DEFAULT '0',
  `performance` tinyint(1) NOT NULL,
  `stock_recupere` int(11) NOT NULL DEFAULT '0',
  `stock_old_vendu` int(11) NOT NULL DEFAULT '0',
  `indicateur` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AC065B9EA76ED395` (`user_id`),
  KEY `IDX_AC065B9E41085FAE` (`pos_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=30 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_action_type`
--

CREATE TABLE IF NOT EXISTS `pilotage_action_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_concept`
--

CREATE TABLE IF NOT EXISTS `pilotage_concept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_product`
--

CREATE TABLE IF NOT EXISTS `pilotage_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `sales` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `stMktgAction_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D9C3A98744F5D008` (`brand_id`),
  KEY `IDX_D9C3A987145AEEFF` (`stMktgAction_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_reason_cancel`
--

CREATE TABLE IF NOT EXISTS `pilotage_reason_cancel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_street_marketing_action`
--

CREATE TABLE IF NOT EXISTS `pilotage_street_marketing_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gouvernorat_id` int(11) DEFAULT NULL,
  `delegation_id` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `goal` longtext COLLATE utf8_unicode_ci,
  `address` longtext COLLATE utf8_unicode_ci NOT NULL,
  `is_validated` tinyint(1) NOT NULL,
  `validated_at` datetime DEFAULT NULL,
  `started_at` datetime NOT NULL,
  `ended_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `codePostal_id` int(11) DEFAULT NULL,
  `actionType_id` int(11) DEFAULT NULL,
  `reasonCancel_id` int(11) DEFAULT NULL,
  `userPv_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3FE03CE275B74E2D` (`gouvernorat_id`),
  KEY `IDX_3FE03CE256CBBCF5` (`delegation_id`),
  KEY `IDX_3FE03CE24B405581` (`codePostal_id`),
  KEY `IDX_3FE03CE231F263E7` (`actionType_id`),
  KEY `IDX_3FE03CE2F909284E` (`concept_id`),
  KEY `IDX_3FE03CE2EA51F673` (`reasonCancel_id`),
  KEY `IDX_3FE03CE2EC1E766` (`userPv_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_street_marketing_action_user`
--

CREATE TABLE IF NOT EXISTS `pilotage_street_marketing_action_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addedAt` datetime NOT NULL,
  `stMktgActionId_id` int(11) DEFAULT NULL,
  `userId_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C9638F685E5BF189` (`stMktgActionId_id`),
  KEY `IDX_C9638F6899218D81` (`userId_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_validation_type`
--

CREATE TABLE IF NOT EXISTS `pilotage_validation_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `is_automatic_DVD` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_automatic_DVI` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1ACAE6EFA76ED395` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `pilotage_validation_type_audit`
--

CREATE TABLE IF NOT EXISTS `pilotage_validation_type_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_automatic_DVD` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `is_automatic_DVI` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_4c3fc2394f948200fe620aab58b5d66f_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `plage`
--

CREATE TABLE IF NOT EXISTS `plage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) NOT NULL,
  `rangefrom` bigint(20) NOT NULL,
  `rangeto` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_107196C944F5D008` (`brand_id`),
  KEY `IDX_rangefrom` (`rangefrom`),
  KEY `IDX_rangeto` (`rangeto`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=64 ;

-- --------------------------------------------------------

--
-- Structure de la table `point_vente`
--

CREATE TABLE IF NOT EXISTS `point_vente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gouvernorat_id` int(11) DEFAULT NULL,
  `delegation_id` int(11) DEFAULT NULL,
  `nom` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reseau` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_proprieteTT` tinyint(1) DEFAULT NULL,
  `date_contract` datetime DEFAULT NULL,
  `duree_location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `montant_loyer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_propre` tinyint(1) DEFAULT NULL,
  `rent_paid_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rent_topay` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `proprietaire` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_proprietaire` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_mise_service` datetime DEFAULT NULL,
  `date_prev_ouverture` datetime DEFAULT NULL,
  `budget` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_validation` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_validation` datetime DEFAULT NULL,
  `date_proposition` datetime DEFAULT NULL,
  `attente_commission` tinyint(1) DEFAULT NULL,
  `attente_visite` tinyint(1) DEFAULT NULL,
  `motif_refus` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nom_responsable` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prenom_responsable` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cin_responsable` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `typePVente_id` int(11) DEFAULT NULL,
  `codePostal_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2BBFAADF96F79D71` (`typePVente_id`),
  KEY `IDX_2BBFAADF75B74E2D` (`gouvernorat_id`),
  KEY `IDX_2BBFAADF56CBBCF5` (`delegation_id`),
  KEY `IDX_2BBFAADF4B405581` (`codePostal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `prefix_dsa`
--

CREATE TABLE IF NOT EXISTS `prefix_dsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prefix` int(11) NOT NULL,
  `brand_dsa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BFB523D25C786BA` (`brand_dsa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Structure de la table `prefix_dsa_audit`
--

CREATE TABLE IF NOT EXISTS `prefix_dsa_audit` (
  `id` int(11) NOT NULL,
  `rev` int(11) NOT NULL,
  `brand_dsa_id` int(11) DEFAULT NULL,
  `prefix` int(11) DEFAULT NULL,
  `revtype` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `rev_5aabee624fb864bb6fd1b0687841dc8e_idx` (`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `quantity`
--

CREATE TABLE IF NOT EXISTS `quantity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `stock_pred_total_dispo` int(11) NOT NULL DEFAULT '0',
  `stock_pred_total_vendu` int(11) NOT NULL DEFAULT '0',
  `stock_dsa_total_dispo` int(11) NOT NULL DEFAULT '0',
  `stock_dsa_total_vendu` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_9FF31636A76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `quantity_marque`
--

CREATE TABLE IF NOT EXISTS `quantity_marque` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_dsa_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `quantity_id` int(11) NOT NULL,
  `stock_dispo` int(11) NOT NULL DEFAULT '0',
  `stock_vendu` int(11) NOT NULL DEFAULT '0',
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_57D7DCDC5C786BA` (`brand_dsa_id`),
  KEY `IDX_57D7DCDC44F5D008` (`brand_id`),
  KEY `IDX_57D7DCDC7E8B4AFC` (`quantity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `recyclage_history`
--

CREATE TABLE IF NOT EXISTS `recyclage_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `msisdn` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `old_sim` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `new_sim` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `old_status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `new_status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `old_owner` int(11) DEFAULT NULL,
  `new_owner` int(11) DEFAULT NULL,
  `old_brand` int(11) DEFAULT NULL,
  `new_brand` int(11) DEFAULT NULL,
  `sell_date` datetime DEFAULT NULL,
  `cutoff_date` datetime DEFAULT NULL,
  `new_msisdn` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `isDsa` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_3121D75B69F42C9A` (`old_owner`),
  KEY `IDX_3121D75B37F6A5A1` (`new_owner`),
  KEY `IDX_3121D75BBAC633BE` (`old_brand`),
  KEY `IDX_3121D75BE4C4BA85` (`new_brand`),
  KEY `IDX_new_sim` (`msisdn`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Structure de la table `relance_external_stock_operation`
--

CREATE TABLE IF NOT EXISTS `relance_external_stock_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CODE_ETT` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `DES_ETT` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CODE_PUBLITEL` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DES_PUBLITEL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DATE_OP` datetime NOT NULL,
  `NS_DEBUT` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `NS_FIN` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `QTE` int(11) NOT NULL,
  `TYPE_OP` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `MESSAGE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_date_op` (`DATE_OP`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9318 ;

-- --------------------------------------------------------

--
-- Structure de la table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `channel` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C42F778477153098` (`code`),
  UNIQUE KEY `UNIQ_C42F77845E237E06` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Structure de la table `report_group`
--

CREATE TABLE IF NOT EXISTS `report_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `recipient_emails` longtext CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `cc_emails` longtext CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Structure de la table `report_group_gouvernorat`
--

CREATE TABLE IF NOT EXISTS `report_group_gouvernorat` (
  `report_group_id` int(11) NOT NULL,
  `gouvernorat_id` int(11) NOT NULL,
  KEY `IDX_957A6579D726A7D8` (`report_group_id`),
  KEY `IDX_957A6579D726A7D9` (`gouvernorat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `revisions`
--

CREATE TABLE IF NOT EXISTS `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3818 ;

-- --------------------------------------------------------

--
-- Structure de la table `sequencebonlivraison`
--

CREATE TABLE IF NOT EXISTS `sequencebonlivraison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=86 ;

-- --------------------------------------------------------

--
-- Structure de la table `sequencebordereau`
--

CREATE TABLE IF NOT EXISTS `sequencebordereau` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `sim`
--

CREATE TABLE IF NOT EXISTS `sim` (
  `sim` bigint(20) NOT NULL,
  `brand_dsa_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `sim_pack_id` bigint(20) NOT NULL,
  `msisdn` int(11) DEFAULT NULL,
  `imsi` bigint(20) DEFAULT NULL,
  `sold_at` datetime DEFAULT NULL,
  `sold` smallint(6) NOT NULL,
  `is_dsa` tinyint(1) NOT NULL,
  PRIMARY KEY (`sim`),
  UNIQUE KEY `UNIQ_2ECAC2102ECAC210` (`sim`),
  KEY `IDX_2ECAC2105C786BA` (`brand_dsa_id`),
  KEY `IDX_2ECAC21044F5D008` (`brand_id`),
  KEY `IDX_2ECAC210A76ED395` (`user_id`),
  KEY `IDX_2ECAC21084EA4054` (`sim_pack_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sim_dsa`
--

CREATE TABLE IF NOT EXISTS `sim_dsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_dsa_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `sim` bigint(20) NOT NULL,
  `imsi` bigint(20) NOT NULL,
  `sim_pack` bigint(20) NOT NULL,
  `imported_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sold_at` datetime DEFAULT NULL,
  `sold` smallint(6) NOT NULL DEFAULT '0',
  `msisdn` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ECA2FF552ECAC210` (`sim`),
  UNIQUE KEY `UNIQ_ECA2FF551719CC2F` (`imsi`),
  KEY `IDX_ECA2FF55A76ED395` (`user_id`),
  KEY `IDX_ECA2FF55E160858D` (`sim_pack`),
  KEY `IDX_ECA2FF555C786BA` (`brand_dsa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=395 ;

-- --------------------------------------------------------

--
-- Structure de la table `sim_import`
--

CREATE TABLE IF NOT EXISTS `sim_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `simfrom` bigint(20) NOT NULL,
  `total_sims` int(11) NOT NULL,
  `imported_at` datetime NOT NULL,
  `final_imported_id` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BCCB2298A76ED395` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=116085 ;

-- --------------------------------------------------------

--
-- Structure de la table `sim_pack`
--

CREATE TABLE IF NOT EXISTS `sim_pack` (
  `simfrom` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `distribute_by` int(11) DEFAULT NULL,
  `simimport_id` int(11) NOT NULL,
  `recover_user_id` int(11) DEFAULT NULL,
  `total_sims` int(11) NOT NULL,
  `imported_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `sold_sims_count` int(11) NOT NULL,
  `cutoff_sims_count` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `distributed_at` datetime DEFAULT NULL,
  `recuperated_at` datetime DEFAULT NULL,
  `isDsa` tinyint(1) DEFAULT '0',
  `brand_dsa_id` int(11) DEFAULT NULL,
  `old_user` int(11) DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  PRIMARY KEY (`simfrom`),
  KEY `IDX_E160858DA76ED395` (`user_id`),
  KEY `IDX_E160858DA3C8C8B0` (`distribute_by`),
  KEY `IDX_E160858D772AC561` (`simimport_id`),
  KEY `IDX_E160858DD1809D21` (`recover_user_id`),
  KEY `IDX_status` (`status`),
  KEY `IDX_E160858D44F5D008` (`brand_id`),
  KEY `IDX_E160858D5C786BA` (`brand_dsa_id`),
  KEY `IDX_E160858DA50E57EC` (`old_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sim_stat`
--

CREATE TABLE IF NOT EXISTS `sim_stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `n_publitel` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `piece_identif` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `cin_pp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `nbr_sim` int(11) DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `nbr_sim_data` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_n_publitel` (`n_publitel`),
  KEY `IDX_cin_pp` (`cin_pp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=502242 ;

-- --------------------------------------------------------

--
-- Structure de la table `sms_mo`
--

CREATE TABLE IF NOT EXISTS `sms_mo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `timecreated` datetime NOT NULL,
  `soa` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `da` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `raw` longtext COLLATE utf8_unicode_ci,
  `status` int(11) DEFAULT NULL,
  `tryscount` int(11) DEFAULT NULL,
  `try` int(11) DEFAULT NULL,
  `timenextfetch` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `sms_mt`
--

CREATE TABLE IF NOT EXISTS `sms_mt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `da` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `raw` longtext COLLATE utf8_unicode_ci,
  `status` int(11) DEFAULT NULL,
  `tryscount` int(11) DEFAULT NULL,
  `try` int(11) DEFAULT NULL,
  `timenextfetch` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=55 ;

-- --------------------------------------------------------

--
-- Structure de la table `stat_day`
--

CREATE TABLE IF NOT EXISTS `stat_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `vente_total` int(11) DEFAULT NULL,
  `stock_total` int(11) DEFAULT NULL,
  `vente_sous_campagne` int(11) DEFAULT NULL,
  `bonus_compagne` double DEFAULT NULL,
  `vente_sous_campagne_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_compagne_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_marque` longtext COLLATE utf8_unicode_ci,
  `vente_marque_pos` longtext COLLATE utf8_unicode_ci,
  `sucess_total` int(11) DEFAULT NULL,
  `sucess_par_pos` longtext COLLATE utf8_unicode_ci,
  `erreurs_total` int(11) DEFAULT NULL,
  `erreurs_par_pos` longtext COLLATE utf8_unicode_ci,
  `cutoff_total` int(11) DEFAULT NULL,
  `pos_actif_total` int(11) DEFAULT NULL,
  `pos_inactif_total` int(11) DEFAULT NULL,
  `pos_actives_total` int(11) DEFAULT NULL,
  `pos_desactives_total` int(11) DEFAULT NULL,
  `ussd_total` int(11) DEFAULT NULL,
  `ussd_par_pos` longtext COLLATE utf8_unicode_ci,
  `sms_total` int(11) DEFAULT NULL,
  `sms_par_pos` longtext COLLATE utf8_unicode_ci,
  `web_total` int(11) DEFAULT NULL,
  `web_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_gov` longtext COLLATE utf8_unicode_ci,
  `pos_status_par_pos` longtext COLLATE utf8_unicode_ci,
  `pos_enables_par_pos` longtext COLLATE utf8_unicode_ci,
  `mobile_total` int(11) DEFAULT NULL,
  `mobile_par_pos` longtext COLLATE utf8_unicode_ci,
  `digitalise_total` int(11) DEFAULT NULL,
  `digitalise_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_sous_campagne` int(11) DEFAULT NULL,
  `bonus_dsa_compagne` double DEFAULT NULL,
  `vente_dsa_marque` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_marque_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_dsa_total` int(11) DEFAULT NULL,
  `stock_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `offline_total` int(11) DEFAULT NULL,
  `offline_par_pos` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `date_idx` (`date`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=125 ;

-- --------------------------------------------------------

--
-- Structure de la table `stat_hour`
--

CREATE TABLE IF NOT EXISTS `stat_hour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `vente_total` int(11) DEFAULT NULL,
  `stock_total` int(11) DEFAULT NULL,
  `vente_sous_campagne` int(11) DEFAULT NULL,
  `bonus_compagne` double DEFAULT NULL,
  `vente_sous_campagne_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_compagne_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_marque` longtext COLLATE utf8_unicode_ci,
  `vente_marque_pos` longtext COLLATE utf8_unicode_ci,
  `sucess_total` int(11) DEFAULT NULL,
  `sucess_par_pos` longtext COLLATE utf8_unicode_ci,
  `erreurs_total` int(11) DEFAULT NULL,
  `erreurs_par_pos` longtext COLLATE utf8_unicode_ci,
  `cutoff_total` int(11) DEFAULT NULL,
  `pos_actif_total` int(11) DEFAULT NULL,
  `pos_inactif_total` int(11) DEFAULT NULL,
  `pos_actives_total` int(11) DEFAULT NULL,
  `pos_desactives_total` int(11) DEFAULT NULL,
  `ussd_total` int(11) DEFAULT NULL,
  `ussd_par_pos` longtext COLLATE utf8_unicode_ci,
  `sms_total` int(11) DEFAULT NULL,
  `sms_par_pos` longtext COLLATE utf8_unicode_ci,
  `web_total` int(11) DEFAULT NULL,
  `web_par_pos` longtext COLLATE utf8_unicode_ci,
  `mobile_total` int(11) DEFAULT NULL,
  `mobile_par_pos` longtext COLLATE utf8_unicode_ci,
  `digitalise_total` int(11) DEFAULT NULL,
  `digitalise_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_gov` longtext COLLATE utf8_unicode_ci,
  `pos_status_par_pos` longtext COLLATE utf8_unicode_ci,
  `pos_enables_par_pos` longtext COLLATE utf8_unicode_ci,
  `offline_total` int(11) DEFAULT NULL,
  `offline_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_total` int(11) DEFAULT NULL,
  `cutoff_dsa_total` int(11) DEFAULT NULL,
  `web_dsa_total` int(11) DEFAULT NULL,
  `mobile_dsa_total` int(11) DEFAULT NULL,
  `sms_dsa_total` int(11) DEFAULT NULL,
  `ussd_dsa_total` int(11) DEFAULT NULL,
  `digitalise_dsa_total` int(11) DEFAULT NULL,
  `offline_dsa_total` int(11) DEFAULT NULL,
  `vente_dsa_sous_campagne` int(11) DEFAULT NULL,
  `bonus_dsa_compagne` double DEFAULT NULL,
  `erreurs_dsa_total` int(11) DEFAULT NULL,
  `sucess_dsa_total` int(11) DEFAULT NULL,
  `vente_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_marque` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_par_gov` longtext COLLATE utf8_unicode_ci,
  `pos_dsa_status_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `success_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `erreur_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_marque_par_pos` longtext COLLATE utf8_unicode_ci,
  `web_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `sms_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `ussd_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `mobile_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `digitalise_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `offline_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_dsa_total` int(11) DEFAULT NULL,
  `stock_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `date_idx` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `stat_month`
--

CREATE TABLE IF NOT EXISTS `stat_month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `vente_total` int(11) DEFAULT NULL,
  `stock_total` int(11) DEFAULT NULL,
  `vente_sous_campagne` int(11) DEFAULT NULL,
  `bonus_compagne` double DEFAULT NULL,
  `vente_sous_campagne_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_compagne_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_marque` longtext COLLATE utf8_unicode_ci,
  `vente_marque_pos` longtext COLLATE utf8_unicode_ci,
  `sucess_total` int(11) DEFAULT NULL,
  `sucess_par_pos` longtext COLLATE utf8_unicode_ci,
  `erreurs_total` int(11) DEFAULT NULL,
  `erreurs_par_pos` longtext COLLATE utf8_unicode_ci,
  `cutoff_total` int(11) DEFAULT NULL,
  `pos_actif_total` int(11) DEFAULT NULL,
  `pos_inactif_total` int(11) DEFAULT NULL,
  `pos_actives_total` int(11) DEFAULT NULL,
  `pos_desactives_total` int(11) DEFAULT NULL,
  `ussd_total` int(11) DEFAULT NULL,
  `ussd_par_pos` longtext COLLATE utf8_unicode_ci,
  `sms_total` int(11) DEFAULT NULL,
  `sms_par_pos` longtext COLLATE utf8_unicode_ci,
  `web_total` int(11) DEFAULT NULL,
  `web_par_pos` longtext COLLATE utf8_unicode_ci,
  `mobile_total` int(11) DEFAULT NULL,
  `mobile_par_pos` longtext COLLATE utf8_unicode_ci,
  `digitalise_total` int(11) DEFAULT NULL,
  `digitalise_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_gov` longtext COLLATE utf8_unicode_ci,
  `pos_status_par_pos` longtext COLLATE utf8_unicode_ci,
  `pos_enables_par_pos` longtext COLLATE utf8_unicode_ci,
  `offline_total` int(11) DEFAULT NULL,
  `offline_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_sous_campagne` int(11) DEFAULT NULL,
  `bonus_dsa_compagne` double DEFAULT NULL,
  `vente_dsa_marque` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_marque_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_dsa_total` int(11) DEFAULT NULL,
  `stock_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `date_idx` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `stat_week`
--

CREATE TABLE IF NOT EXISTS `stat_week` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `vente_total` int(11) DEFAULT NULL,
  `stock_total` int(11) DEFAULT NULL,
  `vente_sous_campagne` int(11) DEFAULT NULL,
  `bonus_compagne` double DEFAULT NULL,
  `vente_sous_campagne_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_compagne_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_marque` longtext COLLATE utf8_unicode_ci,
  `vente_marque_pos` longtext COLLATE utf8_unicode_ci,
  `sucess_total` int(11) DEFAULT NULL,
  `sucess_par_pos` longtext COLLATE utf8_unicode_ci,
  `erreurs_total` int(11) DEFAULT NULL,
  `erreurs_par_pos` longtext COLLATE utf8_unicode_ci,
  `cutoff_total` int(11) DEFAULT NULL,
  `pos_actif_total` int(11) DEFAULT NULL,
  `pos_inactif_total` int(11) DEFAULT NULL,
  `pos_actives_total` int(11) DEFAULT NULL,
  `pos_desactives_total` int(11) DEFAULT NULL,
  `ussd_total` int(11) DEFAULT NULL,
  `ussd_par_pos` longtext COLLATE utf8_unicode_ci,
  `sms_total` int(11) DEFAULT NULL,
  `sms_par_pos` longtext COLLATE utf8_unicode_ci,
  `web_total` int(11) DEFAULT NULL,
  `web_par_pos` longtext COLLATE utf8_unicode_ci,
  `mobile_total` int(11) DEFAULT NULL,
  `mobile_par_pos` longtext COLLATE utf8_unicode_ci,
  `digitalise_total` int(11) DEFAULT NULL,
  `digitalise_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_par_gov` longtext COLLATE utf8_unicode_ci,
  `pos_status_par_pos` longtext COLLATE utf8_unicode_ci,
  `pos_enables_par_pos` longtext COLLATE utf8_unicode_ci,
  `offline_total` int(11) DEFAULT NULL,
  `offline_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_sous_campagne` int(11) DEFAULT NULL,
  `bonus_dsa_compagne` double DEFAULT NULL,
  `vente_dsa_marque` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `bonus_dsa_compagne_par_pos` longtext COLLATE utf8_unicode_ci,
  `vente_dsa_marque_par_pos` longtext COLLATE utf8_unicode_ci,
  `stock_dsa_total` int(11) DEFAULT NULL,
  `stock_dsa_par_pos` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `date_idx` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `town`
--

CREATE TABLE IF NOT EXISTS `town` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gouvernorat_id` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code_postal` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4CE6C7A475B74E2D` (`gouvernorat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `tracking_sms`
--

CREATE TABLE IF NOT EXISTS `tracking_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `sender` int(11) NOT NULL,
  `sms` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `response` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `SENDER` (`sender`),
  KEY `DATE` (`date`),
  KEY `USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `transact_ema`
--

CREATE TABLE IF NOT EXISTS `transact_ema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `type_group`
--

CREATE TABLE IF NOT EXISTS `type_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prefix` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notification` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_63CCC33277153098` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Structure de la table `type_point_vente`
--

CREATE TABLE IF NOT EXISTS `type_point_vente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `activation_cna`
--
ALTER TABLE `activation_cna`
  ADD CONSTRAINT `FK_3E6A4C93255FA5E4` FOREIGN KEY (`activated_by`) REFERENCES `fos_user` (`id`),
  ADD CONSTRAINT `FK_3E6A4C9329EB7ACA` FOREIGN KEY (`distributeur_id`) REFERENCES `fos_user` (`id`),
  ADD CONSTRAINT `FK_3E6A4C93E5B80C40` FOREIGN KEY (`msisdn_history_id`) REFERENCES `msisdn_history` (`id`);

--
-- Contraintes pour la table `administratorcontact_report`
--
ALTER TABLE `administratorcontact_report`
  ADD CONSTRAINT `FK_A20923CF4BD2A4C0` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_A20923CFD6A72D6` FOREIGN KEY (`administratorcontact_id`) REFERENCES `administrator_contact` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `anomalie_contradictorys`
--
ALTER TABLE `anomalie_contradictorys`
  ADD CONSTRAINT `FK_398FD6BA1586215E` FOREIGN KEY (`contradictory_with_me_id`) REFERENCES `anomalie` (`id`),
  ADD CONSTRAINT `FK_398FD6BAC4BD76C9` FOREIGN KEY (`contradictorys_id`) REFERENCES `anomalie` (`id`);

--
-- Contraintes pour la table `campagne`
--
ALTER TABLE `campagne`
  ADD CONSTRAINT `FK_539B5D167E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `fos_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `campagne_user`
--
ALTER TABLE `campagne_user`
  ADD CONSTRAINT `FK_66A14A8916227374` FOREIGN KEY (`campagne_id`) REFERENCES `campagne` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_66A14A89A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `fos_group`
--
ALTER TABLE `fos_group`
  ADD CONSTRAINT `FK_4B019DDBC54C8C93` FOREIGN KEY (`type_id`) REFERENCES `type_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `fos_user`
--
ALTER TABLE `fos_user`
  ADD CONSTRAINT `FK_957A647946781D86` FOREIGN KEY (`userDistributorBO_id`) REFERENCES `fos_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_957A647953FCFE54` FOREIGN KEY (`code_bo`) REFERENCES `fos_user` (`id`),
  ADD CONSTRAINT `FK_957A647956CBBCF5` FOREIGN KEY (`delegation_id`) REFERENCES `delegation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_957A647975B74E2D` FOREIGN KEY (`gouvernorat_id`) REFERENCES `gouvernorat` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_957A6479A13CAFFE` FOREIGN KEY (`userDistributor_id`) REFERENCES `fos_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_957A6479B2B59251` FOREIGN KEY (`code_postal_id`) REFERENCES `localite` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_957A6479D526A7D3` FOREIGN KEY (`parent_user_id`) REFERENCES `fos_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `fos_user_user_group`
--
ALTER TABLE `fos_user_user_group`
  ADD CONSTRAINT `FK_B3C77447A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_B3C77447FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `info_bscs`
--
ALTER TABLE `info_bscs`
  ADD CONSTRAINT `FK_386BFCF12576E0FD` FOREIGN KEY (`contract_id`) REFERENCES `digital_contract` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_386BFCF175B74E2D` FOREIGN KEY (`gouvernorat_id`) REFERENCES `gouvernorat` (`id`),
  ADD CONSTRAINT `FK_386BFCF175E23604` FOREIGN KEY (`town_id`) REFERENCES `town` (`id`),
  ADD CONSTRAINT `FK_386BFCF1924DD2B5` FOREIGN KEY (`localite_id`) REFERENCES `localite` (`id`);

--
-- Contraintes pour la table `report_group_gouvernorat`
--
ALTER TABLE `report_group_gouvernorat`
  ADD CONSTRAINT `IDX_957A6579D726A7D8` FOREIGN KEY (`report_group_id`) REFERENCES `report_group` (`id`),
  ADD CONSTRAINT `IDX_957A6579D726A7D9` FOREIGN KEY (`gouvernorat_id`) REFERENCES `gouvernorat` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
