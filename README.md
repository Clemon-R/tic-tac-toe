# TicTacToe — Note synthétique

## Approche générale adoptée
L’objectif est de livrer un jeu de TicTacToe simple, clair et robuste. L’approche
privilégie une séparation nette entre la logique de jeu et l’interface, afin de
faciliter les évolutions tout en gardant un flux UI réactif et prévisible.

## Choix d’architecture et de state management
- Architecture Clean : `data` (services, repos, data sources, adapters), `ui` (views, providers), `domain` (entité, use cases, services), .
- La logique métier est portée par un service dédié, consommé par un provider.
- Le state management est centralisé dans un provider qui expose un modèle de
  state immuable aux vues, favorisant un rendu déterministe et des tests simples.

## Ce qui est implémenté
- Jeu complet de TicTacToe avec tour par tour.
- Détection des conditions de victoire et d’égalité.
- Écrans/états principaux : initial, en cours, fin de partie.

## Ce qui n’a pas été traité (manque de temps)
- Ajout d’un mode multi local.
- Polish UI avancés.
- Couverture de tests unitaires et d’intégration.

## Ce qui aurait été ajouté ou amélioré avec plus de temps
- Mode IA avec plusieurs niveaux de difficulté / différentes IA.
- Tests complets (service de jeu + provider + vues).
- Historique des parties, statistiques et rejouabilité.
- Améliorations UX (haptique, thèmes, scorings).

## Captures d’écran
![Ecran initial](images/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-02-03%20at%2015.22.30.png)
![Ecran de jeu](images/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-02-03%20at%2015.22.35.png)
![Ecran tour ordinateur](images/Simulator%20Screenshot%20-%20iPhone%2016e%20-%202026-02-03%20at%2015.22.39.png)
