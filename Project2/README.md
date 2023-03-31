# Game of Set using JavaScript

###### CSE 3901 Project 1 - Sharks

This program is a JavaScript version of the game known as Set, built with JavaScript, HTML, and CSS.

#### Table of Contents:
1. Overview
- Features

2. Player Guide
- Requirements
- How to Run Program
- How to Play

3. File and Folder Descriptions
- Folder Descriptions
- File Descriptions

4. References/Other Notes

5. Testing

## 1. Overview
This game uses a combination of JavaScript, HTML, and CSS in order to build a functional Game of Set with timer difficulties, hints, and multiple players on the same device.

### Features
- **Player Names** - Players are able to choose their own names that show up on game screen.
- **Multiplayer Mode** - This mode allows multiple players to play at the same time using the same keyboard and device. There can only be any number of players between 1 and 4 players, where each player can choose sets and gain points based on their success during the game.
- **Hints** - This functionality will give the players a hint if there is still an undiscovered set on the board. This hint is in the form of finding one of the cards in the set that is on the board. It is up to the player to find the other two cards. Only one hint can be given per turn.
- **Highlighting** - The card that the player clicked will stay highlighted with a blue border. The hint functionality will also lightly highlight the given card and must be clicked by the player to be chosen.
- **Deck Remainder** - The amount of cards left in the deck is displayed in the user interface.
- **Scoring** - Player scores are displayed in the user interface.
- **End Game** - A player can end the game at any time by clicking the End Game button.
- **End Screen & Winner** - At the end of the game, the players with their scores are shown, and the winner is declared. The winner is the player with the most points.
- **Timer** - A timer is displayed in the user interface showing the player how time is left for their turn. Only one set can be found per turn.
- **Difficulties** - There are 3 difficulties implemented: Easy, Medium, and Hard. Medium is the default difficulty, which is simply changing how much time the player is given for their turn. Easy is 90 seconds, Medium is 60 seconds, and Hard is 30 seconds.\
- **Pause/Resume button** - A player can pause the game, which will cover the game board and stop the timer. After, they can resume the game and show the game board and resume the timer.
- **Leaderboard** - At the end game screen, the players and points values are shown there.

## 2. Player Guide
###  Requirements 
In order to properly run the program, the user that is downloading this app must install the 'Live Server' extension on their VS Code. We have not run this code on any other code editor, so this is the best way to run it.

###  How to Run Program
After downloading the extension 'Live Server', the user must start the Live Server extension and open the 'cover.html' file. This is the first page any user should navigate to when playing this game. The following should open the correct location of 'cover.html':

`127.0.0.1:PORT/cover.html`

###  How to Play

#### **Start at the cover.html page**
1. Either press 'Play' to insert the player names or 'Instructions' to learn more about how to play Set.

![image](https://user-images.githubusercontent.com/60246488/219981697-760f32ed-ba7f-4e44-9eec-2a291f7a00d8.png)
**This is an image of the home page where the player can choose to advance to the play name page or see the instructions.**

![image](https://user-images.githubusercontent.com/60246488/219981718-b56d7f1d-90a0-408d-ba5e-696aa19f7fa5.png)
**This is an image of the user clicking the instruction button on the home page and seeing the instructions on how to play Set.**

2. Enter the player names (expected to be unique) from 1 to 4 total players.

![image](https://user-images.githubusercontent.com/60246488/219981812-fe3c3a2b-4a40-4ca8-a8c2-4f63a108a7dd.png)
**This is an image of the player name page where the user can input up to 4 player names as well as adjust the difficulty between Easy, Medium, and Hard.

3. Press the 'Start' button to enter and start the game. The player presses 'Start' from the image above.
4. To play the game of set, there are several rules, which are listed below as well as in the instructions page.

![image](https://user-images.githubusercontent.com/60246488/219981906-152dd240-85f9-4c69-aac2-a289847141ee.png)
**This is an image of the user starting the game, which will make the game board, hints, ending game, scores, pausing, and timer available to the players. At this point, the players are now able to play the game.**

![image](https://user-images.githubusercontent.com/60246488/219992196-23b8481c-d203-40f0-8a2c-b84de1b020b2.png)
**This is an image of the user picking a correct set through the highlighting feature and addinga point. The game will automatically switch to the next turn.**

#### **Game Screen (Game of Set)**

The game of Set has several rules. 

At the start of the game, there are 12 face-up cards. The player turns are automatically switched and sets are automatically validated on the click of the third card. A set is a group of three cards that either has the same feature for each property for all three cards, or has a different feature for each property for all three cards. There are 4 properties (color, shape, number, shading), each with 3 features. If the clicked set is valid, then the player will be awarded 1 point. If the clicked set is not valid, the player loses 1 point. This game is played with rotating turns rather than a player clicking their name when they've found a set.

Everytime a set is found, those chosen cards are replaced. When there are no sets on the board at the start of the turn, this is automatically checked by the game logic and a redeal and shuffle of the deck is triggered. If a player is having difficulty, they can click "Hint" to get a hint. If a player does not want to play anymore, or wants to end the game, then they can press "End Game" to be brought to the end screen.

This continues and sets are chosen until there are no more cards to make up a set and/or the deck is depleted or there no other valid set left in the deck.

The Four Properties and Their Three Features:
Shape: Squiggle, Oval, Diamond
Colors: Red, Green, Purple
Shading: Solid, Transparent, Striped
Number: 1, 2, 3

#### **End Screen**
1. Scores are displayed, and the winner is announced!
2. To start a new game, you can start a game with the same players or go back to the home page.

## 3. File and Folder Descriptions

### **Folder Descriptions**

There are 3 folders that hold the main backend components and files required to make the game functional:

**1. card_images** - This folder holds all the PNGs for the cards, so that they are able to be used to make the game board.

**2. js** - This folder holds all the JavaScript files in order to make various components of the game functional. 

**3. css** - This folder holds all the CSS stylesheets in order to develop the specific UI, colors, and positioning of various elements of the user interface.

### **File Descriptions**

The card_images folder is full of PNG files for the card images for the game board.

**1. card.js** - This file creates each card and holds all the unique identifying information for each individual card. It also produces HTML required to show each of the cards on the game board.

**2. deck.js** - This file creates the deck of cards which holds all 81 unique cards that will be shuffled and made available to the players on the game board through the duration of the game.

**3. player.js** - This file creates each player and holds all the unique identifying information for each individual player. It also keeps track of a player's score by either adding or deducting a point. This only happens when a set is correct or incorrect.

**4. set_game.js** - This file holds all the functions that enable all the main functionality for the game on the game board. This also holds functions that collect information from the player name page to display on the game board as well.

**5. gamepage.css** - This file holds all the styling for the game board page and the gameplay user interface components such as the game board, scoring, buttons, fonts, colors, and timers.

**6. intropages.css** - This file holds all the styling for all pages before the game board page such as the cover, instructions, and player names pages and the user interface components such as the buttons, fonts, and colors.

**7. cover.html** - This file holds all the browser-facing text UI components for the initial cover page such as the 'Play' and 'Instructions' buttons and the title. This page implements the intropages.css stylesheet aand the player.js JavaScript file.

**8. instruction.html** - This file holds all the browser-facing text UI components for the initial cover page. This page holds only text and the 'Bakc to Home' button.

**9. playername.html** - This file holds all the browser-facing text UI components for the player name page such as the player name input box, the add player button, the difficulty dropdown, the list of players, and the game start button. This page implements the intropages.css stylesheet aand the player.js JavaScript file.

**10. game.html** - This file holds all the browser-facing text UI components for the game board/UI page such as the game board, the timer, the number of cards in the deck, the generate hint button, the pause game button, the end game button, and the player scoreboard. This page implements the gamepage.css stylesheet and the set_game.js JavaScript file.

## 4. References/Other Notes

**Game of Set Wikipedia**: https://en.wikipedia.org/wiki/Set_(card_game) 

## 5. Testing

All of the testing was done in each of the developers' respective branches. The testing was done using the browser console along with numerous console.log calls for various functions. The gameplay testing was done using a series of planned out steps for each of the developers. Each developer and the project manager were assigned various test cases to check for incorrectness and boundary cases. This was done simply by playing the game and testing each test case.
