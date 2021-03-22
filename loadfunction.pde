void load(String selection)
{
  String[] lines = loadStrings(selection);
  String[] p = lines[0].split(" ");
  IntList k = new IntList();
  for (int i = 4 ; i < p.length-1; i++) 
  {
    k.append(int(p[i].replace(",","")));
  }
  P = k;
  p = lines[1].split(" ");
  amplitude.setText(p[2]);
  
  p = lines[2].split(" ");
  amplitudestep.setText(p[2]);
  
  p = lines[3].split(" ");
  frequency.setText(p[2]);
  
  p = lines[4].split(" ");
  frequencystep.setText(p[2]);
  
  p = lines[5].split(" ");
  octaves.setText(p[3]);
  
  p = lines[6].split(" ");
  val.setText(p[1]);
  
  p = lines[7].split(" ");
  grp1_a.setSelected(boolean(p[1]));
  if (boolean(p[1]))
    effect = 0;
  
  p = lines[8].split(" ");
  grp1_b.setSelected(boolean(p[1]));
  if (boolean(p[1]))
    effect = 1;
  
  p = lines[9].split(" ");
  grp1_c.setSelected(boolean(p[1]));
  if (boolean(p[1]))
    effect = 2;
  
  p = lines[10].split(" ");
  grp1_d.setSelected(boolean(p[1]));
  if (boolean(p[1]))
    effect = 3;
  
  p = lines[11].split(" ");
  A.B.S.setValue(float(p[2]));
  
  p = lines[12].split(" ");
  A.B.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[13].split(" ");
  A.C.S.setValue(float(p[2]));
  
  p = lines[14].split(" ");
  A.C.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[15].split(" ");
  AA.B.S.setValue(float(p[2]));
  
  p = lines[16].split(" ");
  AA.B.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[17].split(" ");
  AA.C.S.setValue(float(p[2]));
  
  p = lines[18].split(" ");
  AA.C.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[19].split(" ");
  AAA.B.S.setValue(float(p[2]));
  
  p = lines[20].split(" ");
  AAA.B.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[21].split(" ");
  AAA.C.S.setValue(float(p[2]));
  
  p = lines[22].split(" ");
  AAA.C.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[23].split(" ");
  AAAA.B.S.setValue(float(p[2]));
  
  p = lines[24].split(" ");
  AAAA.B.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[25].split(" ");
  AAAA.C.S.setValue(float(p[2]));
  
  p = lines[26].split(" ");
  AAAA.C.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[27].split(" ");
  AAAAA.B.S.setValue(float(p[2]));
  
  p = lines[28].split(" ");
  AAAAA.B.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[29].split(" ");
  AAAAA.C.S.setValue(float(p[2]));
  
  p = lines[30].split(" ");
  AAAAA.C.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[31].split(" ");
  AAAAAA.B.S.setValue(float(p[2]));
  
  p = lines[32].split(" ");
  AAAAAA.B.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
  
  p = lines[33].split(" ");
  AAAAAA.C.S.setValue(float(p[2]));
  
  p = lines[34].split(" ");
  AAAAAA.C.setcolor(color(int(p[2]), int(p[3]), int(p[4])));
}
