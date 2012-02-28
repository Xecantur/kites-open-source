#include <clanlib/core.h>
#include <clanlib/display.h>
#include <clanlib/application.h>
#include <clanlib/gl1.h>
#include <iostream>

/*
This code is loosely based off of the clanlib Display example and thus is subject to the same licenses as the one on clanlibs website, the only I did was to put it into a class called sprite and added the ability to move the sprite up & down, and left and right.

Modifications By: MastodonHQ
*/
class sprite
{
	public:
static int main(const std::vector<CL_String> &args){
        CL_SetupCore setup_core;
        CL_SetupDisplay setup_display;
        CL_SetupGL1 setup_gl;
	int spx=10;
	int spy=10;
	int speed=9;
	CL_ResourceManager resources("./res/sres.xml");
        try {
                CL_DisplayWindow window("Hello World",640,480);
                CL_GraphicContext gc = window.get_gc();
                CL_InputDevice keyboard = window.get_ic().get_keyboard();
		CL_Sprite sprite1(gc,"s_one",&resources);
                CL_Font font(gc, "Nimbus",30);
                while(!keyboard.get_keycode(CL_KEY_ESCAPE)){
                        gc.clear(CL_Colorf::black);
			sprite1.draw(gc,spx,spy);
                        CL_Draw::line(gc,0,110,640,110,CL_Colorf::yellow);
       font.draw_text(gc,100,100,"Hello World!", CL_Colorf::lightseagreen);
			if(keyboard.get_keycode(CL_KEY_LEFT)){
				spx=spx-speed;
				sprite1.draw(gc,spx,spy);
			}
			else if(keyboard.get_keycode(CL_KEY_RIGHT)){
				spx=speed+spx;
				sprite1.draw(gc,spx,spy);
			}
			else if(keyboard.get_keycode(CL_KEY_UP)){
				spy=spy-speed;
				sprite1.draw(gc,spx,spy);
			}
			else if(keyboard.get_keycode(CL_KEY_DOWN)){
				spy=speed+spy;
				sprite1.draw(gc,spx,spy);
			}
  		        window.flip();
        		CL_KeepAlive::process();
        		CL_System::sleep(10);
}
        }
        catch(CL_Exception &exception){
        	CL_ConsoleWindow console("Console", 80, 160);
			CL_Console::write_line("Exception caught: " + exception.get_message_and_stack_trace());
			console.display_close_message();
		return -1;
        }
	return 0;
}
};
