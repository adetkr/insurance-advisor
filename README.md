# README

L'app est disponible en ligne à l'adresse suivante: https://insurance-advisor229.herokuapp.com/

Suivez les instructions ci-dessous pour lancer l'app en local.

## Pré requis

* Rails 6.1.6.1
* ruby 2.7.4
* Yarn 1.22.11
* Node v14.16.1
* psql 13.5


## Cloner le repo

* git clone git@github.com:adetkr/insurance-advisor.git

## Remplir les variables d'env en créant un .env

```
cp .env.sample .env
```

## Lancer l'application

```
bundle install
yarn install
rails db:drop db:create db:migrate
rails s
```
Importer les codes NACEBEL dans la base de données et configurer les conseils pour les métiers liés au médical. Pour cela s'assurer que vous avez bien renseigné dans les vars d'env le chemin relatif vers le fichier NACEBEL_2008.csv

```
rake deploy:import_nacebel_data
```

Pour lancer les specs

```
rspec
```

# Documentation technique

Pour cette application j'ai fait le choix d'un monolithe Rails plutôt classique. L'app est structurée autour d'un mini funnel où l'utilisateur a un parcours autour de 3 étapes:

- Renseigner les informations sur lui
- Renseigner les informations sur son besoin
- Voir les les résultats de la simulation
- Pouvoir à sa guise modifier la simulation ou en commencer une nouvelle

## Structure de la base de donnée

<img width="894" alt="Screenshot 2022-08-17 at 12 51 54" src="https://user-images.githubusercontent.com/66008397/185102812-7a158307-e6d9-401d-8083-8eb1b8873566.png">


contacts:

simulations:

nacebel_code:

## Endpoints


## Points à améliorer

- Authentification

- Lors de l'update d'une simulation , faire un patch vu qu'on a un quote id de l'api, j'imagine qu'il doit être possible de l'update plutôt que de 
