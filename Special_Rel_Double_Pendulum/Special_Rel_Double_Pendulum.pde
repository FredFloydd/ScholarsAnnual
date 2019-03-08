// Double Pendulum tool with special relitavistic corrections to accompany work on Lagrangian Mechanics
// Enter values for various setups you wish to see by modifying the variables below

int Length1 = 1;
float Mass1 = 0.05;
float Theta1 = PI/2;

int Length2 = 1;
float Mass2 = 0.05;
float Theta2 = 4 * PI/6;

float c = 0.5;

float Omega1 = 0;
float Omega2 = 0;
float Omega_dot1 = 0;
float Omega_dot2 = 0;
float g = 1;
float cx, cy;
float px2, py2;

float relmass1, relmass2;

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
    
    float alpha = Theta1 - Theta2;
    float gamma = pow(1 - (Length1 * Length1 * Omega1 * Omega1)/(c * c), -0.5);
    float phi = pow(1 - (Length1 * Length1 * Omega1 * Omega1 + Length2 * Length2 * Omega2 * Omega2 + 2 * Length1 * Length2 * Omega1 * Omega2 * cos(alpha))/(c * c), -0.5);
    
    float A = Mass2 * Length2 * Length2 * pow(phi, 3) + Mass2 * Length2 * (Omega2 * Length2 + Omega1 * Length1 * cos(alpha)) * ((3 * Omega2 * Length2 * Length2 + 3 * Length1 * Length2 * Omega1 * cos(alpha))/(c * c)) * pow(phi, 5);
    float B = Mass2 * Length2 * Length1 * cos(alpha) * pow(phi, 3) + Mass2 * Length2 * (Omega2 * Length2 + Omega1 * Length1 * cos(alpha)) * ((3 * Omega1 * Length1 * Length1 + 3 * Length1 * Length2 * Omega2 * cos(alpha))/(c * c)) * pow(phi, 5);
    float C = - Mass2 * Length2 * Length1 * Omega1 * Omega1 * sin(alpha) * pow(phi, 3) + Mass2 * Length2 * (Omega2 * Length2 + Omega1 * Length1 * cos(alpha)) * ((3 * Length1 * Length2 * Omega1 * Omega2 * sin(alpha) * (Omega2 - Omega1))/(c * c)) * pow(phi, 5);
    float D = - g * Length2 * Mass2 * sin(Theta2);
    float E = - g * Length1 * sin(Theta1) * (Mass1 + Mass2);
    float F = Mass2 * Length1 * Length1 * pow(phi, 3) + Mass2 * Length1 * (Omega1 * Length1 + Omega2 * Length2 * cos(alpha)) * ((3 * Omega1 * Length1 * Length1 + 3 * Length1 * Length2 * Omega2 * cos(alpha))/(c * c)) * pow(phi, 5) + (3 * Mass1 * pow(Length1, 4) * Omega1 * Omega1 * pow(gamma, 5))/(c * c) + Mass1 * Length1 * Length1 * pow(gamma, 3);
    float G = Mass2 * Length2 * Length1 * cos(alpha) * pow(phi, 3) + Mass2 * Length1 * (Omega1 * Length1 + Omega2 * Length2 * cos(alpha)) * ((3 * Omega2 * Length2 * Length2 + 3 * Length1 * Length2 * Omega1 * cos(alpha))/(c * c)) * pow(phi, 5);
    float H = Mass2 * Length1 * Length2 * Omega2 * Omega2 * sin(alpha) * pow(phi, 3) + Mass2 * Length1 * (Omega1 * Length1 + Omega2 * Length2 * cos(alpha)) * ((3 * Length1 * Length2 * Omega1 * Omega2 * sin(alpha) * (Omega2 - Omega1))/(c * c)) * pow(phi, 5);
    
    Omega_dot1 = pow((F - (G * B)/(A)), -1) * (E - H - G * (D - C) / A);
    Omega_dot2 = (D - C - B * Omega_dot1) / A;
    
    Omega1 += 0.00001 * Omega_dot1;
    Omega2 += 0.00001 * Omega_dot2;
    Theta1 += 0.00001 * Omega1;
    Theta2 += 0.00001 * Omega2;
    
    relmass1 = Mass1 * gamma;
    relmass2 = Mass2 * phi;
    
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
  
  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, 200 * relmass1, 200 * relmass1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, 200 * relmass2, 200 * relmass2);
  
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
