import g4p_controls.*;
import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files
import javax.swing.JFileChooser;
import javax.swing.JFrame;

void setup()
{
  size(960,600);
  background(255);
  frameRate(200);
 // surface.setResizable(true);
  surface.setTitle("Generator rudimentar de texturi");
  G4P.setInputFont("Times New Roman", G4P.PLAIN, 16);
  G4P.setDisplayFont("Times New Roman", G4P.PLAIN, 18);
  frame = new JFrame("Demo program for JFrame");
  fileChooser = new JFileChooser();
  togG1Options = new GToggleGroup();
  grs = loadImage("grayscale.png");
  G4P.mouseWheelSpinnerDirection(G4P.FORWARD);
  
  labelfrequency = new GLabel(this, 620, 20, 280, 20);
  labelfrequency.setText("Base Frequency"); 
  frequency = new GTextField(this, 620, 40, 120, 20);
  frequency.setNumeric(0.0, 1000.0, 0.005);
  frequency.setText("0.005");
  
  labelfrequencystep = new GLabel(this, 750, 20, 280, 20);
  labelfrequencystep.setText("Frequency Step"); 
  frequencystep = new GTextField(this, 750, 40, 120, 20);
  frequencystep.setNumeric(0.0, 1000.0, 0.005);
  frequencystep.setText("2.0");
  
  labelamplitude = new GLabel(this, 620, 70, 280, 20);
  labelamplitude.setText("Base Amplitude"); 
  amplitude = new GTextField(this, 620, 90, 120, 20);
  amplitude.setNumeric(0.0, 1000.0, 2.0);
  amplitude.setText("1.0");
  
  labelamplitudestep = new GLabel(this, 750, 70, 280, 20);
  labelamplitudestep.setText("Amplitude Step"); 
  amplitudestep = new GTextField(this, 750, 90, 120, 20);
  amplitudestep.setNumeric(0.0, 1000.0, 0.005);
  amplitudestep.setText("0.5");
  
  labeloctaves = new GLabel(this, 620, 120, 280, 20);
  labeloctaves.setText("Octaves"); 
  octaves = new GTextField(this, 620, 140, 120, 20);
  octaves.setNumeric(0, 100, 1);
  octaves.setText("1");
  
  labeleffect = new GLabel(this, 750, 120, 280, 20);
  labeleffect.setText("Effect value"); 
  val = new GTextField(this, 750, 140, 120, 20);
  val.setNumeric(0.0, 100.0, 0.03);
  val.setText("0.03");
  
  labeleffectoptions = new GLabel(this, 720, 170, 280, 20);
  labeleffectoptions.setText("Effect options");
  
  grp1_a = new GOption(this, 620, 190, 57, 20);
  grp1_a.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  grp1_a.setText("None");

  grp1_b = new GOption(this, 690, 190, 51, 20);
  grp1_b.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  grp1_b.setText("Line");

  grp1_c = new GOption(this, 750, 190, 119, 20);
  grp1_c.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  grp1_c.setText("Checkerboard");
  
  grp1_d = new GOption(this, 880, 190, 120, 20);
  grp1_d.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  grp1_d.setText("Circle");
  
  shuffle = new GButton(this, 620, 220, 80, 40, "Shuffle");
  load = new GButton(this, 700, 220, 80, 40, "Load file");
  defparam = new GButton(this, 780, 220, 80, 40, "Default Param.");
  defcolor = new GButton(this, 860, 220, 80, 40, "Default Colors");
  
  String[] ext = {"txt", "jpg", "tif"};
  N = new Save(this, 650, 270, 30, ext);
  
  togG1Options.addControl(grp1_a);
  grp1_a.setSelected(true);
  togG1Options.addControl(grp1_b);
  togG1Options.addControl(grp1_c);
  togG1Options.addControl(grp1_d);
  
  A = new Gradient(grs, this, 60, 400, 255, 30, color(0,0,0), color(255, 255, 255));
  A.C.S.setValue(255);
  A.C.control_var = 255;
  A.B.control_var = 0;
  A.B.S.setValue(0);
  
  AA = new Gradient(grs, this, 350, 400, 255, 30, color(0,0,0), color(255, 255, 255));
  AA.B.S.setValue(0);
  AA.C.S.setValue(255);
  AA.C.control_var = 255;
  AA.B.control_var = 0;
  
  AAA = new Gradient(grs, this, 640, 400, 255, 30, color(0,0,0), color(255, 255, 255));
  AAA.B.S.setValue(0);
  AAA.C.S.setValue(255);
  AAA.C.control_var = 255;
  AAA.B.control_var = 0;
  
  AAAA = new Gradient(grs, this, 60, 500, 255, 30, color(0,0,0), color(255, 255, 255));
  AAAA.C.S.setValue(255);
  AAAA.C.control_var = 255;
  AAAA.B.control_var = 0;
  AAAA.B.S.setValue(0);
  
  AAAAA = new Gradient(grs, this, 350, 500, 255, 30, color(0,0,0), color(255, 255, 255));
  AAAAA.B.S.setValue(0);
  AAAAA.C.S.setValue(255);
  AAAAA.C.control_var = 255;
  AAAAA.B.control_var = 0;
  
  AAAAAA = new Gradient(grs, this, 640, 500, 255, 30, color(0,0,0), color(255, 255, 255));
  AAAAAA.B.S.setValue(0);
  AAAAAA.C.S.setValue(255);
  AAAAAA.C.control_var = 255;
  AAAAAA.B.control_var = 0;
  
  perlinnoisesquare(300, 1.0, 0.5, 0.005, 2.0, 1);
}

void draw(){
  fill(255);
  noStroke();
  rect(650, 270, 200, 100);  //draw square at droplist position, G4P needs it
  
  
  if (SliderChanged && (!A.B.S.hasFocus() || A.C.S.hasFocus() || AA.B.S.hasFocus() || AA.C.S.hasFocus() ||
                        !AAA.B.S.hasFocus() || AAA.C.S.hasFocus() || AAAA.B.S.hasFocus() || AAAA.C.S.hasFocus() ||
                        !AAAAA.B.S.hasFocus() || AAAAA.C.S.hasFocus() || AAAAAA.B.S.hasFocus() || AAAAAA.C.S.hasFocus())) 
  {
    //println("slider changed, new value = "+slider1.getValueI());
    SliderChanged = false;
    // run big computation using new slider value
    println("now");
    Color(300, A.B.S.getValueI(), A.B.c, A.C.S.getValueI(), A.C.c, 
             AA.B.S.getValueI(), AA.B.c, AA.C.S.getValueI(), AA.C.c,
             AAA.B.S.getValueI(), AAA.B.c, AAA.C.S.getValueI(), AAA.C.c,
             AAAA.B.S.getValueI(), AAAA.B.c, AAAA.C.S.getValueI(), AAAA.C.c,
             AAAAA.B.S.getValueI(), AAAAA.B.c, AAAAA.C.S.getValueI(), AAAAA.C.c,
             AAAAAA.B.S.getValueI(), AAAAAA.B.c, AAAAAA.C.S.getValueI(), AAAAAA.C.c);
  }
  
}

void handleButtonEvents(GButton button, GEvent event) 
{
  if (event == GEvent.CLICKED)
  {
      if (button == shuffle) //shuffle button
      {
        P.shuffle();
        perlinnoisesquare(300, amplitude.getValueF(), amplitudestep.getValueF(),
                               frequency.getValueF(), frequencystep.getValueF(), octaves.getValueI());
      }
      if (button == load)  //load button
      {
        fileChooser.setCurrentDirectory(new File(System.getProperty("user.home")));
        int result = fileChooser.showOpenDialog(frame);
        if (result == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();
            load(selectedFile.getAbsolutePath());
        }
        perlinnoisesquare(300, amplitude.getValueF(), amplitudestep.getValueF(),
                          frequency.getValueF(), frequencystep.getValueF(), octaves.getValueI());   
      }
      if (button == N.save)  //save button
      {
        if (N.extension.getSelectedText() == "txt")
        {
          PrintWriter file = createWriter(N.name.getText() + ".txt");
          file.println("Permutation " + P);
          file.println("Amplitude base " + amplitude.getValueF());
          file.println("Amplitude step " + amplitudestep.getValueF());
          file.println("Frequency base " + frequency.getValueF());
          file.println("Frequency step " + frequencystep.getValueF());
          file.println("No. of Octaves " + octaves.getValueI());
          file.println("Effect " + val.getValueF());
          file.println("None " + grp1_a.isSelected());
          file.println("Line-like " + grp1_b.isSelected());
          file.println("Checkerboard-like " + grp1_c.isSelected());
          file.println("Circle-like " + grp1_d.isSelected());   
          file.println("S1 value1 " + A.B.S.getValueS());
          file.println("S1 color1 " + int(red(A.B.c)) + " " + int(green(A.B.c)) + " " + int(blue(A.B.c)));
          file.println("S1 value2 " + A.C.S.getValueS());
          file.println("S1 color2 " + int(red(A.C.c)) + " " + int(green(A.C.c)) + " " + int(blue(A.C.c)));   
          file.println("S2 value1 " + AA.B.S.getValueS());
          file.println("S2 color1 " + int(red(AA.B.c)) + " " + int(green(AA.B.c)) + " " + int(blue(AA.B.c)));
          file.println("S2 value2 " + AA.C.S.getValueS());
          file.println("S2 color2 " + int(red(AA.C.c)) + " " + int(green(AA.C.c)) + " " + int(blue(AA.C.c)));    
          file.println("S3 value1 " + AAA.B.S.getValueS());
          file.println("S3 color1 " + int(red(AAA.B.c)) + " " + int(green(AAA.B.c)) + " " + int(blue(AAA.B.c)));
          file.println("S3 value2 " + AAA.C.S.getValueS());
          file.println("S3 color2 " + int(red(AAA.C.c)) + " " + int(green(AAA.C.c)) + " " + int(blue(AAA.C.c)));
          
          file.println("S4 value1 " + AAAA.B.S.getValueS());
          file.println("S4 color1 " + int(red(AAAA.B.c)) + " " + int(green(AAAA.B.c)) + " " + int(blue(AAAA.B.c)));
          file.println("S4 value2 " + AAAA.C.S.getValueS());
          file.println("S4 color2 " + int(red(AAAA.C.c)) + " " + int(green(AAAA.C.c)) + " " + int(blue(AAAA.C.c)));   
          file.println("S5 value1 " + AAAAA.B.S.getValueS());
          file.println("S5 color1 " + int(red(AAAAA.B.c)) + " " + int(green(AAAAA.B.c)) + " " + int(blue(AAAAA.B.c)));
          file.println("S5 value2 " + AAAAA.C.S.getValueS());
          file.println("S5 color2 " + int(red(AAAAA.C.c)) + " " + int(green(AAAAA.C.c)) + " " + int(blue(AAAAA.C.c)));    
          file.println("S6 value1 " + AAAAAA.B.S.getValueS());
          file.println("S6 color1 " + int(red(AAAAAA.B.c)) + " " + int(green(AAAAAA.B.c)) + " " + int(blue(AAAAAA.B.c)));
          file.println("S6 value2 " + AAAAAA.C.S.getValueS());
          file.println("S6 color2 " + int(red(AAAAAA.C.c)) + " " + int(green(AAAAAA.C.c)) + " " + int(blue(AAAAAA.C.c)));
          file.flush();
          file.close();
        }
        else
        {
          PImage gray, c;
          gray = get(0,0,300,300);
          c = get(300,0,300,300);
          if(N.extension.getSelectedText() == "tif")  //save as tif
          {
            gray.save(N.name.getText() + "grey.tif");
            c.save(N.name.getText() + "color.tif");
          }
          if(N.extension.getSelectedText() == "jpg")  //save as jpg
          {
            gray.save(N.name.getText() + "grey.jpg");
            c.save(N.name.getText() + "color.jpg");
          } 
        }
      }
      if (button == defcolor)  //default colorss button
      {
        //set slider default values
        A.B.S.setValue(0);
        A.C.S.setValue(255);
        
        AA.B.S.setValue(0);
        AA.C.S.setValue(255);
        
        AAA.B.S.setValue(0);
        AAA.C.S.setValue(255);
        
        AAAA.B.S.setValue(0);
        AAAA.C.S.setValue(255);
        
        AAAAA.B.S.setValue(0);
        AAAAA.C.S.setValue(255);
        
        AAAAAA.B.S.setValue(0);
        AAAAAA.C.S.setValue(255);
        
        //set default colors
        A.B.setcolor(color(0));
        A.C.setcolor(color(255));
        
        AA.B.setcolor(color(0));
        AA.C.setcolor(color(255));
        
        AAA.B.setcolor(color(0));
        AAA.C.setcolor(color(255));
        
        AAAA.B.setcolor(color(0));
        AAAA.C.setcolor(color(255));
        
        AAAAA.B.setcolor(color(0));
        AAAAA.C.setcolor(color(255));
        
        AAAAAA.B.setcolor(color(0));
        AAAAAA.C.setcolor(color(255));
      }
      if (button == defparam)  //default parameters button
      {
        //set default values
        amplitude.setText("1.0");
        frequency.setText("0.005");
        amplitudestep.setText("0.5");
        frequencystep.setText("2.0");
        octaves.setText("1");
        val.setText("0.03");
        
        grp1_a.setSelected(true); //check None option
        effect = 0; //set default effect(None)
        
        
        
        //set original permutation
        for (int i = 0; i < 256;i++)
          P.set(i, P_original.get(i));
        
        perlinnoisesquare(300, 1.0, 0.5, 0.005, 2.0, 1);
      }
      if (button == A.B.colorpicker1) //A B colorpicker button
      {
        A.B.setcolor(G4P.selectColor());
        A.show();
      }
      if (button == A.C.colorpicker1) //A C colorpicker button
      {
        A.C.setcolor(G4P.selectColor());
        A.show();
      }
      if (button == AA.B.colorpicker1 ) //AA B colorpicker button
      {
        AA.B.setcolor(G4P.selectColor());
        AA.show();
      }
      if (button == AA.C.colorpicker1) //AA C colorpicker button
      {
        AA.C.setcolor(G4P.selectColor());
        AA.show();
      }
      if (button == AAA.B.colorpicker1 ) //AAA B colorpicker button
      {
        AAA.B.setcolor(G4P.selectColor());
        AAA.show();
      }
      if (button == AAA.C.colorpicker1) //AAA C colorpicker button
      {
        AAA.C.setcolor(G4P.selectColor());
        AAA.show();  
      }
      
      if (button == AAAA.B.colorpicker1) //AAAA B colorpicker button
      {
        AAAA.B.setcolor(G4P.selectColor());
        AAAA.show();
      }
      if (button == AAAA.C.colorpicker1) //AAAA C colorpicker button
      {
        AAAA.C.setcolor(G4P.selectColor());
        AAAA.show();
      }
      if (button == AAAAA.B.colorpicker1 ) //AAAAA B colorpicker button
      {
        AAAAA.B.setcolor(G4P.selectColor());
        AAAAA.show();
      }
      if (button == AAAAA.C.colorpicker1) //AAAAA C colorpicker button
      {
        AAAAA.C.setcolor(G4P.selectColor());
        AAAAA.show();
      }
      if (button == AAAAAA.B.colorpicker1 ) //AAAAAA B colorpicker button
      {
        AAAAAA.B.setcolor(G4P.selectColor());
        AAAAAA.show();
      }
      if (button == AAAAAA.C.colorpicker1) //AAAAAA C colorpicker button
      {
        AAAAAA.C.setcolor(G4P.selectColor());
        AAAAAA.show();  
      }
  }
  Color(300, A.B.S.getValueI(), A.B.c, A.C.S.getValueI(), A.C.c, 
             AA.B.S.getValueI(), AA.B.c, AA.C.S.getValueI(), AA.C.c,
             AAA.B.S.getValueI(), AAA.B.c, AAA.C.S.getValueI(), AAA.C.c,
             AAAA.B.S.getValueI(), AAAA.B.c, AAAA.C.S.getValueI(), AAAA.C.c,
             AAAAA.B.S.getValueI(), AAAAA.B.c, AAAAA.C.S.getValueI(), AAAAA.C.c,
             AAAAAA.B.S.getValueI(), AAAAAA.B.c, AAAAAA.C.S.getValueI(), AAAAAA.C.c);
}
public void handleSliderEvents(GValueControl slider, GEvent event) 
{ 
  //println("K");
  //Color(300, A.B.S.getValueI(), A.B.c, A.C.S.getValueI(), A.C.c, 
  //           AA.B.S.getValueI(), AA.B.c, AA.C.S.getValueI(), AA.C.c,
  //           AAA.B.S.getValueI(), AAA.B.c, AAA.C.S.getValueI(), AAA.C.c,
  //           AAAA.B.S.getValueI(), AAAA.B.c, AAAA.C.S.getValueI(), AAAA.C.c,
  //           AAAAA.B.S.getValueI(), AAAAA.B.c, AAAAA.C.S.getValueI(), AAAAA.C.c,
  //           AAAAAA.B.S.getValueI(), AAAAAA.B.c, AAAAAA.C.S.getValueI(), AAAAAA.C.c);
  SliderChanged = true;
  if (event == GEvent.VALUE_STEADY) 
  {
    SliderChanged = true;
  }
}
public void handleToggleControlEvents(GToggleControl option, GEvent event) //Effects
{
  if(event == GEvent.SELECTED)
  {
    if (grp1_a.isSelected())
      effect = 0;  
    else if(grp1_b.isSelected())
      effect = 1;
    else if(grp1_c.isSelected())
      effect = 2; 
    else
      effect = 3;
    perlinnoisesquare(300, amplitude.getValueF(), amplitudestep.getValueF(),
                           frequency.getValueF(), frequencystep.getValueF(), octaves.getValueI());
    Color(300, A.B.S.getValueI(), A.B.c, A.C.S.getValueI(), A.C.c, 
             AA.B.S.getValueI(), AA.B.c, AA.C.S.getValueI(), AA.C.c,
             AAA.B.S.getValueI(), AAA.B.c, AAA.C.S.getValueI(), AAA.C.c,
             AAAA.B.S.getValueI(), AAAA.B.c, AAAA.C.S.getValueI(), AAAA.C.c,
             AAAAA.B.S.getValueI(), AAAAA.B.c, AAAAA.C.S.getValueI(), AAAAA.C.c,
             AAAAAA.B.S.getValueI(), AAAAAA.B.c, AAAAAA.C.S.getValueI(), AAAAAA.C.c);
  }
}
void handleTextEvents(GEditableTextControl source, GEvent event) { 
  if (event == GEvent.CHANGED) //input boxes
  {
    perlinnoisesquare(300, amplitude.getValueF(), amplitudestep.getValueF(),
                           frequency.getValueF(), frequencystep.getValueF(), octaves.getValueI());
    Color(300, A.B.S.getValueI(), A.B.c, A.C.S.getValueI(), A.C.c, 
             AA.B.S.getValueI(), AA.B.c, AA.C.S.getValueI(), AA.C.c,
             AAA.B.S.getValueI(), AAA.B.c, AAA.C.S.getValueI(), AAA.C.c,
             AAAA.B.S.getValueI(), AAAA.B.c, AAAA.C.S.getValueI(), AAAA.C.c,
             AAAAA.B.S.getValueI(), AAAAA.B.c, AAAAA.C.S.getValueI(), AAAAA.C.c,
             AAAAAA.B.S.getValueI(), AAAAAA.B.c, AAAAAA.C.S.getValueI(), AAAAAA.C.c);
  }
}
