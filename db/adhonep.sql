-- MySQL dump 10.13  Distrib 5.1.72, for unknown-linux-gnu (x86_64)
--
-- Host: localhost    Database: devhouse_adhonep
-- ------------------------------------------------------
-- Server version	5.1.72-cll

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agenda`
--

DROP TABLE IF EXISTS `agenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agenda` (
  `idagenda` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datahora` datetime NOT NULL,
  `novos` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `desc` text,
  `site` tinyint(1) NOT NULL DEFAULT '1',
  `idlocais` int(10) unsigned NOT NULL,
  `statuslocal` enum('vermelho','amarelo','verde') NOT NULL DEFAULT 'vermelho',
  `idpessoas` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idagenda`),
  KEY `fk_agenda_locais1` (`idlocais`),
  KEY `fk_agenda_pessoas1` (`idpessoas`),
  CONSTRAINT `fk_agenda_locais1` FOREIGN KEY (`idlocais`) REFERENCES `locais` (`idlocais`) ON UPDATE CASCADE,
  CONSTRAINT `fk_agenda_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agenda`
--

LOCK TABLES `agenda` WRITE;
/*!40000 ALTER TABLE `agenda` DISABLE KEYS */;
INSERT INTO `agenda` (`idagenda`, `datahora`, `novos`, `total`, `desc`, `site`, `idlocais`, `statuslocal`, `idpessoas`) VALUES (11,'2013-04-18 00:45:00',0,0,'',1,5,'vermelho',87);
/*!40000 ALTER TABLE `agenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agenda_encarregados`
--

DROP TABLE IF EXISTS `agenda_encarregados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agenda_encarregados` (
  `idagenda` int(10) unsigned NOT NULL,
  `idpessoas` int(10) unsigned NOT NULL,
  `tipo` tinyint(3) unsigned NOT NULL,
  `status` enum('vermelho','amarelo','verde') NOT NULL DEFAULT 'vermelho',
  PRIMARY KEY (`idagenda`,`idpessoas`,`tipo`),
  KEY `fk_agenda_encarregados_agenda1` (`idagenda`),
  KEY `fk_agenda_encarregados_pessoas1` (`idpessoas`),
  CONSTRAINT `agenda_encarregados_ibfk_1` FOREIGN KEY (`idagenda`) REFERENCES `agenda` (`idagenda`) ON UPDATE CASCADE,
  CONSTRAINT `agenda_encarregados_ibfk_2` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agenda_encarregados`
--

LOCK TABLES `agenda_encarregados` WRITE;
/*!40000 ALTER TABLE `agenda_encarregados` DISABLE KEYS */;
INSERT INTO `agenda_encarregados` (`idagenda`, `idpessoas`, `tipo`, `status`) VALUES (11,18,3,'amarelo'),(11,22,1,'vermelho'),(11,42,4,'verde'),(11,55,2,'vermelho');
/*!40000 ALTER TABLE `agenda_encarregados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajustes`
--

DROP TABLE IF EXISTS `ajustes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajustes` (
  `nome` varchar(255) NOT NULL,
  `valor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajustes`
--

LOCK TABLES `ajustes` WRITE;
/*!40000 ALTER TABLE `ajustes` DISABLE KEYS */;
INSERT INTO `ajustes` (`nome`, `valor`) VALUES ('Onde Usar Idéias','Opção 1;Opção 2; Opção 34; Opção 4'),('Teste de Opção','sim');
/*!40000 ALTER TABLE `ajustes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atributospessoais`
--

DROP TABLE IF EXISTS `atributospessoais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atributospessoais` (
  `idatributospessoais` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `atributo` varchar(255) CHARACTER SET latin1 NOT NULL,
  `aplicacao` tinyint(4) NOT NULL,
  PRIMARY KEY (`idatributospessoais`),
  KEY `atributo` (`atributo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atributospessoais`
--

LOCK TABLES `atributospessoais` WRITE;
/*!40000 ALTER TABLE `atributospessoais` DISABLE KEYS */;
INSERT INTO `atributospessoais` (`idatributospessoais`, `atributo`, `aplicacao`) VALUES (1,'Líder',3),(2,'Preletor',1),(3,'Comunicação',3),(4,'Mestre Cerimônia',1),(5,'Músico',1),(6,'5 Minutos',1),(7,'Tesoureiro',2),(8,'Vice',2);
/*!40000 ALTER TABLE `atributospessoais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidades`
--

DROP TABLE IF EXISTS `cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidades` (
  `idcidades` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cidade` varchar(100) CHARACTER SET latin1 NOT NULL,
  `capitulo` varchar(50) DEFAULT NULL,
  `imagem` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `desc` text CHARACTER SET latin1,
  PRIMARY KEY (`idcidades`),
  UNIQUE KEY `cidade` (`cidade`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Cidades do sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidades`
--

LOCK TABLES `cidades` WRITE;
/*!40000 ALTER TABLE `cidades` DISABLE KEYS */;
INSERT INTO `cidades` (`idcidades`, `cidade`, `capitulo`, `imagem`, `desc`) VALUES (1,'Joinville',NULL,NULL,'Cidade de Joinville'),(2,'Blumenau',NULL,'adho.gif','fdsa fdsa fdsa fdsa<br>'),(3,'Itajaí',NULL,'00_evento27-09.gif','?hjyfdjkfgkjfkgf'),(4,'Brusque','','07_evento27-09.jpg','fdsa fdas fdsa fdsa f<br>'),(5,'Florianópolis',NULL,'10.jpg','?fd safdjh djdf<br>'),(6,'São Paulo',NULL,'07--Apoio-Jovem-26.04_.2008_.jpg','saf das fdas fdas fdas<br>'),(7,'Lages',NULL,'camila_rodrigues.jpg','?Cidade de Lages'),(9,'Curitiba',NULL,NULL,''),(10,'Jaraguá',NULL,'community_users.png','fdsaf dsa fdsa fdsa fdsa <br>'),(11,'Caraticuiba',NULL,'close.png','fdsafdsafdsa'),(12,'Nova Iorque',NULL,'application_view_list.png','&nbsp;yrjgfs hfd agfagh fdag fagfa<br>'),(14,'Smallville','1321',NULL,'f dsa fdasg sag dsaf dsa fdsaf dsa fdsa<br>'),(15,'São Tomé das Letras','1321',NULL,'f dsa fdasg sag dsaf dsa fdsaf dsa fdsa<br>');
/*!40000 ALTER TABLE `cidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidades_atributospessoais_pessoas`
--

DROP TABLE IF EXISTS `cidades_atributospessoais_pessoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidades_atributospessoais_pessoas` (
  `idcidades` int(10) unsigned NOT NULL,
  `idatributospessoais` int(10) unsigned NOT NULL,
  `idpessoas` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idcidades`,`idatributospessoais`,`idpessoas`),
  KEY `fk_cidades_has_atributospessoais_cidades1` (`idcidades`),
  KEY `fk_cidades_has_atributospessoais_atributospessoais1` (`idatributospessoais`),
  KEY `fk_cidades_has_atributospessoais_pessoas1` (`idpessoas`),
  CONSTRAINT `fk_cidades_has_atributospessoais_atributospessoais1` FOREIGN KEY (`idatributospessoais`) REFERENCES `atributospessoais` (`idatributospessoais`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cidades_has_atributospessoais_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cidades_has_atributospessoais_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidades_atributospessoais_pessoas`
--

LOCK TABLES `cidades_atributospessoais_pessoas` WRITE;
/*!40000 ALTER TABLE `cidades_atributospessoais_pessoas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cidades_atributospessoais_pessoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloads`
--

DROP TABLE IF EXISTS `downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloads` (
  `iddownloads` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `arquivo` varchar(255) NOT NULL,
  `caminho` varchar(255) NOT NULL,
  `uploader` int(10) unsigned NOT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `qtddownloads` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`iddownloads`),
  KEY `fk_downloads_pessoas1` (`uploader`),
  CONSTRAINT `fk_downloads_pessoas1` FOREIGN KEY (`uploader`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloads`
--

LOCK TABLES `downloads` WRITE;
/*!40000 ALTER TABLE `downloads` DISABLE KEYS */;
INSERT INTO `downloads` (`iddownloads`, `arquivo`, `caminho`, `uploader`, `autor`, `qtddownloads`) VALUES (20,'Foto','icon_smile.gif',87,'Leo',0),(21,'Modem','155707_488851501170327_1133609371_n.jpg',87,'Leonardo',1),(23,'Getting Started','Getting_Started.pdf',87,'Leonardo',4),(24,'Site Antigo','IMG_17042013_213436.png',87,'Leonardo',1);
/*!40000 ALTER TABLE `downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ideias`
--

DROP TABLE IF EXISTS `ideias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ideias` (
  `idideias` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ideia` varchar(255) NOT NULL,
  `ondeusar` varchar(255) NOT NULL,
  `autor` varchar(255) DEFAULT NULL,
  `desc` text,
  PRIMARY KEY (`idideias`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ideias`
--

LOCK TABLES `ideias` WRITE;
/*!40000 ALTER TABLE `ideias` DISABLE KEYS */;
INSERT INTO `ideias` (`idideias`, `ideia`, `ondeusar`, `autor`, `desc`) VALUES (2,'Usar mais o sistema Adhonep','Opção 2','Leonardoaaaaa','f dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asf dsalfkd ajfdl asaaaa'),(6,'Teste de idéia',' Opção 3','Autora','Teste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaTeste de idéiaaaaaaaa'),(24,'Super Ideia','Opção 1','aaaaa','fdsafda fda fds<br>'),(25,'Contratar a DevHouse',' Opção 34','Leonardo','Que tal contratar a DevHouse para desenvolver seu sistema?<br>');
/*!40000 ALTER TABLE `ideias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locais`
--

DROP TABLE IF EXISTS `locais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locais` (
  `idlocais` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `local` varchar(255) CHARACTER SET latin1 NOT NULL,
  `endereco` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `bairro` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `telefone` varchar(16) CHARACTER SET latin1 DEFAULT NULL,
  `desc` text CHARACTER SET latin1,
  `idpessoas` int(10) unsigned NOT NULL,
  `idcidades` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idlocais`),
  KEY `fk_locais_pessoas1` (`idpessoas`),
  KEY `fk_locais_cidades1` (`idcidades`),
  CONSTRAINT `fk_locais_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
  CONSTRAINT `fk_locais_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locais`
--

LOCK TABLES `locais` WRITE;
/*!40000 ALTER TABLE `locais` DISABLE KEYS */;
INSERT INTO `locais` (`idlocais`, `local`, `endereco`, `bairro`, `telefone`, `desc`, `idpessoas`, `idcidades`) VALUES (1,'Casa do Leonardo','Rua Sem Nome, sn','Centro','4730243438','A minha casa<br>',15,1),(2,'Igreja Santos Anjos','Rua da igreja, 45','Marinha','4734372322','Igreja revestida em ouro.',33,4),(4,'Igreja Bola de Neve','Rua Felipe Schimit','Centro','4832236578','A igreja da mocidade.',42,5),(5,'Auditório Municipal','Rua Central, 123','Centro','(47) 3026-6454','Auditório Espaçoso',13,6),(6,'Casa Nova','Rua Sem Nome, sn','Bom Retiro','(47) 5454-5454','Teste xxx<br>',11,1);
/*!40000 ALTER TABLE `locais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissoes`
--

DROP TABLE IF EXISTS `permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissoes` (
  `idpermissoes` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permissao` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`idpermissoes`),
  KEY `permissao` (`permissao`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissoes`
--

LOCK TABLES `permissoes` WRITE;
/*!40000 ALTER TABLE `permissoes` DISABLE KEYS */;
INSERT INTO `permissoes` (`idpermissoes`, `permissao`) VALUES (8,'administrador'),(1,'agenda'),(2,'cidades'),(3,'downloads'),(4,'locais'),(5,'pessoas'),(6,'usuarios'),(7,'usuários somente na sua cidade');
/*!40000 ALTER TABLE `permissoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoas`
--

DROP TABLE IF EXISTS `pessoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoas` (
  `idpessoas` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) CHARACTER SET latin1 NOT NULL,
  `email` varchar(255) CHARACTER SET latin1 NOT NULL,
  `senha` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `telefone` varchar(16) CHARACTER SET latin1 DEFAULT NULL,
  `celular` varchar(16) CHARACTER SET latin1 DEFAULT NULL,
  `endereco` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `bairro` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `idcidades` int(10) unsigned NOT NULL,
  `desc` text CHARACTER SET latin1,
  `acesso` tinyint(1) NOT NULL,
  PRIMARY KEY (`idpessoas`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_pessoas_cidades1` (`idcidades`),
  KEY `nome` (`nome`),
  CONSTRAINT `fk_pessoas_cidades1` FOREIGN KEY (`idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='Pessoas e Usuários do sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoas`
--

LOCK TABLES `pessoas` WRITE;
/*!40000 ALTER TABLE `pessoas` DISABLE KEYS */;
INSERT INTO `pessoas` (`idpessoas`, `nome`, `email`, `senha`, `telefone`, `celular`, `endereco`, `bairro`, `idcidades`, `desc`, `acesso`) VALUES (7,'João da Silva','joao@dasilva.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','4732184329','3243242','Rua sem nome,sn','bairro',1,'',0),(8,'Nome','email@email.com','7c4a8d09ca3762af61e59520943dc26494f8941b','46454645','456456465','Rua Sem Nome, sn','Bairro',1,'fdsafdsafdsa',0),(9,'Janjão','janjao@email.com','7751a23fa55170a57e90374df13a3ab78efe0e99','78908','989987987','rua tal, numero tal','Bairro',1,'',1),(11,'Davi Golias','fdsajl@fjdaaaaa.com','7751a23fa55170a57e90374df13a3ab78efe0e99','57328473','987459387','fjdsaklfjd123','Bairro',2,'',1),(12,'Grand Master Flash','grand@masterflash.com','1bdc12f0f29da10f6b637646821c0c56e8c48559','0987097','98798798','fdsaçl fdjskla flkdsaj flksd','fdjsaklfjdsl',1,'',1),(13,'Anacleto Brocolli','anacleto@brocoli.com','cd3f0c85b158c08a2b113464991810cf2cdfc387','5432342','987978975','fhdsak fhdsa fj','fd salkfjds al',1,'<br>',1),(15,'Edimilson Creison','edmilson@creison.com','7c4a8d09ca3762af61e59520943dc26494f8941b','5432542','987987','fdsafdsafdsa, sn','fdsafdsa',1,'',1),(16,'Juliano Barbosa','juliano@barbosa.com','7c4a8d09ca3762af61e59520943dc26494f8941b','98798','98798789','fdsafdsa','fdsafdsa',1,'',1),(17,'Julian Moore','julian@moore.com','7c4a8d09ca3762af61e59520943dc26494f8941b','456456','654654','fjad slakfj dsaçlkfj dsalf jdslaj','Bairro',1,'',1),(18,'Amina Munsta','amina@munsta.com','7c4a8d09ca3762af61e59520943dc26494f8941b','09809808','9674987','ds flakfj dlksafj dlksa fldksa jflkdsaj lfd jalkf dlksa djflka jfldaj flkdsa jflkd jsaklf jdaskl fjdklsa fjdlksafdsa fdsa fdsa fdsa fdsa fdas fdsa  fdsa fdsa fdsa fdsa fdsaf dsa fdsa fdsaf dsa fdsaf dsaf  dsaf dsa fdsa ','Bairro',7,'fdsafdsafdsafdsafds',1),(19,'Anastacia Velasco','ana@velasco.com','7c4a8d09ca3762af61e59520943dc26494f8941b','777777777','98798498489','fdsafdsa fdsa fdsa fdsa fdsa','f dsa fdsa fdas fdas dsa',1,'dsa <a href=\"http://www.google.com\">fdsaf </a>dsa <b>fdsa </b>fdsa <span style=\"background-color: rgb(255, 255, 0);\">fdsa </span>fdsa <a href=\"http://www.google.com\">fdsa </a>fd <font color=\"#99cc00\">asf </font>dasf dsa dsa d<br>',1),(20,'Ludimila Kadinski','lulu@kaka.com','7c4a8d09ca3762af61e59520943dc26494f8941b','43214321','43214322','fdsafdsafdsafdsa','fdsafdsafdsa',1,'fdsa <a href=\"http://www.google.com/\">fdsaf </a>dsa <b>fdsa </b>fdsa <span style=\"background-color: rgb(255, 255, 0);\">fdsa </span>fdsa fdsa fd <font color=\"#99cc00\">asf </font>dasf dsa dsa d',0),(21,'Ratazana','rat@azana.com.br','7e240de74fb1ed08fa08d38063f6a6a91462a815','432432432','432432','fdsafdsafdsafdsafdsafdsa','fdsafdsa',1,'dsafdsaf<font color=\"#ff6600\">dsafdsa</font>fdsa',1),(22,'Alan Correa','fear@tdv.com','7c4a8d09ca3762af61e59520943dc26494f8941b','123456','98797987','endereço 124','América',6,'<img src=\"images/ajax-loader.gif\" vspace=\"6\" align=\"Esquerda\" hspace=\"6\"><br><br><b>All </b><font color=\"#ff6600\">the </font><i>fear </i>I <font color=\"#ff0000\">have </font>is <font color=\"#339966\">only </font><a href=\"http://www.tdv.com\">inside </a><span  rgb(255, 102, 0);\">my </span><font color=\"#00ffff\">mind</font><br>',1),(33,'Fausta','sadfds@fjdls.com','7c4a8d09ca3762af61e59520943dc26494f8941b','5465465','654564','fdsafdsafdsa','fdsafdsafd',1,'ffff',1),(42,'Bruna Bitencourt','bruna@bit.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','4325432432','432432432','fdsafdsafdsaf','fdsafdsa',1,'yterytreuytreytre',1),(43,'HP Lovecraft','hp@lovecraft.com','7c4a8d09ca3762af61e59520943dc26494f8941b','564654','456465465','fdsafdsafdsafdsafdsa123','fdsafdsafdsa',1,'aaaaaaaaaaaaaaaaa',1),(45,'Camila Rodrigues','camila@rodrigues.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','4730335589','4799748553','Rua João Colin, 2345','América',1,'<img src=\"images/imagens/camila_rodrigues.jpg\" align=\"left\" hspace=\"6\" vspace=\"6\">?Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse facilisis ligula sed ligula luctus congue. Fusce venenatis, lorem vitae porttitor lobortis, ipsum nunc facilisis ipsum, ac feugiat orci purus id velit. Maecenas vel lorem non magna eleifend varius et vel dui. Maecenas ut quam velit, ut gravida dolor. Aenean at enim risus, non feugiat ipsum. Nunc bibendum convallis tellus, porttitor dignissim leo fringilla ac. Curabitur congue enim ut quam placerat in interdum massa vestibulum. Duis sollicitudin elit et magna molestie vitae gravida est consequat. Quisque placerat, ante sit amet posuere suscipit, nibh magna posuere libero, rutrum consectetur elit nulla vitae nisl. Sed interdum laoreet justo vestibulum malesuada. Donec mattis volutpat mattis.<div><br></div><div>Etiam vitae sollicitudin lorem. Ut rhoncus purus eu ipsum bibendum tempor. Vestibulum scelerisque laoreet luctus. Aenean vehicula porttitor enim, eu bibendum diam blandit et. Proin sem libero, dapibus sit amet suscipit non, commodo eget nisl. Vivamus vitae arcu nisl, euismod egestas neque. In sed iaculis nulla. Quisque porttitor erat et ligula rutrum mollis pretium mi scelerisque. Mauris ornare porttitor volutpat. Donec eget quam mauris, eu aliquet massa. In dictum auctor dolor, a aliquam arcu mattis sit amet. Morbi et augue non turpis blandit convallis. Praesent at augue sapien, eu gravida leo. Morbi fringilla rutrum cursus. Etiam vitae ante et odio adipiscing convallis eu at lectus. Aenean auctor tortor ut urna egestas a tincidunt nisi commodo. Sed sed diam at orci elementum adipiscing.</div><div><br></div><div>Proin ut felis ut nisl sodales porta. Donec in eros vel nisi aliquet egestas gravida aliquet massa. Suspendisse facilisis viverra purus, vitae malesuada tortor vestibulum nec. Suspendisse quis tincidunt leo. Aliquam cursus commodo neque non suscipit. In molestie sagittis risus, sed euismod arcu lobortis quis. Integer et velit et ante semper scelerisque sed at tellus. Phasellus ornare dictum odio, at feugiat turpis venenatis id. Cras sed felis nunc. Etiam magna leo, ullamcorper quis ultricies eu, ultrices ut nisl. In hac habitasse platea dictumst. Vivamus ultrices, orci et ultricies tincidunt, mauris magna egestas leo, eu molestie purus metus id nibh. Nulla id ultricies magna. Duis tincidunt, dui vestibulum sagittis tempus, lorem felis suscipit sapien, ut porttitor dui urna non nibh.</div><div><br></div><div>Integer a turpis lorem. Pellentesque ac ullamcorper neque. Sed in turpis a dolor imperdiet egestas. Integer porttitor pulvinar lacinia. Sed nibh turpis, fermentum a venenatis ac, aliquet eu nisi. Nam arcu lectus, dignissim vel scelerisque non, facilisis non arcu. Vestibulum quis nibh dui. Nunc non nunc sed odio tincidunt hendrerit sollicitudin sit amet sem. Nunc congue pulvinar hendrerit. Vestibulum ut felis sapien, quis tincidunt erat. Nullam interdum purus ut eros consequat dignissim. Duis vehicula vestibulum tortor, et porttitor odio elementum at. Praesent vel tortor non orci lacinia pellentesque ac vitae massa. Proin eget facilisis risus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum egestas, eros ac tincidunt pretium, leo dui pellentesque nisl, non hendrerit libero odio ac eros. Nam posuere, urna non cursus vulputate, eros eros luctus ligula, nec congue tortor orci at felis.</div><div><br></div><div>Aliquam nunc dolor, congue et commodo non, laoreet sit amet orci. Donec euismod lobortis dictum. Sed malesuada fringilla sem, a facilisis justo scelerisque et. Vivamus rutrum lectus et dui hendrerit facilisis. Vestibulum enim massa, fermentum et luctus sed, suscipit a felis. Sed aliquet volutpat pharetra. Aliquam rutrum, lectus at varius rutrum, ante leo sollicitudin magna, sit amet dapibus orci erat vel quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean id dignissim velit. Maecenas tristique nisi erat. Nunc dapibus aliquam nulla, at placerat leo auctor vel. Quisque feugiat urna quis libero facilisis volutpat.&nbsp;</div>',1),(46,'Oswaldo Marques','oswaldo@marques.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','(41) 2323-5465','(41) 9955-2322','Rua sem nome,sn','Batel',9,'fdsafdsadsafsa',1),(53,'Monica','m@monica.com','7c4a8d09ca3762af61e59520943dc26494f8941b','(43) 2451-3243','(31) 2432-1431','fdsa fdsa fdsaf dsa fdsa',' fdsa fdsa fdsa',2,'f dsafdsa fdsa fdsa fdas fdsa fdsa <br>',1),(54,'Robert Langdon','robert@langdon.com','7c4a8d09ca3762af61e59520943dc26494f8941b','(45) 6456-4564','(45) 6456-4654','fdsafdsafdsa','fdsafdsa',7,'f dsafd <font color=\"#ff0000\">safdsa </font>fdsa <span style=\"background-color: rgb(153, 204, 0);\">fdsa </span>fdsa <b>fdsaf </b>dsa<br>',1),(55,'Altamiro Lima','altamiro@lima.com','7c4a8d09ca3762af61e59520943dc26494f8941b','(45) 6464-5646','(64) 6546-5446','fdsaf dsa dfsa fdsa fdsa','fdsafdsa',7,'<b>fdsa </b>fdsa <font color=\"#ff0000\">fdsaf </font>dsa fdsa <span style=\"background-color: rgb(255, 255, 0);\">fdsa </span>fsa<br>',0),(56,'Jhon Lenon','john@beatles.com','7c4a8d09ca3762af61e59520943dc26494f8941b','(56) 4654-6465','(46) 4654-6546','fdsafdsafdsa','fdsafdsafdsa',4,'fdsaf dsa fdsa fdsa fdsa<br>',1),(57,'Ronaldinho','ronaldo@selecao.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','(45) 4645-6465','(56) 4646-5464','fdsafdsafdsa','fdsafdsa',5,'fdsafdsa fdsa fdsa fdsa fdsa fdsa fdsa<br>',1),(63,'Jason Newsted','jason@metallica.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','(45) 6456-4654','(78) 9789-7949','Rua sem nome, sn','Costa e Silva',1,'fdsaf <font color=\"#ff0000\">das </font>fdas fdsaf <b>dsa </b>fdas fdsafdsa<br>',0),(65,'João Batista','joao@batista.com.br','7c4a8d09ca3762af61e59520943dc26494f8941b','(46) 5464-6464','(46) 5465-4646','Rua tal, 45','Centro',1,'Rfjadslkf jdalkf dlksa jflkdsa jflkdsaj<br>',1),(86,'Valdiram Cassimiro','valdiramcrs@gmail.com','e10adc3949ba59abbe56e057f20f883e','(54) 5668-8165','(54) 9999-9879','Rua Sem Nome, sn','Centro',1,'<div><p>Bacon ipsum dolor sit amet strip steak kielbasa corned beef \nshoulder leberkas ground round short loin tri-tip.  Leberkas pastrami \nswine, sausage pork belly kielbasa biltong frankfurter tongue brisket \npork ham beef.  Cow t-bone shoulder, corned beef swine ribeye fatback \nbacon brisket tongue turducken pastrami leberkas salami capicola.  \nProsciutto filet mignon andouille, pancetta kielbasa beef ribs shank \nshort loin ribeye sirloin hamburger strip steak capicola tenderloin \nbacon.  Shank sirloin frankfurter bacon prosciutto.  Tail biltong boudin\n shank turkey.  Swine pork belly corned beef beef boudin short loin \nmeatloaf, pig sirloin bacon chuck biltong fatback.</p><p>Turkey pork \nchop pork loin shoulder kielbasa hamburger, spare ribs andouille \nmeatball turducken meatloaf prosciutto frankfurter.  Pork tongue chuck \nshort loin.  Jowl andouille chuck shank short loin ham hock turducken \npork belly hamburger tri-tip rump capicola ham pork chop.  Jerky pork \nleberkas short loin beef ribs.  Jerky brisket capicola biltong shankle \nkielbasa.</p><p>Short loin pork loin pork chop, tenderloin ball tip \nturkey leberkas cow t-bone drumstick shank.  Meatloaf ribeye t-bone pork\n leberkas fatback.  Salami venison hamburger meatloaf sausage andouille,\n bresaola rump swine pork loin strip steak turducken tenderloin chuck.  \nTail sausage shoulder meatball.  Turducken sausage chuck fatback, \nkielbasa t-bone doner shank beef ground round cow ham.</p><p>Biltong \ncapicola jowl venison short loin, strip steak cow kielbasa jerky filet \nmignon pig.  Capicola kielbasa swine turducken pastrami venison, salami \nchicken drumstick cow.  Shankle turducken ham short loin.  Chicken \ncapicola fatback sirloin flank ball tip hamburger pork belly prosciutto \npastrami shoulder corned beef t-bone swine pork loin.</p><p>Meatloaf \nhamburger strip steak spare ribs brisket short loin, bresaola t-bone \nkielbasa ham hock drumstick pig.  Jowl meatloaf flank, corned beef \nbrisket short loin filet mignon.  Beef ribs ham salami frankfurter \nleberkas, tongue shank fatback rump bresaola t-bone bacon shankle strip \nsteak.  T-bone meatloaf biltong spare ribs fatback.  Turducken fatback \nkielbasa, spare ribs drumstick filet mignon hamburger jowl.</p></div>',1),(87,'Visitante','contato@devhouse.com.br','e10adc3949ba59abbe56e057f20f883e','(32) 3233-2432','(98) 7987-8979','Rua Sem Nome, sn','Centro',1,'<div><p>Bacon ipsum dolor sit amet strip steak kielbasa corned beef \nshoulder leberkas ground round short loin tri-tip.  Leberkas pastrami \nswine, sausage pork belly kielbasa biltong frankfurter tongue brisket \npork ham beef.  Cow t-bone shoulder, corned beef swine ribeye fatback \nbacon brisket tongue turducken pastrami leberkas salami capicola.  \nProsciutto filet mignon andouille, pancetta kielbasa beef ribs shank \nshort loin ribeye sirloin hamburger strip steak capicola tenderloin \nbacon.  Shank sirloin frankfurter bacon prosciutto.  Tail biltong boudin\n shank turkey.  Swine pork belly corned beef beef boudin short loin \nmeatloaf, pig sirloin bacon chuck biltong fatback.</p><p>Turkey pork \nchop pork loin shoulder kielbasa hamburger, spare ribs andouille \nmeatball turducken meatloaf prosciutto frankfurter.  Pork tongue chuck \nshort loin.  Jowl andouille chuck shank short loin ham hock turducken \npork belly hamburger tri-tip rump capicola ham pork chop.  Jerky pork \nleberkas short loin beef ribs.  Jerky brisket capicola biltong shankle \nkielbasa.</p><p>Short loin pork loin pork chop, tenderloin ball tip \nturkey leberkas cow t-bone drumstick shank.  Meatloaf ribeye t-bone pork\n leberkas fatback.  Salami venison hamburger meatloaf sausage andouille,\n bresaola rump swine pork loin strip steak turducken tenderloin chuck.  \nTail sausage shoulder meatball.  Turducken sausage chuck fatback, \nkielbasa t-bone doner shank beef ground round cow ham.</p><p>Biltong \ncapicola jowl venison short loin, strip steak cow kielbasa jerky filet \nmignon pig.  Capicola kielbasa swine turducken pastrami venison, salami \nchicken drumstick cow.  Shankle turducken ham short loin.  Chicken \ncapicola fatback sirloin flank ball tip hamburger pork belly prosciutto \npastrami shoulder corned beef t-bone swine pork loin.</p><p>Meatloaf \nhamburger strip steak spare ribs brisket short loin, bresaola t-bone \nkielbasa ham hock drumstick pig.  Jowl meatloaf flank, corned beef \nbrisket short loin filet mignon.  Beef ribs ham salami frankfurter \nleberkas, tongue shank fatback rump bresaola t-bone bacon shankle strip \nsteak.  T-bone meatloaf biltong spare ribs fatback.  Turducken fatback \nkielbasa, spare ribs drumstick filet mignon hamburger jowl.</p></div>',1);
/*!40000 ALTER TABLE `pessoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoas_atributospessoais`
--

DROP TABLE IF EXISTS `pessoas_atributospessoais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoas_atributospessoais` (
  `idpessoas` int(10) unsigned NOT NULL,
  `idatributospessoais` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpessoas`,`idatributospessoais`),
  KEY `fk_pessoas_has_atributospessoais_pessoas1` (`idpessoas`),
  KEY `fk_pessoas_has_atributospessoais_atributospessoais1` (`idatributospessoais`),
  CONSTRAINT `fk_pessoas_has_atributospessoais_atributospessoais1` FOREIGN KEY (`idatributospessoais`) REFERENCES `atributospessoais` (`idatributospessoais`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pessoas_has_atributospessoais_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoas_atributospessoais`
--

LOCK TABLES `pessoas_atributospessoais` WRITE;
/*!40000 ALTER TABLE `pessoas_atributospessoais` DISABLE KEYS */;
INSERT INTO `pessoas_atributospessoais` (`idpessoas`, `idatributospessoais`) VALUES (86,1),(86,4),(86,5);
/*!40000 ALTER TABLE `pessoas_atributospessoais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoas_cidades`
--

DROP TABLE IF EXISTS `pessoas_cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoas_cidades` (
  `pessoas_idpessoas` int(10) unsigned NOT NULL,
  `cidades_idcidades` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pessoas_idpessoas`,`cidades_idcidades`),
  KEY `fk_pessoas_has_cidades_pessoas` (`pessoas_idpessoas`),
  KEY `fk_pessoas_has_cidades_cidades` (`cidades_idcidades`),
  CONSTRAINT `fk_pessoas_has_cidades_cidades` FOREIGN KEY (`cidades_idcidades`) REFERENCES `cidades` (`idcidades`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pessoas_has_cidades_pessoas` FOREIGN KEY (`pessoas_idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoas_cidades`
--

LOCK TABLES `pessoas_cidades` WRITE;
/*!40000 ALTER TABLE `pessoas_cidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `pessoas_cidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoas_permissoes`
--

DROP TABLE IF EXISTS `pessoas_permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoas_permissoes` (
  `idpessoas` int(10) unsigned NOT NULL,
  `idpermissoes` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idpessoas`,`idpermissoes`),
  KEY `fk_pessoas_has_permissoes_pessoas1` (`idpessoas`),
  KEY `fk_pessoas_has_permissoes_permissoes1` (`idpermissoes`),
  CONSTRAINT `fk_pessoas_has_permissoes_permissoes1` FOREIGN KEY (`idpermissoes`) REFERENCES `permissoes` (`idpermissoes`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pessoas_has_permissoes_pessoas1` FOREIGN KEY (`idpessoas`) REFERENCES `pessoas` (`idpessoas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoas_permissoes`
--

LOCK TABLES `pessoas_permissoes` WRITE;
/*!40000 ALTER TABLE `pessoas_permissoes` DISABLE KEYS */;
INSERT INTO `pessoas_permissoes` (`idpessoas`, `idpermissoes`) VALUES (22,1),(22,2),(22,3),(86,8),(87,8);
/*!40000 ALTER TABLE `pessoas_permissoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'devhouse_adhonep'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-01-29 18:48:31
