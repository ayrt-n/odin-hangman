# Ruby Hangman

## Overview

Project for The Odin Project (https://www.theodinproject.com/) to recreate the game Hangman with Ruby, played from the command line.

The goal of hangman is to guess the hidden word by asking whether the it contains certain letters. If you make 6 incorrect guesses then the game is over and you lose. If you are able to successfully guess the word then you win!

Words are randomly generated based off of a dictionary of words (5 to 12 letters long).

## How to use

The game can be run from the command line by simply running:

```
$ ruby example_game.rb
```

Further instructions provided within the command line.

## Key Topics

This project was part of the 'Files and Serialization' section of the course.

In addition to playing hangman, the game provides users the option to save their game to play again later. When prompted for a guess, users may enter 'save' to save and quit. The class is then serialzied to JSON format and saved within the /saved_games/ folder.

When starting a game, players are provided the option to load a saved game. The launcher will display all available saved files and once selected will deserialize the JSON file and start the game where it was left off.
