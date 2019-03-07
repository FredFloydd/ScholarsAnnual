// Triple Pendulum tool to accompany work on Lagrangian Mechanics
// Enter values for various setups you wish to see by modifying the variables below

int Length1 = 1;
float Mass1 = 1;
float Theta1 = 9 * PI/18;

int Length2 = 1;
float Mass2 = 1;
float Theta2 = 9 * PI/18;

int Length3 = 1;
float Mass3 = 1;
float Theta3 = 9 * PI/18;

float Omega1 = 0;
float Omega2 = 0;
float Omega3 = 0;
float Omega_dot1 = 0;
float Omega_dot2 = 0;
float Omega_dot3 = 0;
float g = 1;
float cx, cy;
float px3, py3;
float pacc1, pacc2, pacc3;

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
    
    float num1 = -g * sin(Theta1) * (Mass1 + Mass2 + Mass3) - Length2 * (Mass2 + Mass3) * Omega2 * Omega2 * sin(Theta1 - Theta2) - Omega3 * Omega3 * sin(Theta1 - Theta3);
    float num2 = -cos(Theta1 - Theta2) * (-g * sin(Theta2) * (Mass2 + Mass3) + Length1 * (Mass2 + Mass3) * Omega1 * Omega1 * sin(Theta1 - Theta3) - Length3 * Mass3 * Omega3 * Omega3 * sin(Theta2 - Theta3));
    float num3a = (-Length3 * Mass3 * cos(Theta1 - Theta3) + Length3 * Mass3 * cos(Theta1 - Theta2) * cos(Theta2 - Theta3)) / (Length3 - Length3 * Mass3 * cos(Theta2 - Theta3) * cos(Theta2 - Theta3) / (Mass2 + Mass3));
    float num3b = - g * sin(Theta3) + Length1 * Omega1 * Omega1 * sin(Theta1 - Theta3) + Length2 * Omega2 * Omega2 * sin(Theta2 - Theta3) - cos(Theta2 - Theta3) * (-g * sin(Theta2) + Length1 * Omega2 * Omega2 * sin(Theta1 - Theta2) - (Length3 * Mass3 * Omega3 * Omega3 * sin(Theta2 - Theta3) / (Mass2 + Mass3)));
    float num3 = num3a * num3b;
    float num = num1 + num2 + num3;
    float den1 = Length1 * (Mass1 + Mass2 + Mass3) - Length1 * (Mass2 + Mass3) * cos(Theta1 - Theta2) * cos(Theta1 - Theta2);
    float den2 = -(-Length1 * cos(Theta1 - Theta3) + Length1 * cos(Theta2 - Theta3) * cos(Theta1 - Theta2)) * (-Length3 * Mass3 * cos(Theta1 - Theta3) + Length3 * Mass3 * cos(Theta1 - Theta2) * cos(Theta2 - Theta3)) / (Length3 - Length3 * Mass3 * cos(Theta2 - Theta3) * cos(Theta2 - Theta3) / (Mass2 + Mass3));
    float den = den1 + den2;
  
    Omega_dot1 = num / den;
  
    num1 = - g * sin(Theta3) + Length1 * Omega1 * Omega1 * sin(Theta1 - Theta3) + Length2 * Omega2 * Omega2 * sin(Theta2 - Theta3);
    num2 = - cos(Theta2 - Theta3) * (-g * sin(Theta2) + Length1 * Omega1 * Omega1 * sin(Theta1 - Theta2) - (Length3 * Mass3 * Omega3 * Omega3 * sin(Theta2 - Theta3) / (Mass2 + Mass3)));
    num3 = Omega_dot1 * (-Length1 * cos(Theta1 - Theta3) + Length1 * cos(Theta2 - Theta3) * cos(Theta1 - Theta2));
    den = Length3 - (Length3 * Mass3 * cos(Theta2 - Theta3) * cos(Theta2 - Theta3) / (Mass2 + Mass3));
  
    Omega_dot3 = (num1 + num2 + num3) / den;
  
    num1 = -g * sin(Theta2) * (Mass2 + Mass3) ;
    num2 = - Length1 * (Mass2 + Mass3) * (Omega_dot1 * cos(Theta1 - Theta2) - Omega1 * Omega1 * sin(Theta1 - Theta2));
    num3 = - Length3 * Mass3 * (Omega_dot3 * cos(Theta2 - Theta3) + Omega3 * Omega3 * sin(Theta2 - Theta3));
    den = Length2 * (Mass2 + Mass3);
  
    Omega_dot2 = (num1 + num2 + num3) / den;

    //Omega1 *= 0.999;
    //Omega2 *= 0.999;
  
    Omega1 += 0.000001 * Omega_dot1;
    Omega2 += 0.000001 * Omega_dot2;
    Omega3 += 0.000001 * Omega_dot3;
    Theta1 += 0.000001 * Omega1;
    Theta2 += 0.000001 * Omega2;
    Theta3 += 0.000001 * Omega3;
  }
  
  translate(cx, cy);
  stroke(0);
  strokeWeight(2);
  
  float x1 = 100 * Length1 * sin(Theta1);
  float y1 = 100 * Length1 * cos(Theta1);

  float x2 = x1 + 100 * Length2 * sin(Theta2);
  float y2 = y1 + 100 * Length2 * cos(Theta2);
  
  float x3 = x2 + 100 * Length3 * sin(Theta3);
  float y3 = y2 + 100 * Length3 * cos(Theta3);
  
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, 10 * Mass1, 10 * Mass1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, 10 * Mass2, 10 * Mass2);
  
  line(x2, y2, x3, y3);
  fill(0);
  ellipse(x3, y3, 10 * Mass3, 10 * Mass3);
    
    canvas.beginDraw();
  //canvas.background(0, 1);
  canvas.translate(cx, cy);
  canvas.stroke(0);
  if (frameCount > 1) {
    canvas.line(px3, py3, x3, y3);
  }
  canvas.endDraw();


  px3 = x3;
  py3 = y3;
  
  pacc1 = Omega_dot1;
  pacc2 = Omega_dot2;
  pacc3 = Omega_dot3;
}
