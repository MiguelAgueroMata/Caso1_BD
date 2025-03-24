use paymentAssistant;

SELECT * FROM users;

INSERT INTO users(email, firstName, lastName, birthdate, password, phoneNumber, enabled, deleted)
VALUES ('mata@gmail.com', 'Miguel', 'Aguero Mata', CURDATE(), UNHEX(SHA2('my_secure_password', 256)), 86976377, 1, 0 );

SELECT * FROM languages;

SELECT * FROM countries;

SELECT * FROM currencies;

SELECT * FROM currencyExchangeRate;
ALTER TABLE `paymentAssistant`.`currencyExchangeRate` 
MODIFY COLUMN `currentExchangeRate` DECIMAL(10,6) NOT NULL;


SELECT * FROM banks;
SELECT * FROM bankAPI;

SELECT * FROM paymentMethod;

SELECT * FROM subscriptionPlans;

SELECT * FROM TransactionType;
SELECT * FROM transactionSubTypes;

SELECT * FROM roles;



