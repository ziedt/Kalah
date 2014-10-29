Kalah
======

In this project, we have implemented many AIs to solve the [Kalah](http://en.wikipedia.org/wiki/Kalah "Kalah in Wikipedia")  game in Prolog. To play against them, we have also made a Java interface. Some are easy to beat, and others are flawless players, so have fun trying to win !
[picture]:https://github.com/ziedt/Projet-Prolog/blob/master/Java/img/fond.png
![game board][picture]

## Install
```
- Download the latest version of SWI-Prolog
- If you're on Windows, you need to add it to add it to your path.
	Example : "C:\Program Files\swipl\bin"
- run the JAR (in the release). Enter in the second input the absolute path to the file auto_launch_java.pl
	Example : "D:\Projet-Prolog\auto_launch_java.pl"
- Choose your opponent and start playing !
```
## Rules
- Le jeu contient 5 cases dans chaque camp + 1 store avant chaque camp adverse
- Au début, chaque case contient 4 graines (sauf les stores) (40 graines en tout dans le jeu)
- Chacun son tour les joueurs choisissent une case (pas un store !) et distribuent toutes les graines qui sont dedans en en mettant une dans chaque case. On met les graines dans les deux camps et aussi dans son store mais pas dans le store adverse
- Si la dernière graine distribuée tombe dans une case adverse qui contient (avec cette graine) 1, 2 ou 3 graines, on les ramasse et on les rajoute au store. On regarde alors si la case précédente contient 1, 2 ou 3 graines et si c'est le cas on la rajoute au store. On continue comme ça jusqu'à arriver à une case avec plus de 3 graines ou bien à une case de notre camp
- Si la dernière graine distribuée tombe dans notre store, on ne ramasse rien mais on rejoue.


###Stratégies
- aléatoire

- Mettre un max de graines directement dans le store
- Toujours ramasser la première solution trouvée (peu importe le nombre de graines)
- Choisir la solution qui permet de ramasser le plus de cases (pas forcément le plus de graines)
- Choisir la case qui permet de ramasser le plus de graines

- défensive : toujours en avoir au moins 3 dans chaque case de son camp
- défensive : évaluer les coups possibles de l'adversaire et choisir notre coup qui lui permet de ramasser le moins de graines possibles (min max avec n en argument)

###Heuristiques

http://eldar.mathstat.uoguelph.ca/dashlock/CIG2013/papers/paper_45.pdf
