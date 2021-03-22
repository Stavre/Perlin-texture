color colorfilter(color pixelc, int pos00, color c00, int pos01, color c01,
                                int pos10, color c10, int pos11, color c11,
                                int pos20, color c20, int pos21, color c21,
                                int pos30, color c30, int pos31, color c31,
                                int pos40, color c40, int pos41, color c41,
                                int pos50, color c50, int pos51, color c51)
{
  int p = (pixelc >> 16 & 0xFF);  //p is used as greyscale value
  float w = norm(p, 0, 255); //pixelc >> 16 & 0xFF bitwise operations for getting red
  if (pos00 <= p && p <=pos01)
  {
    return lerpColor(c00, c01, w); 
  }
  else if (pos10 <= p && p <=pos11)
  {
    return lerpColor(c10, c11, w);
  }
  else if (pos20 <= p && p <=pos21)
  {
    return lerpColor(c20, c21, w);
  }
  else if (pos30 <= p && p <=pos31)
  {
    return lerpColor(c30, c31, w); 
  }
  else if (pos40 <= p && p <=pos41)
  {
    return lerpColor(c40, c41, w);
  }
  else if (pos50 <= p && p <=pos51)
  {
    return lerpColor(c50, c51, w);
  }
  return pixelc;
}

void Color(int l, int gr0, color c0, int gr1, color c1, 
                  int gr00, color c00, int gr11, color c11,
                  int gr000, color c000, int gr111, color c111,
                  int gr0000, color c0000, int gr1111, color c1111, 
                  int gr00000, color c00000, int gr11111, color c11111,
                  int gr000000, color c000000, int gr111111, color c111111)
{
  fill(255);
  noStroke();
  rect(300, 0, 300,300);
  PImage t = get(0,0,300,300);
  loadPixels();
  for (int x = 0; x < 90000; x++)
  {
      t.pixels[x] = colorfilter(t.pixels[x], gr0, c0, gr1, c1,
                                   gr00, c00, gr11, c11,
                                   gr000, c000, gr111, c111,
                                   gr0000, c0000, gr1111, c1111,
                                   gr00000, c00000, gr11111, c11111,
                                   gr000000, c000000, gr111111, c111111);
  }
  updatePixels();
  image(t, 300, 0,300,300);
}
float dotGridGradient(vector displacement, vector gradient)
{
  return gradient.x * displacement.x + gradient.y * displacement.y;
}
vector getgradient(int v)
{
        //v is the value from the permutation table
        int h = v & 3; //equivalent with v % 4 
        switch (h)
        {
          case (0):
            return new vector(1.0, 1.0);
          case (1):
            return new vector(-1.0, 1.0);
          case (2):
            return new vector(-1.0, -1.0);
          default:
            return new vector(1.0, -1.0);
        }  
}
float pixelnoise(vector pos) 
{
  //corner coordinates
  int x0 = floor(pos.x);
  int x1 = x0+1;
  int y0 = floor(pos.y);
  int y1 = y0+1;
  
  float xf = pos.x - x0;
  float yf = pos.y - y0;
  
  //displacement vectors
  //vector displacementtopright = new vector(xf-1.0, yf-1.0); 
  //vector displacementtopleft = new vector(xf, yf-1.0);
  //vector displacementbottomright = new vector(xf-1.0, yf);
  //vector displacementbottomleft = new vector(xf, yf);
  
  // Determine interpolation weights
  float sx = ((6*xf - 15)*xf + 10)*xf*xf*xf;
  float sy = ((6*yf - 15)*yf + 10)*yf*yf*yf;
  
  //select values from lookup table
  int valueTopRight = P.get(P.get(x1&255)+y1&255);
  int valueTopLeft = P.get(P.get(x0&255)+y1&255);
  int valueBottomRight = P.get(P.get(x1&255)+y0&255);
  int valueBottomLeft = P.get(P.get(x0&255)+y0&255);
  
  //get gradient vectors from lookup table values
  //vector gradienttopright = getgradient(valueTopRight);
  //vector gradienttopleft = getgradient(valueTopLeft); 
  //vector gradientbottomright = getgradient(valueBottomRight); 
  //vector gradientbottomleft = getgradient(valueBottomLeft);
  
  //dot products between gradient ectors and displacement vectors
  float dottopright = dotGridGradient(new vector(xf-1.0, yf-1.0), getgradient(valueTopRight));
  float dottopleft = dotGridGradient(new vector(xf, yf-1.0), getgradient(valueTopLeft));
  float dotbottomright = dotGridGradient(new vector(xf-1.0, yf), getgradient(valueBottomRight)); 
  float dotbottomleft = dotGridGradient(new vector(xf, yf), getgradient(valueBottomLeft)); 
  
  // Interpolate between grid point gradients
  float ix0, ix1, value;
  ix0 = interpolate(dotbottomleft, dotbottomright, sx);
  ix1 = interpolate(dottopleft, dottopright, sx);
  value = interpolate(ix0, ix1, sy);
  return value;
}
void perlinnoisesquare(int l, float amplitude, float amplitudestep, float frequency, float frequencystep, int octaves)
{
  PImage t = get(0,0,l,l);
  loadPixels();
  fill(255);
  noStroke();
  rect(0, 0, l, l);
  float n = 0.0;
  float a = amplitude;
  float as = amplitudestep;
  float f = frequency;
  float fs = frequencystep;
  int s = l*l;

  for (int x = 0; x < l;x++)
  {
    for (int y = 0; y < l; y++)
    {   
      for (int i = 0; i < octaves; i++)
      {
        n = n + a*pixelnoise(new vector(f*x, f*y));
        a = a * as;
        f = f * fs;
      }
      n = constrain((n + 1)*0.5, 0, 1);
      switch(effect) 
      {
      case 0: 
        break;
      case 1: 
        n = sin(y*val.getValueF()*n) ;
        break;
      case 2: 
        n = (floor(2*x*val.getValueF()*n) + floor(n*2*y*val.getValueF()))%2;
        break;
      case 3: 
        n = sin(sqrt((x-150)*(x-150)+(y-150)*(y-150) - (x-150) - (y-150) +0.5)*val.getValueF()*n);
        break;
      }
      stroke(map(n,0,1,0,255));   
      t.pixels[y*l+x] = color(map(n,0,1,0,255));//point(x,y);
      n = 0;
      a = amplitude;
      as = amplitudestep;
      f = frequency;
      fs = frequencystep;
    }
  }
  updatePixels();
  image(t, 0, 0, l, l);
}
float interpolate(float a0, float a1, float w) 
{
   //return (a1 - a0) * w + a0;
   return (a1 - a0) * (3.0 - w * 2.0) * w * w + a0;
   //return (a1 - a0) * ((w * (w * 6.0 - 15.0) + 10.0) * w * w * w) + a0;   
}
