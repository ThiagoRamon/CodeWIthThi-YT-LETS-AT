DROP DATABASE IF EXISTS lets_db;
CREATE DATABASE IF NOT EXISTS lets_db;

USE lets_db;

DROP TABLE IF EXISTS tb_user;
CREATE TABLE IF NOT EXISTS tb_user(
	id 			INT PRIMARY  KEY AUTO_INCREMENT,
	email 		VARCHAR(80)  NOT NULL UNIQUE,
    password 	VARCHAR(128) NOT NULL,
    situation   ENUM('A','I','B') DEFAULT 'I',
    insert_time TIMESTAMP DEFAULT (SYSDATE()),
    update_time TIMESTAMP DEFAULT NULL,
    delete_time TIMESTAMP DEFAULT NULL
);

INSERT INTO tb_user (email, password) 
VALUES ('contact@thiagoramon.com.br',sha2('codeWithThi',512) );

SELECT id, email FROM tb_user;


DROP TABLE IF EXISTS tb_profile;
CREATE TABLE IF NOT EXISTS tb_profile(
	id 			INT PRIMARY  KEY AUTO_INCREMENT,
	image 		VARCHAR(225)  DEFAULT NULL,
    username    VARCHAR(45) NOT NULL UNIQUE,  
    bio     	VARCHAR(255) DEFAULT NULL,
    insert_time TIMESTAMP DEFAULT (SYSDATE()),
    update_time TIMESTAMP DEFAULT NULL,
    delete_time TIMESTAMP DEFAULT NULL
);

INSERT INTO tb_profile (image, username, bio)
VALUES ('https://image_url.com/ing3.png', 'CodeWithThi12', 'MY BIO3');
SELECT * FROM tb_profile;

DROP TABLE IF EXISTS assoc_user_profile;
CREATE TABLE IF NOT EXISTS assoc_user_profile(
	id 			INT PRIMARY  KEY AUTO_INCREMENT,
    user_id		INT,
    profile_id	INT,
    insert_time TIMESTAMP DEFAULT (SYSDATE()),
    update_time TIMESTAMP DEFAULT NULL,
    delete_time TIMESTAMP DEFAULT NULL,
    
    FOREIGN KEY (user_id) REFERENCES tb_user(id),
    FOREIGN KEY (profile_id) REFERENCES tb_profile(id)
);


INSERT INTO assoc_user_profile (user_id, profile_id)
VALUES (1,2);

SELECT * FROM assoc_user_profile;

SELECT * FROM tb_user u 
	JOIN assoc_user_profile up on u.id = up.user_id 
	JOIN tb_profile p 		   on p.id = up.profile_id;



DROP TABLE IF EXISTS tb_link;
CREATE TABLE IF NOT EXISTS tb_link(
	id 			INT PRIMARY  KEY AUTO_INCREMENT,
	title 		VARCHAR(80)  NOT NULL,
    url         VARCHAR(255) NOT NULL,  
    url_code    VARCHAR(20) NOT NULL UNIQUE,
    profile_id	INT,
    insert_time TIMESTAMP DEFAULT (SYSDATE()),
    update_time TIMESTAMP DEFAULT NULL,
    delete_time TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (profile_id) REFERENCES tb_profile(id)
);

(SELECT COUNT(1) FROM tb_link l);
(SELECT to_base64((SELECT COUNT(1) FROM tb_link l)));

INSERT INTO tb_link (title, url, url_code, profile_id) 
VALUES ('THIAGO.COM', 'https://thiago.com',(SELECT to_base64((SELECT COUNT(1) FROM tb_link l))), 1);
SELECT * FROM tb_link;

-- lets.at/Mzk=