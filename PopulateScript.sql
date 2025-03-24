INSERT INTO `paymentAssistant`.`languages` (`languageCode`, `languageName`) VALUES
    ('en', 'English'),
    ('es', 'Spanish');
    
INSERT INTO `paymentAssistant`.`countries` (`countryID`, `countryName`, `currencyID`, `languageID`) VALUES
    (1, 'United States', 1, 1),  -- USD, English
    (2, 'United Kingdom', 3, 1), -- GBP, English
    (3, 'Germany', 2, 1),        -- EUR, English (for simplicity)
    (4, 'Costa Rica', 4, 2);     -- CRC, Spanish

INSERT INTO `paymentAssistant`.`currencies` (`name`, `acronym`, `symbol`, `countryID`) VALUES
    ('US Dollar', 'USD', '$', 1),
    ('Euro', 'EUR', '€', 3),
    ('British Pound', 'GBP', '£', 2),
    ('Costa Rican Colon', 'CRC', '₡', 4);
    
    
INSERT INTO `paymentAssistant`.`currencyExchangeRate` 
    (`startDate`, `endDate`, `currentExchangeRate`, `enabled`, `currencyID`) VALUES
    -- USD to USD (always 1)
    ('2023-01-01', '2023-12-31', 1, 1, 1),
    ('2024-01-01', '2024-12-31', 1, 1, 1),
    ('2025-01-01', '2025-12-31', 1, 1, 1),
    
    -- EUR rates (approx 0.85-0.95 range)
    ('2023-01-01', '2023-12-31', 0, 1, 2),
    ('2023-01-01', '2023-03-31', 1, 0, 2),
    ('2023-04-01', '2023-06-30', 1, 0, 2),
    ('2023-07-01', '2023-09-30', 1, 0, 2),
    ('2023-10-01', '2023-12-31', 1, 0, 2),
    
    -- GBP rates (approx 0.75-0.85 range)
    ('2023-01-01', '2023-12-31', 0, 1, 3),
    ('2023-01-01', '2023-03-31', 1, 0, 3),
    ('2023-04-01', '2023-06-30', 1, 0, 3),
    ('2023-07-01', '2023-09-30', 1, 0, 3),
    ('2023-10-01', '2023-12-31', 1, 0, 3),
    
    -- CRC rates (approx 500-600 range)
    ('2023-01-01', '2023-12-31', 0, 1, 4),
    ('2023-01-01', '2023-03-31', 1, 0, 4),
    ('2023-04-01', '2023-06-30', 1, 0, 4),
    ('2023-07-01', '2023-09-30', 1, 0, 4),
    ('2023-10-01', '2023-12-31', 1, 0, 4);
    
    -- Update the actual rates for historical periods
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.92 WHERE `currencyID` = 2 AND `startDate` = '2023-01-01' AND `endDate` = '2023-03-31';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.89 WHERE `currencyID` = 2 AND `startDate` = '2023-04-01' AND `endDate` = '2023-06-30';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.94 WHERE `currencyID` = 2 AND `startDate` = '2023-07-01' AND `endDate` = '2023-09-30';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.91 WHERE `currencyID` = 2 AND `startDate` = '2023-10-01' AND `endDate` = '2023-12-31';
    
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.82 WHERE `currencyID` = 3 AND `startDate` = '2023-01-01' AND `endDate` = '2023-03-31';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.79 WHERE `currencyID` = 3 AND `startDate` = '2023-04-01' AND `endDate` = '2023-06-30';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.84 WHERE `currencyID` = 3 AND `startDate` = '2023-07-01' AND `endDate` = '2023-09-30';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 0.81 WHERE `currencyID` = 3 AND `startDate` = '2023-10-01' AND `endDate` = '2023-12-31';
    
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 550 WHERE `currencyID` = 4 AND `startDate` = '2023-01-01' AND `endDate` = '2023-03-31';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 560 WHERE `currencyID` = 4 AND `startDate` = '2023-04-01' AND `endDate` = '2023-06-30';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 540 WHERE `currencyID` = 4 AND `startDate` = '2023-07-01' AND `endDate` = '2023-09-30';
    UPDATE `paymentAssistant`.`currencyExchangeRate` 
    SET `currentExchangeRate` = 570 WHERE `currencyID` = 4 AND `startDate` = '2023-10-01' AND `endDate` = '2023-12-31';
    
    
INSERT INTO `paymentAssistant`.`currencyExchangeRate` 
    (`startDate`, `endDate`, `currentExchangeRate`, `enabled`, `currencyID`) VALUES
    ('2024-01-01', '2024-03-31', 0.93, 1, 2),
    ('2024-01-01', '2024-03-31', 0.83, 1, 3),
    ('2024-01-01', '2024-03-31', 580, 1, 4);
    
    
    
INSERT INTO `paymentAssistant`.`banks` (`name`, `bankCode`, `country`, `createdAt`) VALUES
    ('Banco de Costa Rica', 'BCR', 'Costa Rica', '2020-01-01'),
    ('Banco Nacional de Costa Rica', 'BNCR', 'Costa Rica', '2020-01-01'),
    ('Banco Popular', 'BPOP', 'Costa Rica', '2020-01-01'),
    ('Scotiabank Costa Rica', 'SCOT', 'Costa Rica', '2020-01-01'),
    ('BAC Credomatic', 'BAC', 'Costa Rica', '2020-01-01'),
    ('Bank of America', 'BOFA', 'United States', '2020-01-01'),
    ('Barclays', 'BARC', 'United Kingdom', '2020-01-01'),
    ('Deutsche Bank', 'DEUT', 'Germany', '2020-01-01');
    
INSERT INTO `paymentAssistant`.`bankAPI` (`bankAPIID`, `apiName`, `apiURL`, `apiKey`, `creationTime`, `bankID`) VALUES
    (1, 'BCR Payments API', 'https://api.bancobcr.com/payments', 'bcr-secret-key-123', '2020-01-01', 1),
    (2, 'BNCR Transactions API', 'https://api.bncr.fi.cr/transactions', 'bncr-secret-key-456', '2020-01-01', 2),
    (3, 'BAC Payment Gateway', 'https://api.baccredomatic.com/gateway', 'bac-secret-key-789', '2020-01-01', 5),
    (4, 'BOFA Transfers API', 'https://api.bankofamerica.com/transfers', 'bofa-secret-key-abc', '2020-01-01', 6);
    
    
INSERT INTO `paymentAssistant`.`paymentMethod` (`name`, `secretKey`, `apiURl`, `enabled`) VALUES
    ('Credit Card', UNHEX(SHA2('cc-secret-123', 256)), 'https://api.payments.com/cc', 1),
    ('Bank Transfer', UNHEX(SHA2('bt-secret-456', 256)), 'https://api.payments.com/bt', 1),
    ('PayPal', UNHEX(SHA2('pp-secret-789', 256)), 'https://api.payments.com/pp', 1),
    ('Crypto', UNHEX(SHA2('crypto-secret-abc', 256)), 'https://api.payments.com/crypto', 1);
    
INSERT INTO `paymentAssistant`.`subscriptionPlans` (`name`, `price`, `billingFrequency`, `createdAt`, `currencyID`) VALUES
    ('Free', 0.00, 'monthly', '2023-01-01', 1),
    ('Premium', 9.99, 'monthly', '2023-01-01', 1),
    ('PRO', 29.99, 'monthly', '2023-01-01', 1),
    ('Free', 0.00, 'yearly', '2023-01-01', 1),
    ('Premium', 99.99, 'yearly', '2023-01-01', 1),
    ('PRO', 299.99, 'yearly', '2023-01-01', 1);
    
INSERT INTO `paymentAssistant`.`transactionType` (`name`) VALUES
    ('Payment'),
    ('Transfer'),
    ('Withdrawal'),
    ('Deposit'),
    ('Fee');
    
    -- ======================================================================
    -- 10. Insert Transaction Subtypes
    -- ======================================================================
INSERT INTO `paymentAssistant`.`transactionSubTypes` (`name`) VALUES
    ('Recurring Payment'),
    ('One-time Payment'),
    ('Bank Transfer'),
    ('Peer Transfer'),
    ('ATM Withdrawal'),
    ('Bank Deposit'),
    ('Service Fee'),
    ('Late Fee');
    
INSERT INTO `paymentAssistant`.`roles` (`roleName`) VALUES
    ('Admin'),
    ('User'),
    ('Premium User'),
    ('PRO User'),
    ('Support'),
    ('Auditor');