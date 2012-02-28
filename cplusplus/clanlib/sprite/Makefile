####################################################################
# A tiny make file for my clanlib test				   #
# Author: MastodonHQ						   #
####################################################################

LIBS=clanApp clanCore clanDisplay clanGL1


all: main.cpp
	g++ main.cpp -o sprite `pkg-config --libs ${LIBS}` `pkg-config --cflags ${LIBS}`

clean:
	rm -rf sprite
