#ifndef _LSMAIN_H_
#define _LSMAIN_H_

#include <lua.hpp>
#include <iostream>
#include <SDL/SDL.h>
#include <SDL/SDL_thread.h>
#include "lsGL.h"
/*
================================
lsmain.h for Lsmain
================================
coded by Core
*/
using namespace std;

bool quit = false;

SDL_Surface * screen;
SDL_Thread * thread;

void interpret(lua_State* L){
	luaL_dofile(L,"glua.lua");
	int error;
	char buffer[256];
	while(quit == false){
	cout<<"Lua >> ";
	cin.getline(buffer,256);
	error = luaL_loadbuffer(L,buffer,strlen(buffer), "line") || lua_pcall(L,0,0,0);
	if(error){
		cout << lua_tostring(L,-1) << endl;
			lua_pop(L,1);
	}
}
}

int handler(void* data){
interpret((lua_State*) data);
return 0;
}



void lsmain(lua_State* L, SDL_Event event){
	
	cout<<"Initializing OpenGL ....\n";
	
	cout<<"Entering lsmain...\n";
	thread = SDL_CreateThread(handler, L);
	
	while(quit == false){
	  lua_getglobal(L,"flush");
	  int flush = lua_tonumber(L,1);
	  lua_pop(L,1);
	spinner(flush);
		SDL_GL_SwapBuffers();
		SDL_PollEvent(&event);
	if(event.type == SDL_QUIT){
		quit = true;
		cout<<"\nQuiting SDL\n";
		SDL_Quit();
		cout<<"SDL Quit...\n";
	  }	
	
	if(event.type == SDL_VIDEORESIZE){
		screen = SDL_SetVideoMode(event.resize.w, event.resize.h, 32, SDL_SWSURFACE | SDL_OPENGL | SDL_GL_DOUBLEBUFFER | SDL_RESIZABLE | SDL_HWPALETTE);
		if(screen == NULL){
		cout<<"\nScreen Failed...\n";
		exit(1);	
}
}
}
cout<<"Attempting to close lua...\n";
lua_close(L);
cout<<"Lua Closed\n";
}		
#endif
