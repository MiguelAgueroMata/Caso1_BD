-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema paymentAssistant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema paymentAssistant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `paymentAssistant` DEFAULT CHARACTER SET utf8 ;
USE `paymentAssistant` ;

-- -----------------------------------------------------
-- Table `paymentAssistant`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`users` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(80) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `password` VARBINARY(250) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`roles` (
  `roleID` INT NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`permissions` (
  `permissionID` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`permissionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`rolePermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`rolePermissions` (
  `rolePermissionID` INT NOT NULL AUTO_INCREMENT,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  `lastUpdate` DATETIME NOT NULL,
  `usename` VARCHAR(50) NOT NULL,
  `checksum` VARBINARY(128) NOT NULL,
  `roleID` INT NOT NULL,
  `permissionID` INT NOT NULL,
  PRIMARY KEY (`rolePermissionID`),
  INDEX `fk_rolePermissions_roles1_idx` (`roleID` ASC) VISIBLE,
  INDEX `fk_rolePermissions_permissions1_idx` (`permissionID` ASC) VISIBLE,
  CONSTRAINT `fk_rolePermissions_roles1`
    FOREIGN KEY (`roleID`)
    REFERENCES `paymentAssistant`.`roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolePermissions_permissions1`
    FOREIGN KEY (`permissionID`)
    REFERENCES `paymentAssistant`.`permissions` (`permissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userRoles` (
  `userRoleID` INT NOT NULL AUTO_INCREMENT,
  `lastUpdate` DATETIME NOT NULL,
  `usename` VARCHAR(45) NOT NULL,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  `checksum` VARBINARY(128) NOT NULL,
  `userID` INT NOT NULL,
  `roleID` INT NOT NULL,
  PRIMARY KEY (`userRoleID`),
  INDEX `fk_userRoles_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_userRoles_roles1_idx` (`roleID` ASC) VISIBLE,
  CONSTRAINT `fk_userRoles_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userRoles_roles1`
    FOREIGN KEY (`roleID`)
    REFERENCES `paymentAssistant`.`roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`paymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`paymentMethod` (
  `methodID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `secretKey` VARBINARY(256) NOT NULL,
  `apiURl` VARCHAR(200) NOT NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`methodID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`availablePayMethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`availablePayMethods` (
  `payMethod_ID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `token` VARBINARY(128) NOT NULL,
  `tokenExpirationDate` DATETIME NOT NULL,
  `maskAccount` VARCHAR(45) NOT NULL,
  `users_userID` INT NOT NULL,
  `paymentMethod_methodID` INT NOT NULL,
  PRIMARY KEY (`payMethod_ID`),
  INDEX `fk_availablePayMethods_users1_idx` (`users_userID` ASC) VISIBLE,
  INDEX `fk_availablePayMethods_paymentMethod1_idx` (`paymentMethod_methodID` ASC) VISIBLE,
  CONSTRAINT `fk_availablePayMethods_users1`
    FOREIGN KEY (`users_userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_availablePayMethods_paymentMethod1`
    FOREIGN KEY (`paymentMethod_methodID`)
    REFERENCES `paymentAssistant`.`paymentMethod` (`methodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`languages` (
  `languageID` INT NOT NULL AUTO_INCREMENT,
  `languageCode` VARCHAR(5) NULL,
  `languageName` VARCHAR(50) NULL,
  PRIMARY KEY (`languageID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`countries` (
  `countryID` INT NOT NULL,
  `countryName` VARCHAR(100) NOT NULL,
  `currencyID` INT NOT NULL,
  `languageID` INT NOT NULL,
  PRIMARY KEY (`countryID`),
  INDEX `fk_countries_languages1_idx` (`languageID` ASC) VISIBLE,
  CONSTRAINT `fk_countries_languages1`
    FOREIGN KEY (`languageID`)
    REFERENCES `paymentAssistant`.`languages` (`languageID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`currencies` (
  `currencyID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `acronym` CHAR(3) NOT NULL,
  `symbol` CHAR(3) NOT NULL,
  `countryID` INT NOT NULL,
  PRIMARY KEY (`currencyID`),
  INDEX `fk_currencies_countries1_idx` (`countryID` ASC) VISIBLE,
  CONSTRAINT `fk_currencies_countries1`
    FOREIGN KEY (`countryID`)
    REFERENCES `paymentAssistant`.`countries` (`countryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`payments` (
  `paymentID` INT NOT NULL AUTO_INCREMENT,
  `currencyID` INT NOT NULL,
  `payAmount` DECIMAL(10,2) NOT NULL,
  `currentAmount` DECIMAL(10,2) NOT NULL,
  `paymentDescription` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `userID` INT NOT NULL,
  `methodID` INT NOT NULL,
  PRIMARY KEY (`paymentID`),
  INDEX `fk_payments_currencies1_idx` (`currencyID` ASC) VISIBLE,
  INDEX `fk_payments_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_payments_paymentMethod1_idx` (`methodID` ASC) VISIBLE,
  CONSTRAINT `fk_payments_currencies1`
    FOREIGN KEY (`currencyID`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_paymentMethod1`
    FOREIGN KEY (`methodID`)
    REFERENCES `paymentAssistant`.`paymentMethod` (`methodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`currencyExchangeRate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`currencyExchangeRate` (
  `exchangeRateID` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NOT NULL,
  `currentExchangeRate` TINYINT NOT NULL,
  `enabled` BIT NOT NULL,
  `currencyID` INT NOT NULL,
  PRIMARY KEY (`exchangeRateID`),
  INDEX `fk_currencyExchangeRate_currencies1_idx` (`currencyID` ASC) VISIBLE,
  CONSTRAINT `fk_currencyExchangeRate_currencies1`
    FOREIGN KEY (`currencyID`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transactionType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transactionType` (
  `transTypeID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`transTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transactionSubTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transactionSubTypes` (
  `transSubTypeID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`transSubTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userBalance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userBalance` (
  `userBalanceID` INT NOT NULL AUTO_INCREMENT,
  `userID` BIGINT NOT NULL,
  `balance` DECIMAL(10,2) NOT NULL,
  `lastBalance` DECIMAL(10,2) NULL,
  `lastUpdate` DATETIME NOT NULL,
  `checksum` VARBINARY(60) NOT NULL,
  PRIMARY KEY (`userBalanceID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transactions` (
  `transactionID` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(100) NULL,
  `transactionDate` DATETIME NOT NULL,
  `postTime` DATETIME NOT NULL,
  `exchangeRateID` INT NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `paymentID` INT NOT NULL,
  `userID` INT NOT NULL,
  `transTypeID` INT NOT NULL,
  `transSubTypeID` INT NOT NULL,
  `userBalanceID` INT NOT NULL,
  PRIMARY KEY (`transactionID`),
  INDEX `fk_transactions_currencyExchangeRate1_idx` (`exchangeRateID` ASC) VISIBLE,
  INDEX `fk_transactions_payments1_idx` (`paymentID` ASC) VISIBLE,
  INDEX `fk_transactions_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_transactions_transactionType1_idx` (`transTypeID` ASC) VISIBLE,
  INDEX `fk_transactions_transactionSubTypes1_idx` (`transSubTypeID` ASC) VISIBLE,
  INDEX `fk_transactions_userBalance1_idx` (`userBalanceID` ASC) VISIBLE,
  CONSTRAINT `fk_transactions_currencyExchangeRate1`
    FOREIGN KEY (`exchangeRateID`)
    REFERENCES `paymentAssistant`.`currencyExchangeRate` (`exchangeRateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_payments1`
    FOREIGN KEY (`paymentID`)
    REFERENCES `paymentAssistant`.`payments` (`paymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_transactionType1`
    FOREIGN KEY (`transTypeID`)
    REFERENCES `paymentAssistant`.`transactionType` (`transTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_transactionSubTypes1`
    FOREIGN KEY (`transSubTypeID`)
    REFERENCES `paymentAssistant`.`transactionSubTypes` (`transSubTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_userBalance1`
    FOREIGN KEY (`userBalanceID`)
    REFERENCES `paymentAssistant`.`userBalance` (`userBalanceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`authPlatforms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`authPlatforms` (
  `authPlatformID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `secretKey` VARBINARY(128) NOT NULL,
  `key` VARBINARY(128) NOT NULL,
  `logoURL` VARCHAR(200) NULL,
  PRIMARY KEY (`authPlatformID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`authSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`authSessions` (
  `authSessionID` INT NOT NULL AUTO_INCREMENT,
  `sessionID` INT NOT NULL,
  `token` VARBINARY(128) NOT NULL,
  `refreshToken` VARBINARY(128) NOT NULL,
  `lastUpdate` DATETIME NOT NULL,
  `users_userID` INT NOT NULL,
  `authPlatforms_authPlatformID` INT NOT NULL,
  PRIMARY KEY (`authSessionID`),
  INDEX `fk_authSessions_users1_idx` (`users_userID` ASC) VISIBLE,
  INDEX `fk_authSessions_authPlatforms1_idx` (`authPlatforms_authPlatformID` ASC) VISIBLE,
  CONSTRAINT `fk_authSessions_users1`
    FOREIGN KEY (`users_userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_authSessions_authPlatforms1`
    FOREIGN KEY (`authPlatforms_authPlatformID`)
    REFERENCES `paymentAssistant`.`authPlatforms` (`authPlatformID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userPermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userPermissions` (
  `userPermissionID` INT NOT NULL AUTO_INCREMENT,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  `lastUpdate` DATETIME NOT NULL,
  `checksum` VARBINARY(128) NOT NULL,
  `permissionID` INT NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`userPermissionID`),
  INDEX `fk_userPermissions_permissions1_idx` (`permissionID` ASC) VISIBLE,
  INDEX `fk_userPermissions_users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_userPermissions_permissions1`
    FOREIGN KEY (`permissionID`)
    REFERENCES `paymentAssistant`.`permissions` (`permissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userPermissions_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`authSessionsLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`authSessionsLog` (
  `logID` INT NOT NULL,
  `logInTime` DATETIME NOT NULL,
  `logOutTime` DATETIME NOT NULL,
  `users_userID` INT NOT NULL,
  `authSessions_authSessionID` INT NOT NULL,
  PRIMARY KEY (`logID`),
  INDEX `fk_authSessionsLog_users2_idx` (`users_userID` ASC) VISIBLE,
  INDEX `fk_authSessionsLog_authSessions2_idx` (`authSessions_authSessionID` ASC) VISIBLE,
  CONSTRAINT `fk_authSessionsLog_users2`
    FOREIGN KEY (`users_userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_authSessionsLog_authSessions2`
    FOREIGN KEY (`authSessions_authSessionID`)
    REFERENCES `paymentAssistant`.`authSessions` (`authSessionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`file`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`file` (
  `fileID` INT NOT NULL AUTO_INCREMENT,
  `fileName` VARCHAR(225) NOT NULL,
  `fileURL` VARCHAR(225) NULL,
  `fileType` VARCHAR(45) NULL,
  `creationTime` DATETIME NULL,
  `deleted` BIT NOT NULL,
  PRIMARY KEY (`fileID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userFile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userFile` (
  `userFileID` INT NOT NULL AUTO_INCREMENT,
  `fileID` INT NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`userFileID`),
  INDEX `fk_userFile_file1_idx` (`fileID` ASC) VISIBLE,
  INDEX `fk_userFile_users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_userFile_file1`
    FOREIGN KEY (`fileID`)
    REFERENCES `paymentAssistant`.`file` (`fileID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userFile_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`banks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`banks` (
  `bankID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `bankCode` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `createdAt` DATETIME NULL,
  PRIMARY KEY (`bankID`),
  UNIQUE INDEX `companyID_UNIQUE` (`bankID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`bankAccounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`bankAccounts` (
  `bankAccountID` INT NOT NULL AUTO_INCREMENT,
  `bankName` VARCHAR(60) NOT NULL,
  `accountNumber` VARCHAR(50) NOT NULL,
  `userID` INT NOT NULL,
  `routingNumber` VARCHAR(45) NULL,
  `isPrimary` TINYINT NULL DEFAULT 0,
  `createdAt` DATETIME NULL,
  `bankID` INT NOT NULL,
  `currencyID` INT NOT NULL,
  PRIMARY KEY (`bankAccountID`),
  UNIQUE INDEX `BankAccountNumber_UNIQUE` (`accountNumber` ASC) VISIBLE,
  INDEX `fk_bankAccounts_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_bankAccounts_banks1_idx` (`bankID` ASC) VISIBLE,
  INDEX `fk_bankAccounts_currencies1_idx` (`currencyID` ASC) VISIBLE,
  CONSTRAINT `fk_bankAccounts_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bankAccounts_banks1`
    FOREIGN KEY (`bankID`)
    REFERENCES `paymentAssistant`.`banks` (`bankID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bankAccounts_currencies1`
    FOREIGN KEY (`currencyID`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`recuringPayments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`recuringPayments` (
  `reccuringPaymentID` INT NOT NULL AUTO_INCREMENT,
  `serviceName` VARCHAR(60) NULL,
  `ammount` DECIMAL(10,2) NOT NULL,
  `frequency` ENUM("semanal", "mensual", "anual") NOT NULL,
  `isActive` TINYINT NOT NULL,
  `userID` INT NOT NULL,
  `subscriptionsID` INT NOT NULL,
  `paymentDate` DATETIME NOT NULL,
  `creationDate` DATETIME NOT NULL,
  `lastUpdated` DATETIME NOT NULL,
  PRIMARY KEY (`reccuringPaymentID`),
  INDEX `fk_reccuringPayments_users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_reccuringPayments_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`reminders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`reminders` (
  `reminderID` INT NOT NULL AUTO_INCREMENT,
  `sent` BIT NULL,
  `reminderDate` DATETIME NOT NULL,
  `creationTime` DATETIME NOT NULL,
  `active` BIT NOT NULL,
  `type` ENUM("correo", "SMS") NOT NULL,
  `userID` INT NOT NULL,
  `paymentID` INT NOT NULL,
  `reccuringPaymentID` INT NOT NULL,
  PRIMARY KEY (`reminderID`),
  INDEX `fk_reminders_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_reminders_payments1_idx` (`paymentID` ASC) VISIBLE,
  INDEX `fk_reminders_recuringPayments1_idx` (`reccuringPaymentID` ASC) VISIBLE,
  CONSTRAINT `fk_reminders_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reminders_payments1`
    FOREIGN KEY (`paymentID`)
    REFERENCES `paymentAssistant`.`payments` (`paymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reminders_recuringPayments1`
    FOREIGN KEY (`reccuringPaymentID`)
    REFERENCES `paymentAssistant`.`recuringPayments` (`reccuringPaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`bankAPI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`bankAPI` (
  `bankAPIID` INT NOT NULL,
  `apiName` VARCHAR(100) NOT NULL,
  `apiURL` VARCHAR(225) NOT NULL,
  `apiKey` VARCHAR(225) NOT NULL,
  `creationTime` DATETIME NOT NULL,
  `bankID` INT NOT NULL,
  PRIMARY KEY (`bankAPIID`),
  INDEX `fk_bankAPI_banks1_idx` (`bankID` ASC) VISIBLE,
  CONSTRAINT `fk_bankAPI_banks1`
    FOREIGN KEY (`bankID`)
    REFERENCES `paymentAssistant`.`banks` (`bankID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`APILogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`APILogs` (
  `logID` INT NOT NULL AUTO_INCREMENT,
  `requestedData` JSON NOT NULL,
  `responseData` JSON NOT NULL,
  `statusCode` INT NOT NULL,
  `creationTime` DATETIME NOT NULL,
  `bankAPI` INT NOT NULL,
  PRIMARY KEY (`logID`),
  INDEX `fk_APILogs_bankAPI1_idx` (`bankAPI` ASC) VISIBLE,
  CONSTRAINT `fk_APILogs_bankAPI1`
    FOREIGN KEY (`bankAPI`)
    REFERENCES `paymentAssistant`.`bankAPI` (`bankAPIID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`subscriptionPlans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`subscriptionPlans` (
  `subcriptionPlanID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `billingFrequency` ENUM('monthly', 'yearly') NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `currencyID` INT NOT NULL,
  PRIMARY KEY (`subcriptionPlanID`),
  INDEX `fk_subscriptionPlans_currencies1_idx` (`currencyID` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptionPlans_currencies1`
    FOREIGN KEY (`currencyID`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`subscriptions` (
  `subscriptionID` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(120) NULL,
  `logoURL` VARCHAR(200) NULL,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NULL,
  `status` ENUM('active', 'canceled', 'paused') NOT NULL DEFAULT 'active',
  `subscriptionCreated` DATETIME NOT NULL,
  `subcriptionPlanID` INT NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`subscriptionID`),
  INDEX `fk_subscriptions_subscriptionPlans1_idx` (`subcriptionPlanID` ASC) VISIBLE,
  INDEX `fk_subscriptions_users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_subscriptionPlans1`
    FOREIGN KEY (`subcriptionPlanID`)
    REFERENCES `paymentAssistant`.`subscriptionPlans` (`subcriptionPlanID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logTypes` (
  `logTypeID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`logTypeID`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logSources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logSources` (
  `logSourceID` INT NOT NULL AUTO_INCREMENT,
  `logNameIdentifier` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`logSourceID`),
  UNIQUE INDEX `logNameIdentifier_UNIQUE` (`logNameIdentifier` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logSeverity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logSeverity` (
  `logSeverityID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `severityLevel` INT NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`logSeverityID`),
  UNIQUE INDEX `severityLevel_UNIQUE` (`severityLevel` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logs` (
  `logID` INT NOT NULL AUTO_INCREMENT,
  `logDescription` VARCHAR(200) NOT NULL,
  `postTime` DATETIME NOT NULL,
  `reference1` BIGINT NULL,
  `reference2` BIGINT NULL,
  `value1` VARCHAR(180) NULL,
  `value2` VARCHAR(180) NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `logTypeID` INT NOT NULL,
  `logSourceID` INT NOT NULL,
  `logSeverityID` INT NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`logID`),
  INDEX `fk_logs_logTypes1_idx` (`logTypeID` ASC) VISIBLE,
  INDEX `fk_logs_logSources1_idx` (`logSourceID` ASC) VISIBLE,
  INDEX `fk_logs_logSeverity1_idx` (`logSeverityID` ASC) VISIBLE,
  INDEX `fk_logs_users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_logs_logTypes1`
    FOREIGN KEY (`logTypeID`)
    REFERENCES `paymentAssistant`.`logTypes` (`logTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logSources1`
    FOREIGN KEY (`logSourceID`)
    REFERENCES `paymentAssistant`.`logSources` (`logSourceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logSeverity1`
    FOREIGN KEY (`logSeverityID`)
    REFERENCES `paymentAssistant`.`logSeverity` (`logSeverityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`apps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`apps` (
  `appID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `createdAt` DATETIME NULL,
  PRIMARY KEY (`appID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`tasks` (
  `taskID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `createdAt` DATETIME NULL,
  `appID` INT NOT NULL,
  PRIMARY KEY (`taskID`),
  INDEX `fk_tasks_apps1_idx` (`appID` ASC) VISIBLE,
  CONSTRAINT `fk_tasks_apps1`
    FOREIGN KEY (`appID`)
    REFERENCES `paymentAssistant`.`apps` (`appID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`audioRecordings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`audioRecordings` (
  `audioRecordingID` INT NOT NULL AUTO_INCREMENT,
  `recordingDate` DATETIME NOT NULL,
  `audioFilePath` VARCHAR(250) NOT NULL,
  `transcription` TEXT NULL,
  `userID` INT NOT NULL,
  `taskID` INT NOT NULL,
  PRIMARY KEY (`audioRecordingID`),
  INDEX `fk_audioRecordings_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_audioRecordings_tasks1_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `fk_audioRecordings_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audioRecordings_tasks1`
    FOREIGN KEY (`taskID`)
    REFERENCES `paymentAssistant`.`tasks` (`taskID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`screenRecordings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`screenRecordings` (
  `screenRecordingID` INT NOT NULL AUTO_INCREMENT,
  `screenRecordingDate` DATETIME NULL,
  `actionType` ENUM('click', 'hover', 'type', 'scroll') NOT NULL,
  `xPosition` INT NULL,
  `yPosition` INT NULL,
  `interactionElementName` VARCHAR(100) NOT NULL,
  `details` TEXT NOT NULL,
  `userID` INT NOT NULL,
  `taskID` INT NOT NULL,
  PRIMARY KEY (`screenRecordingID`),
  INDEX `fk_screenRecordings_users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_screenRecordings_tasks1_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `fk_screenRecordings_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `paymentAssistant`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_screenRecordings_tasks1`
    FOREIGN KEY (`taskID`)
    REFERENCES `paymentAssistant`.`tasks` (`taskID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`interactiveGuides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`interactiveGuides` (
  `guideID` INT NOT NULL AUTO_INCREMENT,
  `taskID` INT NOT NULL,
  `guideName` VARCHAR(100) NOT NULL,
  `steps` JSON NULL,
  `createdAt` DATETIME NULL,
  PRIMARY KEY (`guideID`),
  INDEX `fk_interactiveGuides_tasks1_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `fk_interactiveGuides_tasks1`
    FOREIGN KEY (`taskID`)
    REFERENCES `paymentAssistant`.`tasks` (`taskID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`cuePoints`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`cuePoints` (
  `cuePointID` INT NOT NULL AUTO_INCREMENT,
  `screenRecordingID` INT NOT NULL,
  `audioRecordingID` INT NOT NULL,
  `cuePointDate` DATETIME NULL,
  PRIMARY KEY (`cuePointID`),
  INDEX `fk_cuePoints_screenRecordings1_idx` (`screenRecordingID` ASC) VISIBLE,
  INDEX `fk_cuePoints_audioRecordings1_idx` (`audioRecordingID` ASC) VISIBLE,
  CONSTRAINT `fk_cuePoints_screenRecordings1`
    FOREIGN KEY (`screenRecordingID`)
    REFERENCES `paymentAssistant`.`screenRecordings` (`screenRecordingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuePoints_audioRecordings1`
    FOREIGN KEY (`audioRecordingID`)
    REFERENCES `paymentAssistant`.`audioRecordings` (`audioRecordingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
