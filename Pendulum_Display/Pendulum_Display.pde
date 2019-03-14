
int k = 0;
float cx, cy;
float array[][];
float masses[];
float scalefactor;
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
  
  translate(cx, cy - 50);
  stroke(0);
  strokeWeight(2);
  
  
  if (frameCount < 2) {
    String[] lines = loadStrings("/AngleData.csv");

    float[][] numbers = new float[lines.length][];

    for(int i =0; i < lines.length; i++) {
      String[] tokens = splitTokens(lines[i], ",");
      numbers[i] = new float[tokens.length];
      for (int j=0; j < tokens.length; j++) {
        numbers[i][j] = float(tokens[j]);
        array = numbers;
      }  
    }
  }
  if (frameCount < 2) {
    String[] lines = loadStrings("/MassData.csv");

    float[] numbers = new float[lines.length];

    for(int i =0; i < lines.length; i++) {
      numbers[i] = float(lines[i]);
      masses = numbers;
      scalefactor = 15 / max(masses);
      }  
    }
  float px = 0;
  float py = 0;
  for(int l =0; l < array[k].length; l++) {
    float x = px + (500 / array[k].length) * sin(array[k][l]);
    float y = py + (500 / array[k].length) * cos(array[k][l]);
    line(px, py, x, y);
    fill(0);
    ellipse(x, y, scalefactor * masses[l], scalefactor * masses[l]);
    px = x;
    py = y;
  }
  k += 1;
  saveFrame("frame-#####.png");
}
