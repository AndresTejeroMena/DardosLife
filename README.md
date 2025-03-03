# DardosLife
DardosLife is a personal project for recreational and learning purposes in which I have transformed a basic commercial electronic dartboard into one that, 
through an Arduino, is capable of sending information about where a dart has impacted to the computer. Using GODOT on the computer, I have programmed seven different games: 
501 series, cricket, battleship, connect4, burma road, ludo and football. 

Its use for commercial purposes is not permitted. 
The game concepts of battleship and connect4 are original creations, and the creator does not allow their commercial exploitation without consent. 

Project developer: Andrés Tejero Mena (tejeromenaandres@gmail.com).

## How does it work?
https://youtu.be/JF_7bkpHpz4

To carry out this project, the first step was to understand how an electronic dartboard works on the inside. If you dismantle one, you'll see that the sensors consist of two sheets with circuits drawn on them, separated by an insulator. One sheet has 10 circuits and the other has 7, so when a dart hits the dartboard, one circuit makes contact with another, and we can determine where it has impacted.

Knowing this, I unsoldered the connectors of these sheets from the electronic board and used an Arduino to collect that information and output it through the serial port to the computer.
To do this, I designed a PCB with EAGLE and had it manufactured.

The Arduino program performs a loop of signal scanning through the 7-pin sheet and waits for the arrival of current through the 10-pin sheet. When one of those 10 pins detects the HIGH signal, it checks from which pin the signal was sent and to which pin it was received. Based on a predefined matrix, we know where the dart has impacted. All that's left is to send it via serial. Depending on the dartboard model, this matrix will vary, so I've created two different Arduino programs for two different dartboards.

At this point, we already have a dartboard capable of sending information to the computer. To program the games, I used GODOT, a very intuitive and easy-to-learn tool. In less than a month, I went from not knowing about GODOT's existence to having programmed 7 games. The only thing needed for it to work is to use a C# script to read the serial port and send that information to GODOT, where I programmed all the games in its GDScript language.

This has been a very enjoyable project that I wanted to share with you. The goal was always to challenge myself and learn; there were never any commercial purposes involved.
## What I've used:
Decathlon Canaveral ED110 electronic dartboard

Arduino Nano 33 Ble

Soldering iron

10 resistors of 10KOhm

Laptop
