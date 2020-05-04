#!/bin/bash

echo "Mise a jour de liste des paquets"
sudo apt -qq update
echo "Installation du serveur Apache"
sudo apt -qq install apache2 -y
echo "Installation de Php"
sudo apt -qq install php -y
echo "Installation du base de données Mysql"
sudo apt -qq install mysql-server  -y

echo "create database db_app CHARACTER SET utf8 COLLATE utf8_general_ci; create user user_app identified by '12345'; grant all on db_app.* to user_app@'%'; " |sudo mysql -uroot -proot

echo "Creation des tables"

echo "CREATE TABLE Categories (id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,nom VARCHAR(255));

CREATE TABLE Articles (
 id INT NOT NULL AUTO_INCREMENT,
 Titre VARCHAR(255),
 contenu TEXT,
 categorie_id int,
 PRIMARY KEY (id),
 CONSTRAINT FK_article FOREIGN KEY (categorie_id) REFERENCES Categories(id)       
);

USE db_app; show tables;" | mysql -u user_app -p12345 -D db_app

echo "Insertion des données"

echo "INSERT INTO Categories (nom) VALUES ('Economie'),('Culture'),('Sport');

INSERT INTO Articles (Titre, contenu, categorie_id) VALUES 
('Comment s’effectuera la reprise du travail pour les métiers libéraux', 'Dans un communiqué publié hier vendredi 1er juin 2020', 1),
('Coronavirus : quels impacts économiques sur le cinéma ?', 'Les experts estiment que le coronavirus pourrait faire perdre jusqu’à 5 milliards de dollars au cinéma sur le plan mondial. Les exploitants des salles de cinéma sont les plus touchés par l’arrêt des diffusions. Alors que plus de la moitié de la planète est en confinement, plus personne ne fréquente les salles de cinéma. ', 2),
('La FTF vient au secours de Hamdi Naguez, comdamné à 4 mois de prison ferme', 'Dans un communiqué publié hier soir, la FTF a annoncé qu’elle a chargé les deux membres fédéraux, Amine Mougou et Hamed Maghrebi, ainsi que les deux membres de la Ligue nationale de football professionnel (LNFP), Hatem Doura et Mohamed Néjib Houas, de la défense de Hamdi Naguez.', 3);" | mysql -u user_app -p12345 -D db_app


echo "Deployment du page php"
mkdir /var/www/html/lamp
cp index.php /var/www/html/lamp

echo "La page est accessible a partir de: http://localhost/lamp"


















