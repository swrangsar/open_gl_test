#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>

#include <stdio.h>

#define SCREEN_WIDTH 	800
#define SCREEN_HEIGHT	500


int main(int argc, const char *argv[])
{
	SDL_Window *window;
	SDL_GLContext context;
	SDL_Event window_event;

	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		fprintf(stderr, "SDL couldn't init! SDL_Error: %s\n", SDL_GetError());
		return 1;
	}

	SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 1);
	

	window = SDL_CreateWindow("OpenGL", 100, 100, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_OPENGL);
	if (!window)
		fprintf(stderr, "window creation failed! SDL_Error: %s\n", SDL_GetError());
	context = SDL_GL_CreateContext(window);

	while (1) {
		if (SDL_PollEvent(&window_event)) {
			if (window_event.type == SDL_QUIT)
				break;
		}
		
		SDL_GL_SwapWindow(window);
	}

	SDL_DestroyWindow(window);
	SDL_GL_DeleteContext(context);
	SDL_Quit();
	return 0;
}
