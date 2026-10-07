-- ============================================================
-- BI_Pharmacie - Public Database Schema
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
--
--
-- --------------------------------------------------------
--
-- Table structure for table `compte`
--
CREATE TABLE IF NOT EXISTS `compte` (
  `id_compte` int(11) NOT NULL AUTO_INCREMENT,
  `actif` int(11) NOT NULL DEFAULT '1',
  `profil` varchar(2) NOT NULL DEFAULT 'GD',
  `acces_externe` int(11) NOT NULL DEFAULT '0',
  `token` varchar(30) DEFAULT NULL,
  `signature` varchar(25) NOT NULL,
  `date_expiration_mdp` date DEFAULT NULL,
  PRIMARY KEY (`id_compte`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;
--
-- Dumping data for table `compte`
--
-- --------------------------------------------------------
--
-- Table structure for table `demande`
--
CREATE TABLE IF NOT EXISTS `demande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(25) NOT NULL DEFAULT '',
  `id_organisme` int(11) NOT NULL,
  `date_demande` date DEFAULT NULL,
  `heure_demande` time NOT NULL,
  `date_saisie` date NOT NULL,
  `date_sortie` date DEFAULT NULL,
  `complement` text NOT NULL,
  `id_patient` int(11) NOT NULL,
  `e_o` tinyint(1) NOT NULL,
  `etat` int(11) NOT NULL DEFAULT '0',
  `payeur` int(11) NOT NULL,
  `cree_par` int(11) NOT NULL,
  `id_medecin` int(11) NOT NULL,
  `etat_suivi` int(11) NOT NULL,
  `num_prise_en_charge` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `id_patient` (`id_patient`),
  KEY `id_patient_2` (`id_patient`),
  KEY `id_patient_3` (`id_patient`),
  KEY `id_patient_4` (`id_patient`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=133688 ;
--
-- Dumping data for table `demande`
--
-- --------------------------------------------------------
--
-- Table structure for table `demande_examen`
--
CREATE TABLE IF NOT EXISTS `demande_examen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_demande` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL,
  `prix` float NOT NULL,
  `detail` varchar(20) NOT NULL,
  `id_compte` int(11) NOT NULL,
  `date` date NOT NULL,
  `heure` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_demande` (`id_demande`),
  KEY `id_examen` (`id_examen`),
  KEY `id_demande_2` (`id_demande`),
  KEY `id_examen_2` (`id_examen`),
  KEY `id_demande_3` (`id_demande`),
  KEY `id_examen_3` (`id_examen`),
  KEY `id_demande_4` (`id_demande`),
  KEY `id_examen_4` (`id_examen`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=163120 ;
--
-- Dumping data for table `demande_examen`
--
-- --------------------------------------------------------
--
-- Table structure for table `examen`
--
CREATE TABLE IF NOT EXISTS `examen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `designation` varchar(45) NOT NULL,
  `prix` float NOT NULL,
  `delai` int(11) NOT NULL,
  `etat` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `code_2` (`code`),
  KEY `code_3` (`code`),
  KEY `code_4` (`code`),
  KEY `code_5` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=862 ;
--
-- Dumping data for table `examen`
--
-- --------------------------------------------------------
--
-- Table structure for table `facture`
--
CREATE TABLE IF NOT EXISTS `facture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_calcule` float DEFAULT NULL,
  `remise` float(10,0) DEFAULT NULL,
  `tar` float DEFAULT NULL,
  `total_a_payer` float DEFAULT NULL,
  `id_demande` int(11) NOT NULL,
  `etat` int(4) NOT NULL,
  `date` date NOT NULL,
  `raison_remise` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_demande_5` (`id_demande`),
  KEY `id_demande` (`id_demande`),
  KEY `id_demande_2` (`id_demande`),
  KEY `id_demande_3` (`id_demande`),
  KEY `id_demande_4` (`id_demande`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=133554 ;
--
-- Dumping data for table `facture`
--
-- --------------------------------------------------------
--
-- Table structure for table `medecin`
--
CREATE TABLE IF NOT EXISTS `medecin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `specialite` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3260 ;
--
-- Dumping data for table `medecin`
--
-- --------------------------------------------------------
--
-- Table structure for table `mode_paiement`
--
CREATE TABLE IF NOT EXISTS `mode_paiement` (
  `id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `libelle` varchar(20) NOT NULL,
  `libelle_reduit` varchar(5) NOT NULL,
  `actif` int(11) NOT NULL,
  `ordre_page_accueil` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `mode_paiement`
--
-- --------------------------------------------------------
--
-- Table structure for table `organisme`
--
CREATE TABLE IF NOT EXISTS `organisme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `specialite` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `favoris` int(11) NOT NULL,
  `id_compte` int(11) NOT NULL,
  `id_facture_template` int(11) NOT NULL,
  `ice` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1834 ;
--
-- Dumping data for table `organisme`
--
-- --------------------------------------------------------
--
-- Table structure for table `patient`
--
CREATE TABLE IF NOT EXISTS `patient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `sexe` varchar(1) NOT NULL,
  `date` date NOT NULL,
  `assure` int(1) NOT NULL COMMENT '0 : non, 1: autre, 2: cnops, 3:cnss, 4:far',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `code_2` (`code`),
  KEY `code_3` (`code`),
  KEY `code_4` (`code`),
  KEY `code_5` (`code`),
  KEY `code_6` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=110641 ;
--
-- Dumping data for table `patient`
--
-- --------------------------------------------------------
--
-- Table structure for table `reglement`
--
CREATE TABLE IF NOT EXISTS `reglement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `date_saisie` date NOT NULL,
  `montant` float DEFAULT NULL,
  `mode_paiement` varchar(50) NOT NULL,
  `reference` varchar(24) DEFAULT NULL,
  `id_facture` int(11) NOT NULL DEFAULT '0',
  `effectue_par` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_facture` (`id_facture`),
  KEY `id_facture_2` (`id_facture`),
  KEY `id_facture_3` (`id_facture`),
  KEY `id_facture_4` (`id_facture`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=163000 ;
--
-- Dumping data for table `reglement`
--
-- --------------------------------------------------------
--
-- Table structure for table `type_organisme`
--
CREATE TABLE IF NOT EXISTS `type_organisme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(25) NOT NULL,
  `labels` varchar(30) NOT NULL,
  `informations` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;
--
-- Dumping data for table `type_organisme`
--
