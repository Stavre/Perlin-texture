class Save
{
  int x, y;
  int w;
  String[] extensions;
  GTextField name;
  GButton save;
  GDropList extension;
  Save(PApplet g,int X, int Y, int W, String[] e)
  {
    x = X;
    y = Y;
    w = W;
    extensions = e;
    name = new GTextField(g, x,y,70,20);
    extension = new GDropList(g, x + 90, y, 50, 100,2);
    save = new GButton(g, x + 160, y, 50, 25, "Save");
    extension.setItems(e, 0);

  }
}

class Arrow
{
  int x, y; 
  int w, h; 
  GButton colorpicker1;
  GSlider S;
  float len;
  PApplet i;
  color c;
  int control_var = 0;
  Arrow(PApplet g, int BX, int BY, int VX, int VY, color C)
  {
    c = C;
    i = g;
    x = BX;
    y = BY;
    w = VX;
    h = VY;
    S = new GSlider(g, x,y,w,h,10);
    S.setLimits(0, 255);
    colorpicker1 = new GButton(g, x - 20, y+h/4, 20, 20, "");
    colorpicker1.setLocalColor(4, c); //change button color
  }

  void setcolor(color h)
  {
    colorpicker1.setLocalColor(4, h);
    c = h;
  }
}

class Gradient
{
  int posx;
  int posy;
  
  int h;
  int w;
  
  color c0;
  color c1;
  
  Arrow B;
  Arrow C;

  Gradient(PImage grs, PApplet g, int x, int y, int W, int H, color C0, color C1)
  {
    posx = x;
    posy = y;
    h = H;
    w = W;  
    c0 = C0;
    c1 = C1;
  
    image(grs, posx, posy, w,h);
    //stroke(0);
    B = new Arrow(g,posx, posy - 30, w,  30, color(0));
    C = new Arrow(g,posx, posy+h, w,  30, color(255));
  }
  void show()
  {
    image(grs, posx, posy, w,h);
  }
}

class vector
{
  float x;
  float y;
  vector(float a, float b)
  {
    x = a;
    y = b;
  }
}
