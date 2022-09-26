
DROP TABLE IF EXISTS `carro`;

CREATE TABLE `carro` (
  `idCarro` int NOT NULL AUTO_INCREMENT,
  `Placa` varchar(45) NOT NULL,
  `Modelo` varchar(45) NOT NULL,
  `Marca` varchar(45) NOT NULL,
  `IdCliente` int NOT NULL,
  PRIMARY KEY (`idCarro`),
  UNIQUE KEY `Placa_UNIQUE` (`Placa`),
  KEY `IdCliente_idx` (`IdCliente`),
  CONSTRAINT `IdCliente` FOREIGN KEY (`IdCliente`) REFERENCES `cliente` (`idCliente`)
); 

INSERT INTO `carro` VALUES (1,'NDJ-6798','CHEVROLET','CELTA',2),(2,'NBS-1266','FIAT','PALIO',3);

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `CPF` varchar(45) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `CPF_UNIQUE` (`CPF`)
);

INSERT INTO `cliente` VALUES (2,'Gabriele','99999999999'),(3,'Felipe','77777777777');

DROP TABLE IF EXISTS `equipe`;

CREATE TABLE `equipe` (
  `idEquipe` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`idEquipe`)
); 

INSERT INTO `equipe` VALUES (1,'TROCA DE VELAS'),(2,'REVISÃO 10.000 KM');

DROP TABLE IF EXISTS `funcionario`;

CREATE TABLE `funcionario` (
  `idFuncionario` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Endereco` varchar(45) NOT NULL,
  `Especialidade` varchar(45) NOT NULL,
  `IdEquipe` int NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  KEY `IdEquipe_idx` (`IdEquipe`),
  CONSTRAINT `IdEq` FOREIGN KEY (`IdEquipe`) REFERENCES `equipe` (`idEquipe`)
);

INSERT INTO `funcionario` VALUES (1,'AFRÂNIO','JACÓ','MECANICO',1),(2,'JOSÉ','BEDEU','MECANICO',2),(3,'AGENOR','BINGO','MECANICO',1),(4,'RUAN','GARCIA','MECANICO',2);

DROP TABLE IF EXISTS `ordem_servico`;

CREATE TABLE `ordem_servico` (
  `idOrdem_Servico` int NOT NULL AUTO_INCREMENT,
  `DataEmissao` datetime NOT NULL,
  `DataConclusao` datetime NOT NULL,
  `Status` enum('Aguardando','Aprovado','Reprovada') NOT NULL DEFAULT 'Aguardando',
  `IdCarro` int NOT NULL,
  `IdEquipe` int DEFAULT NULL,
  PRIMARY KEY (`idOrdem_Servico`),
  KEY `IdCarro_idx` (`IdCarro`),
  KEY `IdEquipe_idx` (`IdEquipe`),
  CONSTRAINT `IdCarro` FOREIGN KEY (`IdCarro`) REFERENCES `carro` (`idCarro`),
  CONSTRAINT `IdEquipe` FOREIGN KEY (`IdEquipe`) REFERENCES `equipe` (`idEquipe`)
); 


INSERT INTO `ordem_servico` VALUES (2,'2022-09-23 00:00:00','2022-09-25 00:00:00','Aguardando',1,1),(3,'2022-09-23 00:00:00','2022-09-25 00:00:00','Aguardando',2,2);

DROP TABLE IF EXISTS `pecas`;

CREATE TABLE `pecas` (
  `idPecas` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(45) NOT NULL,
  `Valor` float NOT NULL,
  PRIMARY KEY (`idPecas`)
);

INSERT INTO `pecas` VALUES (1,'KIT VELAS',45),(2,'ÓLEO SINTETICO 5W 30',35);

DROP TABLE IF EXISTS `pecasutilizadas`;

CREATE TABLE `pecasutilizadas` (
  `idPecasUtilizadas` int NOT NULL AUTO_INCREMENT,
  `Qtd` varchar(45) NOT NULL DEFAULT '1',
  `IdPecas` int DEFAULT NULL,
  `IdOS` int DEFAULT NULL,
  PRIMARY KEY (`idPecasUtilizadas`),
  KEY `IdPecas_idx` (`IdPecas`),
  KEY `IdOS_idx` (`IdOS`),
  CONSTRAINT `IdOS` FOREIGN KEY (`IdOS`) REFERENCES `ordem_servico` (`idOrdem_Servico`),
  CONSTRAINT `IdPecas` FOREIGN KEY (`IdPecas`) REFERENCES `pecas` (`idPecas`)
);

INSERT INTO `pecasutilizadas` VALUES (3,'4',1,2),(4,'2',2,3);

DROP TABLE IF EXISTS `servicorealizado`;

CREATE TABLE `servicorealizado` (
  `idServicoRealizado` int NOT NULL AUTO_INCREMENT,
  `IdServico` int NOT NULL,
  `IdOS` int NOT NULL,
  PRIMARY KEY (`idServicoRealizado`),
  KEY `IdServico_idx` (`IdServico`),
  KEY `IdOSs_idx` (`IdOS`),
  CONSTRAINT `IdOSs` FOREIGN KEY (`IdOS`) REFERENCES `servicos` (`idServicos`),
  CONSTRAINT `IdServico` FOREIGN KEY (`IdServico`) REFERENCES `servicos` (`idServicos`)
); 

INSERT INTO `servicorealizado` VALUES (1,1,1),(2,2,2);

DROP TABLE IF EXISTS `servicos`;

CREATE TABLE `servicos` (
  `idServicos` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(45) NOT NULL,
  `Valor` float NOT NULL,
  PRIMARY KEY (`idServicos`)
);

INSERT INTO `servicos` VALUES (1,'TROCA DE KIT VELAS',89),(2,'TROCA DE OLEO',65);
