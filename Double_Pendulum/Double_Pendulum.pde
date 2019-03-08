// Double Pendulum tool to accompany work on Lagrangian Mechanics
// Enter values for various setups you wish to see by modifying the variables below

int Length1 = 1;
float Mass1 = 0.05;
float Theta1 = PI/2;

int Length2 = 1;
float Mass2 = 0.05;
float Theta2 = 4 * PI/6;

float Omega1 = 0;
float Omega2 = 0;
float Omega_dot1 = 0;
float Omega_dot2 = 0;
float g = 1;
float cx, cy;
float px2, py2;

//float t10 = Theta1;
//float t20 = Theta2;

PGraphics canvas;

void setup() {
  size(1000,1000);
  cx = width/2;
  cy = height/2;
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw() {
  background(255);
  imageMode(CORNER);
  image(canvas, 0, 0, width, height);
  
  for (int i = 0; i < 10000; i = i+1) {
 
    Omega_dot2 = (g * ((sin(Theta1) * cos(Theta1 - Theta2) - sin(Theta2)) / Length2) + (Length1 * Omega1 * Omega1 * sin(Theta1 - Theta2) / Length2) + (Mass2 * Omega2 * Omega2 * sin(2 * Theta1 - 2 * Theta2))/(2 * (Mass1 + Mass2)))/(1 - (Mass2 * cos(Theta1 - Theta2) * cos(Theta1 - Theta2))/(Mass1 + Mass2));
    Omega_dot1 = -(Mass2 * Length2 * cos(Theta1 - Theta2) * Omega_dot2 /(Length1 * (Mass1 + Mass2))) - g * sin(Theta1) / Length1 - Mass2 * Length2 * sin(Theta1 - Theta2) * Omega2 * Omega2 / (Length1 * (Mass1 + Mass2));


  
    //Omega1 *= 0.999;
    //Omega2 *= 0.999;
  
    Omega1 += 0.00001 * Omega_dot1;
    Omega2 += 0.00001 * Omega_dot2;
    Theta1 += 0.00001 * Omega1;
    Theta2 += 0.00001 * Omega2;
    
    if (Theta1 < -2 * PI) {
      Theta1 += 2 * PI;
    }
    if (Theta2 < -2 * PI) {
      Theta2 += 2 * PI;
    }
    if (Theta1 > 2 * PI) {
      Theta1 -= 2 * PI;
    }
    if (Theta2 > 2 * PI) {
      Theta2 -= 2 * PI;
    }
  }
  
  translate(cx, cy);
  stroke(0);
  strokeWeight(2);
  
  float x1 = 100 * Length1 * sin(Theta1);
  float y1 = 100 * Length1 * cos(Theta1);

  float x2 = x1 + 100 * Length2 * sin(Theta2);
  float y2 = y1 + 100 * Length2 * cos(Theta2);
  
  //float x10 = 100 * Length1 * sin(t10);
  //float y10 = 100 * Length1 * cos(t10);

  //float x20 = x10 + 100 * Length2 * sin(t20);
  //float y20 = y10 + 100 * Length2 * cos(t20);
  
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, 200 * Mass1, 200 * Mass1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, 200 * Mass2, 200 * Mass2);
  
  //line(0, 0, x10, y10);
  //fill(0);
  //ellipse(x10, y10, 200 * Mass1, 200 * Mass1);

  //line(x10, y10, x20, y20);
  //fill(0);
  //ellipse(x20, y20, 200 * Mass2, 200 * Mass2);
  
   canvas.beginDraw();
  canvas.translate(cx, cy);
  canvas.stroke(0);
  if (frameCount > 1) {
    canvas.line(px2, py2, x2, y2);
  }  
  canvas.endDraw();


  px2 = x2;
  py2 = y2;
}
