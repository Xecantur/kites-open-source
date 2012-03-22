#!/bin/bash
clear
echo "Compiling lsmain.cpp"
g++ lsmain.cpp -o lsmain -lSDL -lGL -llua  -Wall -g
echo "Finished."
