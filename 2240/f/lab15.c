//
//
//CMPS 2240 lab11
//author: Xander Reyes
//date: Fall 2016, Fall 2022
//Framework for simple graphics using X11.
//
//Draw a dot (pixel)
//Draw several circles
//
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <X11/extensions/Xdbe.h>
#include <math.h>

//Global variables
Display *dpy;
Window win;
GC gc;
XdbeBackBuffer backBuffer;
XdbeSwapInfo swapInfo;
int xres = 640;
int yres = 480;

//Function prototypes
void initializeX11();
void cleanupX11();
void swapBuffers();
void checkResize(XEvent *e);
void clearScreen();
void setColor(int r, int g, int b);
void showMessage(int x, int y, const char *message);
void checkMouse(XEvent *e);
int checkKeys(XEvent *e);
void physics();
void render();




int main()
{
	int done = 0;
	srand((unsigned)time(NULL));
	initializeX11();
	while (!done) {
		//Handle all pending events in X11 queue...
		while (XPending(dpy)) {
			XEvent e;
			XNextEvent(dpy, &e);
			checkResize(&e);
			checkMouse(&e);
			done = checkKeys(&e);
		}
		physics();
		render();
		XdbeSwapBuffers(dpy, &swapInfo, 1);
		usleep(2000);
	}
	cleanupX11();
	return 0;
}

void setWindowTitle()
{
	XStoreName(dpy, win, "2240 lab");
}

void initializeX11()
{
	XSetWindowAttributes attributes;
	int major, minor;
	XdbeBackBufferAttributes *backAttr;
	dpy = XOpenDisplay(NULL);
    //List of events we want to handle
	attributes.event_mask = ExposureMask | StructureNotifyMask |
							PointerMotionMask | ButtonPressMask |
							ButtonReleaseMask | KeyPressMask | KeyReleaseMask;
	//Various window attributes
	attributes.backing_store = Always;
	attributes.save_under = True;
	attributes.override_redirect = False;
	attributes.background_pixel = 0x00000000;
	//Get default root window
	Window root = DefaultRootWindow(dpy);
	//Create a window
	win = XCreateWindow(dpy, root, 0, 0, xres, yres, 0,
					    CopyFromParent, InputOutput, CopyFromParent,
					    CWBackingStore | CWOverrideRedirect | CWEventMask |
						CWSaveUnder | CWBackPixel, &attributes);
	//Create gc
	gc = XCreateGC(dpy, win, 0, NULL);
	//Get DBE version
	if (!XdbeQueryExtension(dpy, &major, &minor)) {
		printf("Error: unable to fetch Xdbe Version.\n");
		XFreeGC(dpy, gc);
		XDestroyWindow(dpy, win);
		XCloseDisplay(dpy);
		exit(1);
	}
	//Get back buffer and attributes (used for swapping)
	backBuffer = XdbeAllocateBackBufferName(dpy, win, XdbeUndefined);
	backAttr = XdbeGetBackBufferAttributes(dpy, backBuffer);
    swapInfo.swap_window = backAttr->window;
    swapInfo.swap_action = XdbeUndefined;
	XFree(backAttr);
	//Map and raise window
	setWindowTitle();
	XMapWindow(dpy, win);
	XRaiseWindow(dpy, win);
}

void cleanupX11()
{
	//Deallocate back buffer
	if (!XdbeDeallocateBackBufferName(dpy, backBuffer)) {
		printf("Error: deallocating backBuffer!\n");
	}
	XFreeGC(dpy, gc);
	XDestroyWindow(dpy, win);
	XCloseDisplay(dpy);
}

void checkResize(XEvent *e)
{
	//ConfigureNotify is sent when the window is resized.
	if (e->type != ConfigureNotify) {
		return;
	}
	XConfigureEvent xce = e->xconfigure;
	xres = xce.width;
	yres = xce.height;
	setWindowTitle();
}

void clearScreen()
{
	XSetForeground(dpy, gc, 0x00000000);
	XFillRectangle(dpy, backBuffer, gc, 0, 0, xres, yres);
}

void setColor(int r, int g, int b)
{
	//to do:
	//overload this function to accept other color formats.
	//1. one 32-bit unsigned int
	//2. three unsigned chars, values from 0 to 255
	//3. three floats, values from 0.0 to 1.0 
	//4. char string, values are words such as skyblue, purple, pink, gold
	//5. one unsigned char, this represents a gray-scale color
	//6. other overloaded functions are ok
	//
	//format of color:
	//
	//   0x00rrggbb   <---- 32 bit unsigned integer
	//
	//   rr = red
	//   gg = green
	//   bb = blue
	//
	//A color value is added to the least significant byte, then shifted
	//left. This happens for red, green, blue, but blue does not have to
	//be shifted. It is already in place.
	//You can try using bitwise-and operator with color as mask.
	//We will do this in class together.
	unsigned long cref = 0L;
	cref += r;
	cref <<= 8;
	cref += g;
	cref <<= 8;
	cref += b;
	XSetForeground(dpy, gc, cref);
}

void checkMouse(XEvent *e)
{
	static int savex = 0;
	static int savey = 0;
	//
	if (e->type == ButtonRelease) {
		return;
	}
	if (e->type == ButtonPress) {
		if (e->xbutton.button==1) { }
		if (e->xbutton.button==3) { }
	}
	if (savex != e->xbutton.x || savey != e->xbutton.y) {
		//mouse moved
		savex = e->xbutton.x;
		savey = e->xbutton.y;
	}
}

int checkKeys(XEvent *e)
{
	int key = XLookupKeysym(&e->xkey, 0);
	//a key was pressed
	switch (key) {
		case XK_a:
			break;
		case XK_Left:
		case XK_Right:
		case XK_Up:
		case XK_Down:
			break;
		case XK_Escape:
			return 1;
	}
	return 0;
}

void physics()
{
	//This is where object movements is done.
	//None right now.
}

void setPixel(int x, int y)
{
	XDrawPoint(dpy, backBuffer, gc, x, y);
}

void BresenhamCircle(int xc, int yc, int rad)
{
	int x=0,y,d;
	int xxcp,xxcm,xycp,xycm,yxcp,yxcm,yycp,yycm;
	y = rad;
	d = 3 - (rad << 1);
	while (x <= y) {
		xxcp = xc+x;
		xxcm = xc-x;
		xycp = xc+y;
		xycm = xc-y;
		yxcp = yc+x;
		yxcm = yc-x;
		yycp = yc+y;
		yycm = yc-y;
		setPixel(yycp, xxcp);
		setPixel(yycm, xxcp);
		setPixel(yycp, xxcm);
		setPixel(yycm, xxcm);
		setPixel(yxcp, xycp);
		setPixel(yxcm, xycp);
		setPixel(yxcp, xycm);
		setPixel(yxcm, xycm);
		if (d < 0)
			d += ((x << 2) + 6);
		else
			d += (((x - y--) << 2) + 10);
		++x;
	}
}

extern int func1(int, int, int);
__asm__(".globl func1\n\t"
        ".type func1, @function\n\t"
        "func1:\n\t"
        ".cfi_startproc\n\t"
        "movl $7, %eax\n\t"
        "ret\n\t"
        ".cfi_endproc");

extern int func2(int, int);
__asm__(".globl func2\n\t"
        ".type func2, @function\n\t"
        "func2:\n\t"
        ".cfi_startproc\n\t"
        "movl %edi, %eax\n\t"
        "movl %esi, %ebx\n\t"
        "add %ebx, %eax\n\t"
        "ret\n\t"
        ".cfi_endproc");

/*extern int func3(int, int, int, int);
__asm__(".globl func3\n\t"
        ".type func3, @function\n\t"
        "func3:\n\t"
        ".cfi_startproc\n\t"
        "movl %edi, %eax\n\t"
        "movl %esi, %ebx\n\t"
        "shl $2, %ebx\n\t"
        "add %edx, %ebx\n\t"
        "add %ebx, %eax\n\t"
        "ret\n\t"
        ".cfi_endproc");
*/

extern int func3(int *, int *,int *);
__asm__(".globl func3\n\t"
        ".type func3, @function\n\t"
        "func3:\n\t"
        //Registers for arguments
        //*x= rdi
        //*y= rsi
        //*d= rdx
        //
        ".cfi_startproc\n\t"
        "cmpl $0, (%rdx)\n\t"
        "jl lessthan\n\t"
       
        "mov (%rdi), %eax\n\t"
        "sub (%rsi), %eax\n\t"
        "shl $2, %eax\n\t"
        "add $10, %eax\n\t" 
        "decl (%rsi)\n\t"
        "jmp bottom\n\t"
        
        "lessthan:\n\t"
        "mov (%rdi), %eax\n\t"
        "shl $2, %eax\n\t"
        "add $6,%eax\n\t"

        "bottom:\n\t"
        "add (%rdx), %eax\n\t"
        "incl (%rdi)\n\t"
        //"movl %eax, (%rdx)\n\t"
        "ret\n\t"
        ".cfi_endproc");

//=====================================================================
void inlineBresenhamCircle(int xc, int yc, int rad)
{
    (void)(xc+yc+rad); //remove this line when you start your work.

	//Copy and paste the Bresenham circle code from above,
	//then start your inline assembly work.
	//Convert some of the code in the algorithm, but not all.
    int x=0,y,d;
	int xxcp,xxcm,xycp,xycm,yxcp,yxcm,yycp,yycm;
	y = rad;
	//change this line to assembly
    //d = 3 - (rad << 1);
    d = func1(3, rad, 1);

	while (x <= y) {
		//xxcp = xc+x;
		xxcp = func2(xc, x);
		
        //xxcm = xc-x;
		xxcm = func2(xc,-x);
		
        //xycp = xc+y;
		xycp = func2(xc,y);
		
        //xycm = xc-y;
		xycm = func2(xc,-y);
		
        //yxcp = yc+x;
		yxcp = func2(yc,x);
		
        //yxcm = yc-x;
		yxcm = func2(yc,-x);
        yycp = func2(yc,y);    //yycp = yc+y;
		
        //yycm = yc-y;
		yycm = func2(yc,-y);
		setPixel(yycp, xxcp);
		setPixel(yycm, xxcp);
		setPixel(yycp, xxcm);
		setPixel(yycm, xxcm);
		setPixel(yxcp, xycp);
		setPixel(yxcm, xycp);
		setPixel(yxcp, xycm);
		setPixel(yxcm, xycm);
        

        d = func3(&x, &y, &d);
		
/*      if (d < 0)
			//d += ((x << 2) + 6);
			d = func3(d, x, 2,6);
		else
			//d += (((x - y--) << 2) + 10);
			d = func4(d, x, y, 10, 2);
		++x;
        */
	}



}
extern int func4(int *, int *);
__asm__(".globl func4\n\t"
        ".type func4, @function\n\t"
        "func4:\n\t"
        // rdi = &err
        // rsi = &yDiff
        ".cfi_startproc\n\t"
        "mov (%rdi), %eax\n\t"
        "mov (%rsi), %ebx\n\t"
        "sub %ebx, %eax\n\t"
        "ret\n\t"
        ".cfi_endproc");

extern int func5(int *, int *);
__asm__(".globl func5\n\t"
        ".type func5, @function\n\t"
        "func5:\n\t"
        ".cfi_startproc\n\t"
        "mov (%rdi), %eax\n\t"
        "mov (%rsi), %ebx\n\t"
        "add %ebx, %eax\n\t"
        "ret\n\t"
        ".cfi_endproc");

extern int func6(int, int);
__asm__(".globl func6\n\t"
        ".type func6, @function\n\t"
        "func6:\n\t"
        ".cfi_startproc\n\t"
        "cmp %rdi, %rsi\n\t"
        "jl lessthan1\n\t"
       
        "mov $-1, %eax\n\t"
        "jmp bottom1\n\t"
        
        "lessthan1:\n\t"
        "mov $1, %eax\n\t"
        
        "bottom1:\n\t"
        "ret\n\t"
        ".cfi_endproc");

extern int func7(int *, int *);
__asm__(".globl func7\n\t"
        ".type func7, @function\n\t"
        "func7:\n\t"
        ".cfi_startproc\n\t"
        "mov (%rdi), %eax\n\t"
        "mov (%rsi), %ebx\n\t"
        "sub %ebx, %eax\n\t"
        "cmp $0, %eax\n\t"
        "jg bottom2\n\t"

        "imul $-1, %eax \n\t"

        "bottom2:\n\t"
        "ret\n\t"
        ".cfi_endproc");

//=====================================================================

#define SWAP(x,y) (x)^=(y);(y)^=(x);(x)^=(y)

void myBresenhamLine(int x0, int y0, int x1, int y1)
{
    //Bresenham's line algorithm. integers only!
    //int steep = (((y1-y0)/(x1-x0)) > 1 || ((y1-y0)/(x1-x0)) < -1);
    int steep = (abs(y1-y0) > abs(x1-x0));
    
    if (steep) { 
        SWAP(x0, y0);
        SWAP(x1, y1);
    }
    if (x0 > x1) {
        SWAP(x0, x1);
        SWAP(y0, y1);
    }
    //int ystep = (y1>y0) ? 1 : -1;       //  x86 code
    int ystep = func6(y1, y0);       //  x86 code
    
    //int yDiff = abs(y1-y0);             // absolute x86 code
    int yDiff = func7(&y1, &y0);             // absolute x86 code
    int xDiff = x1 - x0;
    int err = xDiff >> 1;
    int x, y = y0;
    for (x=x0; x<=x1; x++) {
        if (steep)
            setPixel(y, x);
        else
            setPixel(x, y);
        //err -= yDiff;
        err = func4( &err, &yDiff); 
        if (err <= 0) {         // x86 AT&t syntax
            //y += ystep;
            y = func5(&y, &ystep);
            //err += xDiff;
            err = func5(&err, &xDiff);
        }
    }
}

//=====================================================================

void render()
{
	//This is where drawing on the screen is done.
	//First, clear the screen to black.
	clearScreen();
	//
	//Establish a center point for the graphics entities.
	int x = 200, y = 200;
	//
	//Set drawing color to white
	setColor(255, 255, 255);
	//
	//The following line will draw a point.
	//XDrawPoint(dpy, backBuffer, gc, 200, 200);
	//
	//Instead, call a function defined in an assembly program.
	//extern void showDot(char *, int, int);
	//showDot(NULL, x, y);
	//
	//Show text in light blue at pixel location (15, 15)
	setColor(160, 200, 255);
	char mess[] = "Lab15 2240 f22";
	XDrawString(dpy, backBuffer, gc, 15, 15, mess, strlen(mess));
	//
	//Draw a large yellow circle
	//setColor(255, 255, 0);
	//BresenhamCircle(x, y, 160);
	//BresenhamCircle(x, y, 10);
	//
	//==============================================
	//This is part of the lab assignment...
	//Draw a green circle inside the large circle.
	//The code below does not need to be changed.
	//==============================================
	/*setColor(100, 255, 100);
	inlineBresenhamCircle(x, y, 148);
	setColor(2550, 0, 0);
	inlineBresenhamCircle(x, y, 132);
    setColor(0, 0, 255);
	inlineBresenhamCircle(x, y, 110);
    setColor(255, 0, 255);
	inlineBresenhamCircle(x, y, 110);
    setColor(255, 255, 255);
	inlineBresenhamCircle(x, y, 98);
    */
    //==============================================
    //myBresenhamLine(0,50,50,40);
    //Now draw a circle
    int center[2] = {200, 200};
    double radius = 195.0;
    double angle = 0.0;
    const int n = 200;
    double inc = (2 *3.14159265358979)/ (double)n;
    double prevx,prevy;
    int i;
	setColor(255, 255, 0);
    double points[n][2];
    for (i = 0; i<=n; i++) {
        double x = cos(angle) * radius + center[0];
        double y = sin(angle) * radius + center[1];
        points[i][0] = cos(angle);
        points[i][1] = sin(angle);
        
        angle = angle + inc;
        setPixel(x, y);
        if (i > 0){
        myBresenhamLine(prevx,prevy,x,y);
        }
        prevx = x;
        prevy = y;
    }

    for (i = 0; i<n; i++) {
        setPixel(points[i][0]*20+50,points[i][1]*20+50);
    }
    int r = radius;
    int j= 4;
    for (i = 0; i<n; i++) {
        
        setPixel(points[i][0]*r+200,points[i][1]*r+200);
        myBresenhamLine(points[i][0]*r+200,points[i][1]*r+200,points[(j*i)%n][0]*r+200,points[(j*i)%n][1]*r+200);
    }
    
    int k = 2;
    int r2 = r-20;
	setColor(0, 255, 255);
    for (i = 0; i<n; i++) {
        
        setPixel(points[i][0]*r+200,points[i][1]*r+200);
        myBresenhamLine(points[i][0]*r+200,points[i][1]*r+200,points[(k*i)%n][0]*r+200,points[(k*i)%n][1]*r+200);
    }

      /* for (i = 0; i<=n; i++) 
       {
        
       }*/

     //  for (i = 0; i+i+i<=n; i++) 
      // {
       // myBresenhamLine(points[i][0]*r+200,points[i][1]*r+200,points[i+i+i][0]*r+200,points[i+i+i][1]*r+200);
       // }
//==============================================
}
    






