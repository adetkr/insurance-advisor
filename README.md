# README

L'app est disponible en ligne à l'url suivante: https://insurance-advisor229.herokuapp.com/

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
rails db:create db:migrate
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

Pour cette application j'ai fait le choix d'un monolithe Rails plutôt classique. L'application est structurée autour d'un mini-funnel où l'utilisateur a un parcours autour de 4 étapes:

- Renseigner les informations sur lui : à cette étape toutes les informations sont obligatoires
- Renseigner les informations sur son besoin
- Voir les résultats de la simulation et les recommandations qu'on peut lui faire pour les métiers qu'il a sélectionnés.
- Pouvoir à sa guise modifier la simulation ou en commencer une nouvelle.

Le choix d'organiser en mini-funnel me paraissait plus clair et permettait d'avoir un controller par étapes. L'ajout de potentielles étapes dans le parcours plus tard (type création de contrat, ou paiement, etc) sera plus facile et lisible.

## Structure de la base de donnée

<img width="894" alt="Screenshot 2022-08-17 at 12 51 54" src="https://user-images.githubusercontent.com/66008397/185102812-7a158307-e6d9-401d-8083-8eb1b8873566.png">


Contacts: C'est la table où sont stockées les informations sur le prospect.

Simulations: c'est la table qui stocke les informations concernant la demande de l'utilisateur mais également le résultat du devis. 

NacebelCodes: C'est la table qui recense tout les code nacebel à fartir du fichier CSV. Elle permet de prposer à l'utilisateur lors de la création de la simulation de pouvoir choisir dans cette liste les activités qui correspondent à sa situation. Cette table contient également un attribut recommendations qui permet de renseigner les différentes options conseillées par métier. Jai fait le choix de les renseigner par métier afin que cela soit plus flexible, et surtout potentiellement facilement éditable depuis un backoffice.


## Points à améliorer potentiellement

- Authentification des contacts

- Lors de l'update d'une simulation , faire une requête pour mettre à jour le devis (vu qu'on a un quote id de l'api), j'imagine qu'il doit être possible de l'update plutôt que d'en créer une nouvelle à chaque fois.

- mettre en cache la collection de nacebel_codes dans le formulaire pour pouvoir éviter de la recharger à chaque fois
