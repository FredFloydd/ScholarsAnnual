float Theta =  2 * PI / 4;
float r = 1;
float g = 9.81;
float m_0 = 10;

float c = 4;

float Omega = 0;
float Omega_dot = 0;
float Omega2 = 0;
float Omega_dot2 = 0;
float Theta2 = Theta;
float mass;

float cx, cy;

PGraphics canvas;

void setup() {
  size(300,300);
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
    
    float gamma = 1 - (r * r * Omega * Omega / (c * c));
    
    float num = - g * sin(Theta) / r;
    float den = pow(gamma, -1.5) + 3 * r * r * Omega * Omega * pow(gamma, -2.5) / (c * c);
    
    Omega_dot = num / den;
    Omega_dot2 = - g * sin(Theta2) / r;
    
    Omega *= 1;
  
    Omega += 0.000001 * Omega_dot;
    Theta += 0.000001 * Omega;
    Omega2 += 0.000001 * Omega_dot2;
    Theta2 += 0.000001 * Omega2;
    
    mass = pow(gamma, -.5) * m_0; 
  }
  
  translate(cx, cy);
  stroke(0);
  strokeWeight(2);
  
  float x = 100 * r * sin(Theta);
  float y = 100 * r * cos(Theta);
  
  line(0, 0, x, y);
  fill(0);
  ellipse(x, y, mass, mass);
  
  float x2 = 100 * r * sin(Theta2);
  float y2 = 100 * r * cos(Theta2);
  
  line(0, 0, x2, y2);
  fill(0);
  ellipse(x2, y2, m_0, m_0);
}
