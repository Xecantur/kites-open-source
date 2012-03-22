#include "lsmain.h"
#include "lsGL.h"

int main(int argc, char ** argv){
	SDL_Event Event;
       int errno = 0;
	errno = SDL_Init(SDL_INIT_EVERYTHING);
		if(errno < 0 || errno > 0){
			cout<<"Problem Initialising sdl..\n";
		}
	        screen = NULL;
      

		SDL_GL_SetAttribute( SDL_GL_RED_SIZE, 5 );
   		SDL_GL_SetAttribute( SDL_GL_GREEN_SIZE, 5 );
   		SDL_GL_SetAttribute( SDL_GL_BLUE_SIZE, 5 );
   		SDL_GL_SetAttribute( SDL_GL_DEPTH_SIZE, 16 );
  	 	SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );

	screen = SDL_SetVideoMode( 640, 480, 32, SDL_SWSURFACE | SDL_OPENGL | SDL_GL_DOUBLEBUFFER | SDL_RESIZABLE | SDL_HWPALETTE);
		if(screen == NULL){
			cout<<"Screen Failed...\n";
			exit(1);
		}
	lua_State * L;
	L = lua_open();
	luaL_openlibs(L);
//Register flushscreen();
lua_register(L,"flushscreen",flushscreen);
	
lsmain(L,Event);
cout<<"lsmain(L,Event) Finished successfully now quitting...\n";
return 0;
}
