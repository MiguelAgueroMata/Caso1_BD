use paymentAssistant;

SELECT * FROM users;

INSERT INTO users(email, firstName, lastName, birthdate, password, phoneNumber, enabled, deleted)
VALUES ('mata@gmail.com', 'Miguel', 'Aguero Mata', CURDATE(), UNHEX(SHA2('my_secure_password', 256)), 86976377, 1, 0 );