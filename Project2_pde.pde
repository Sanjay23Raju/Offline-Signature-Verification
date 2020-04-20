PImage img; 
//size(2112,944);
size(2971,1004);
img = loadImage("ss.jpg");
image(img,0,0);
loadPixels(); 
img.loadPixels();

PImage img1;  
img1 = loadImage("ss1.jpg");
image(img1,img.width,0);
//img.resize(500,500);
loadPixels(); 
img1.loadPixels();  

 
 
float[][] filterx = {{ -1,  0, 1 }, 
                     { -2, 0, 2 },          //vertical
                     { -1,  0, 1 }};
                    
float[][] filtery = {{ -1,  -2, -1 }, 
                     { 0, 0, 0 },           //horizontal
                     { 1,  2, 1 }};
           
  float sum = 0;
  float magp = 0;
  float magq = 0;
  float sim = 0;
  int a,b;
  float gradient = 0; 
  float angle = 0;
 
 //float [][] m1 = new float [img.width * img.height][4];
 float [][] m1 = new float [81][8];
 float [][] m2 = new float [81][8];
 
for (int y = 1; y < img.height-1; y++)             //to avoid missing of columns and rows
  for (int x = 1; x < img.width-1; x++) {
    
    float responsex = 0;
    float responsey = 0;
    
     
    for (int ky = -1; ky <= 1; ky++)                //move the filter inside the image
      for (int kx = -1; kx <= 1; kx++)
      {
        int index = (y + ky) * img.width + (x + kx);  //reading the pixels from the image to an array
         //float re = red (img.pixels[index]);
         //float gr = green(img.pixels[index]);
         //float bl = blue(img.pixels[index]);      
         //pixels[index] =  color(0.21*re + 0.72*gr + 0.07*bl);
         //pixels[index] =  color(re, 0, 0);
        
        float r = brightness(img.pixels[index]);    //reading the intensity of the image
        //float s = 255 - r;
        //pixels[index] =  color(s);
        
        responsex += filterx[ky+1][kx+1] * r;         //to calculate gradient values
        responsey += filtery[ky+1][kx+1] * r;
      }
        gradient = abs(responsex) + abs(responsey);
        //if (responsex != 0)
        //angle = atan(responsey/responsex);
        //println(responsex);
        
    //to know in which quadrant the gradient 
        if (responsex > 0)
        angle = atan(responsey/responsex);
        else if (responsex < 0)
        angle = atan(responsey/responsex) + PI;
        else if (responsey > 0)
        angle = HALF_PI;
        else if (responsey < 0)
        angle = -HALF_PI;
        else angle = 0;
        
        //pixels[y*width + x] = color(gradient);
  
  
  float e0 = 0, e1 = 0, e2 = 0, e3 = 0, e4 = 0, e5 = 0, e6 = 0, e7 = 0;
  
  if (angle >= 0 && angle < PI/4){
  e0 = gradient;
  e1=0; e2=0; e3=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= PI/4 && angle < HALF_PI){
  e1 = gradient;
  e0=0; e2=0; e3=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= HALF_PI && angle < (3*PI/4)){
  e2 = gradient;
  e0=0; e1=0; e3=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= (3*PI/4)  && angle < PI){
  e3 = gradient;
  e0=0; e1=0; e2=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= PI  && angle < (5*PI/4)){
  e4 = gradient;
  e0=0; e1=0; e2=0; e3=0; e5=0; e6=0; e7=0;}
  
  if (angle >= (5*PI/4)  && angle < (3*PI/2)){
  e5 = gradient;
  e0=0; e1=0; e2=0; e4=0; e3=0; e6=0; e7=0;}
  
  if (angle >= (3*PI/2)  && angle < (7*PI/4)){
  e6 = gradient;
  e0=0; e1=0; e2=0; e4=0; e5=0; e3=0; e7=0;}
  
  if (angle >= (7*PI/4)  && angle < TWO_PI){
  e7 = gradient;
  e0=0; e1=0; e2=0; e4=0; e5=0; e6=0; e3=0;}
  
  //int index = 0;
  int index2 = 0;
  
  //int x1 = 0, y1 = 0;
   //y1 = index / width;
   //x1 = index % width;
  
      //m1[index][0] = e0;
      //m1[index][1] = e1;
      //m1[index][2] = e2;
      //m1[index][3] = e3;
      
      int p,q;
   
      p = (9 * x) / img.width;
      q = (9 * y) / img.height;
      index2 = q * 9 + p;             
     
   
  
  //for(index = 0; index < width*height-1; index++){
   
  m1[index2][0] += e0;
  m1[index2][1] += e1;
  m1[index2][2] += e2;
  m1[index2][3] += e3;
  m1[index2][4] += e4;
  m1[index2][5] += e5;
  m1[index2][6] += e6;
  m1[index2][7] += e7;
  
  
  //print(gradient,angle);
  
  }


for (int y = 1; y < img1.height-1; y++)
  for (int x = 1; x < img1.width-1; x++) {
    
    float responsex = 0;
    float responsey = 0;
    
     
    for (int ky = -1; ky <= 1; ky++) 
      for (int kx = -1; kx <= 1; kx++)
      {
        int index = (y + ky) * img1.width + (x + kx);
        //float re = red (img.pixels[index]);                    //GrayScaling
         //float gr = green(img.pixels[index]);                  //GrayScaling
         //float bl = blue(img.pixels[index]);                   //GrayScaling
         //pixels[index] =  color(0.21*re + 0.72*gr + 0.07*bl);  //GrayScaling
         //pixels[index] =  color(re, 0, 0);                     //RedChannel
        
        float r = brightness(img1.pixels[index]);
        //float s = 255 - r;                                     //Negative
        //pixels[index] =  color(s);                             //Negative
        
        responsex += filterx[ky+1][kx+1] * r;
        responsey += filtery[ky+1][kx+1] * r;
      }
        gradient = abs(responsex) + abs(responsey);
        //if (responsex != 0)
        //angle = atan(responsey/responsex);
        //println(responsex);
        
        if (responsex > 0)
        angle = atan(responsey/responsex);
        else if (responsex < 0)
        angle = atan(responsey/responsex) + PI;
        else if (responsey > 0)
        angle = HALF_PI;
        else if (responsey < 0)
        angle = -HALF_PI;
        else angle = 0;
        
        //pixels[y*width + x] = color(gradient);
  
  
float e0 = 0, e1 = 0, e2 = 0, e3 = 0, e4 = 0, e5 = 0, e6 = 0, e7 = 0;
  
  if (angle >= 0 && angle < PI/4){
  e0 = gradient;
  e1=0; e2=0; e3=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= PI/4 && angle < HALF_PI){
  e1 = gradient;
  e0=0; e2=0; e3=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= HALF_PI && angle < (3*PI/4)){
  e2 = gradient;
  e0=0; e1=0; e3=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= (3*PI/4)  && angle < PI){
  e3 = gradient;
  e0=0; e1=0; e2=0; e4=0; e5=0; e6=0; e7=0;}
  
  if (angle >= PI  && angle < (5*PI/4)){
  e4 = gradient;
  e0=0; e1=0; e2=0; e3=0; e5=0; e6=0; e7=0;}
  
  if (angle >= (5*PI/4)  && angle < (3*PI/2)){
  e5 = gradient;
  e0=0; e1=0; e2=0; e4=0; e3=0; e6=0; e7=0;}
  
  if (angle >= (3*PI/2)  && angle < (7*PI/4)){
  e6 = gradient;
  e0=0; e1=0; e2=0; e4=0; e5=0; e3=0; e7=0;}
  
  if (angle >= (7*PI/4)  && angle < TWO_PI){
  e7 = gradient;
  e0=0; e1=0; e2=0; e4=0; e5=0; e6=0; e3=0;}
  
  
  //int index = 0;
  int index2 = 0;
  
  //int x1 = 0, y1 = 0;
   //y1 = index / width;
   //x1 = index % width;
  
      //m1[index][0] = e0;
      //m1[index][1] = e1;
      //m1[index][2] = e2;
      //m1[index][3] = e3;
      
      int p,q;
   
      p = (9 * x) / img1.width;
      q = (9 * y) / img1.height;
      
      index2 = q * 9 + p;
     
   
  
  //for(index = 0; index < width*height-1; index++){
   
  m2[index2][0] += e0;
  m2[index2][1] += e1;
  m2[index2][2] += e2;
  m2[index2][3] += e3;
  m2[index2][4] += e4;
  m2[index2][5] += e5;
  m2[index2][6] += e6;
  m2[index2][7] += e7;
  
  //print(gradient,angle);
  
  }
  
  for(a = 0 ; a < 81 ; a++)
  for(b = 0 ; b < 8 ; b++)
  {
    sum  += m1[a][b] * m2[a][b];
    magp += m1[a][b] * m1[a][b];
    magq += m2[a][b] * m2[a][b];
  }
  
    sim = (sum) / sqrt(magp * magq);
    print("Cosine Similarity of P and Q", sim);
    
updatePixels();
//save("ss-r.jpg");
