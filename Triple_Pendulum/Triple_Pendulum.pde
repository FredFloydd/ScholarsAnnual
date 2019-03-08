// Triple Pendulum tool to accompany work on Lagrangian Mechanics
// Enter values for various setups you wish to see by modifying the variables below

float Length1 = 1;
float Mass1 = 0.05;
float Theta1 = 9 * PI/18;

float Length2 = 1;
float Mass2 = 0.05;
float Theta2 = 9 * PI/18;

float Length3 = 1;
float Mass3 = 0.05;
float Theta3 = 9 * PI/18;

float Omega1 = 0;
float Omega2 = 0;
float Omega3 = 0;
float Omega_dot1 = 0;
float Omega_dot2 = 0;
float Omega_dot3 = 0;
float grav = 1;
float cx, cy;
float px3, py3;

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
  
  for (int I = 0; I < 100000; I = I+1) {
    
    float a = Length1 * (Mass1 + Mass2 + Mass3);
    float b = - grav * (Mass1 + Mass2 + Mass3) * sin(Theta1) - Length2 * (Mass2 + Mass3) * (Omega2 * Omega2 * sin(Theta1 - Theta2)) - Length3 * Mass3 * Omega3 * Omega3 * sin(Theta1 - Theta3);
    float c = - Length2 * (Mass2 + Mass3) * cos(Theta1 - Theta2);
    float d = - Length3 * Mass3 * cos(Theta1 - Theta3);
    float e = Length2 * (Mass2 + Mass3);
    float f = - grav * (Mass2 + Mass3) * sin(Theta2) + Length1 * (Mass2 + Mass3) * Omega1 * Omega1 * sin(Theta1 - Theta2) - Length3 * Mass3 * Omega3 * Omega3 * sin(Theta2 - Theta3);
    float g = - Length1 * (Mass2 + Mass3) * cos(Theta1 - Theta2);
    float h = - Length3 * Mass3 * cos(Theta2 - Theta3);
    float i = Length3;
    float j = - grav * sin(Theta3) + Length1 * Omega1 * Omega1 * sin(Theta1 - Theta3) + Length2 * Omega2 * Omega2 * sin(Theta2 - Theta3);
    float k = - Length1 * cos(Theta1 - Theta3);
    float l = - Length2 * cos(Theta2 - Theta3);
    
    float lambda = a * (e * i - h * l) - c * (g * i + h * k) - d * (g * l + e * k);
    
    Omega_dot1 = b * (e * i - h * l) / (lambda) + f * (c * i + d * l) / (lambda) + j * (c * h + e * d) / (lambda);
    Omega_dot2 = b * (h * k + g * i) / (lambda) + f * (a * i - d * k) / (lambda) + j * (a * h + g * d) / (lambda);
    Omega_dot3 = b * (g * l + e * k) / (lambda) + f * (a * l + c * k) / (lambda) + j * (a * e - g * c) / (lambda);
  
    Omega1 += 0.000001 * Omega_dot1;
    Omega2 += 0.000001 * Omega_dot2;
    Omega3 += 0.000001 * Omega_dot3;
    Theta1 += 0.000001 * Omega1;
    Theta2 += 0.000001 * Omega2;
    Theta3 += 0.000001 * Omega3;
    
    if (Theta1 < -2 * PI) {
      Theta1 += 2 * PI;
    }
    if (Theta2 < -2 * PI) {
      Theta2 += 2 * PI;
    }
    if (Theta3 < -2 * PI) {
      Theta3 += 2 * PI;
    }
    if (Theta1 > 2 * PI) {
      Theta1 -= 2 * PI;
    }
    if (Theta2 > 2 * PI) {
      Theta2 -= 2 * PI;
    }
    if (Theta3 > 2 * PI) {
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
  
  float x3 = x2 + 100 * Length3 * sin(Theta3);
  float y3 = y2 + 100 * Length3 * cos(Theta3);
  
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, 100 * Mass1, 100 * Mass1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, 100 * Mass2, 100 * Mass2);
  
  line(x2, y2, x3, y3);
  fill(0);
  ellipse(x3, y3, 100 * Mass3, 100 * Mass3);
    
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
}
