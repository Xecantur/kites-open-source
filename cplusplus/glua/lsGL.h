#ifndef _LSGL_H_
#define _LSGL_H_

#include "lsmain.h"
#include <iostream>
#include <GL/gl.h>
using namespace std;
/*
================================
lsGL.h for Lsmain
================================
coded by Core
*/

static GLfloat spin = 0.0;
static GLfloat zspin = 0.0;
void initGL(){

glClearColor(0.0, 0.0, 0.0, 0.0);
   glClear(GL_COLOR_BUFFER_BIT);
   glColor3f(1.0, 1.0, 1.0);
   glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0); 
   glPushMatrix();
   glRotatef(spin, 0.0 , zspin , 1.0);
   glColor3f(0.0,1.0,1.0);
   /*glBegin(GL_POLYGON);
      glVertex2f(-0.5, -0.5); // neg, neg
      glVertex2f(-0.5, 0.5); // neg, pos
      glVertex2f(0.5, 0.5); // pos, pos
      glVertex2f(0.5, -0.5);// pos, neg
   glEnd();*/
   //glTranslatef(-1.5f,0.0f,-6.0f);
   glColor3f(1.0,0.0,0.0);
   glBegin(GL_POLYGON);
   glVertex3d(-0.5,-0.5,-0.5);  //neg,neg,neg
   glVertex3d(-0.5,0.5,-0.5);   //neg,pos,neg
   glColor3f(1.0,1.0,0.0);
   glVertex3d(-0.5,-0.5,0.5);   //neg,neg,pos
   glVertex3d(-0.5,0.5, 0.5);   //neg,pos,pos
   glColor3f(1.0,0.0,1.0);
   glVertex3d(0.5,-0.5, 0.5);   //pos,neg,pos
   glColor3f(0.0,1.0,1.0);
   glVertex3d(0.5,0.5,-0.5);	//pos,pos,neg
   glVertex3d(0.5,-0.5,-0.5);	//pos,neg,neg
   glVertex3d(0.5,0.5,0.5);     //pos,pos,pos
   glEnd();
   glFlush();
   glPopMatrix();
SDL_GL_SwapBuffers();
}


//lua handlers and user GL functions
void flushscr(){
glClearColor( 0.0, 0.0, 0.0, 0.0);
glClear(GL_COLOR_BUFFER_BIT);
SDL_GL_SwapBuffers();
}


int flushscreen(lua_State* L){
lua_gettop(L);
int x = lua_tonumber(L,1);
return x;
}
int spinner(int flush){
	spin = spin + 0.5;
	zspin = zspin + 0.5;
	if(zspin > 360){
	zspin = zspin - 360;
}
	if(spin > 360 ){
	spin = spin - 360;
}
	if(flush == 1){
	flushscr();
	}
        if(flush != 1){
	initGL();
}
return 0;
}




#endif
