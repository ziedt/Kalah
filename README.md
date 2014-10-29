Kalah
======

In this project, we have implemented many AIs to solve the [Kalah](http://en.wikipedia.org/wiki/Kalah "Kalah in Wikipedia")  game in Prolog. To play against them, we have also made a Java interface. Some are easy to beat, and others are flawless players, so have fun trying to win !

![game board](https://github.com/ziedt/Projet-Prolog/blob/master/Java/img/fond.png)

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
(Slight differences from the rules in the [Wikipedia page](http://en.wikipedia.org/wiki/Kalah "Kalah in Wikipedia"))
* At the beginning of the game, four seeds are placed in each house.
* Each player controls the five houses and their seeds on the player's side of the board. The player's score is the number of seeds in the store to their right.
* Players take turns sowing their seeds. On a turn, the player removes all seeds from one of the houses under their control. Moving counter-clockwise, the player drops one seed in each house in turn, including the player's own store but not their opponent's.
* if the last sown seed lands in an opponent's house with (counting the dropped seed) 1, 2 or 3 seeds, the player captures these seeds and puts them in his store. If the previous house contains 1, 2 or 3 seeds, the players captures those seeds, and so on..
* If the last sown seed lands in the player's store, the player gets an additional move. There is no limit on the number of moves a player can make in their turn.
* When one player no longer has any seeds in any of their houses, the game ends. The other player moves all remaining seeds to their store, and the player with the most seeds in their store wins.

### Strategies
- Heuristics with a look-ahead of one:

	* End in store player: Landing in the player's store
	* Greedy player: chooses the first house that leads to a capture
	* Most seeds player: chooses the house that leads to the best capture in term of seeds.

- Mini-max search method used with Alpha-Beta pruning, with a look ahead of 7. We have implemented many evaluation functions, and an heuristic that combines many of them. 

A round-robin tournament was used to judge the strength of the heuristics.

