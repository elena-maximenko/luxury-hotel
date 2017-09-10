CREATE DATABASE IF NOT EXISTS HotelDB;

CREATE TABLE IF NOT EXISTS Rooms
(
UId VARCHAR(100) NOT NULL,
Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
RoomNumber INT NOT NULL UNIQUE,
Category ENUM ('Junior Suite', 'De Luxe', 'Suite', 'Business room', 'Family studio', 'King Suite', 'President Suite') NOT NULL,
Price DECIMAL(19, 4) NOT NULL ,
Capacity ENUM ('Single','Double', 'Twin', 'Triple', 'Extra bed', 'Quadriple', 'Child') NOT NULL,
State ENUM ('Available', 'Reserved', 'Occupied', 'Unavailable')
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Images
(
UId VARCHAR(100) NOT NULL,
Id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Url VARCHAR(500) NOT NULL UNIQUE,
RoomId INT NOT NULL,
INDEX RId (RoomId),
FOREIGN KEY (RoomId) REFERENCES Rooms(Id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

DELIMITER //
CREATE TRIGGER NumberInsertChecker BEFORE INSERT ON Rooms FOR EACH ROW
BEGIN
IF(NEW.RoomNumber < 0) THEN
SET NEW.RoomNumber = ABS(NEW.RoomNumber);
END IF;
IF(NEW.Price < 0) THEN
SET NEW.Price = ABS(NEW.Price);
END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER NumberUpdateChecker BEFORE UPDATE ON Rooms FOR EACH ROW
BEGIN
IF(NEW.RoomNumber < 0) THEN
SET NEW.RoomNumber = ABS(NEW.RoomNumber);
END IF;
IF(NEW.Price < 0) THEN
SET NEW.Price = ABS(NEW.Price);
END IF;
END //
DELIMITER ;

CREATE TABLE IF NOT EXISTS Users
(Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
UId VARCHAR(100) NOT NULL,
Role ENUM ('Admin', 'Client') NOT NULL,
Login VARCHAR(100) NOT NULL UNIQUE,
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100) NOT NULL,
UserPassword VARCHAR(60) NOT NULL)
 ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Tokens
(Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
UId VARCHAR(100) NOT NULL,
Content VARCHAR(50) NOT NULL UNIQUE)
ENGINE = INNODB;

USE HotelDB;
CREATE TABLE UserToken
(UId VARCHAR(100) NOT NULL,
Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
UserId INT NOT NULL,
INDEX UsId (UserId), 
FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE ON UPDATE CASCADE,
TokenId INT NOT NULL,
INDEX TokId (TokenId),
FOREIGN KEY (TokenId) REFERENCES Tokens(Id) ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS Journal
(
 UId VARCHAR(100) NOT NULL,
 Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 RoomId INT NOT NULL,
 INDEX RId (RoomId),
 FOREIGN KEY (RoomId) REFERENCES Rooms(Id) ON DELETE CASCADE ON UPDATE CASCADE,
 UserId INT NOT NULL,
 INDEX UsId (UserId),
 FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE ON UPDATE CASCADE,
 MoveInDate Date NOT NULL,
 MoveOutDate Date NOT NULL
);

