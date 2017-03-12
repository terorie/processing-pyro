/** terorie pyro 1.0 Beispiel: Pyrotechnik mit Partikeln
 * 
 * Anleitung:
 * 1. Variable auswählen
 *    1.1: Taste D: Decay
 *    1.2: Taste S: Explosionsgröße
 *    1.3: Taste P: Partikelgröße
 * 
 * @author Richie Patel  <terorie@alphakevin.club> */

Pyro pyro;
PFont std, bold;
int decay = 50;
int spread = 4;
int size = 1;
int mode = 0;

void setup() {
  size(640, 480, FX2D);
  noSmooth();
  std = createFont("Arial", 12);
  bold = createFont("Arial Bold", 12);
  
  pyro = new Pyro();
}

void draw() {
  background(0);
  pyro.draw();
  noStroke();
  fill(255, 255, 255, 50);
  rect(0, 0, 170, 65);
  fill(255);
  
  textFont(mode == 0 ? bold : std);
  text(String.format("D: Decay: %d", decay), 20, 20);
  textFont(mode == 1 ? bold : std);
  text(String.format("S: Explosionsgröße: %d", spread), 20, 35);
  textFont(mode == 2 ? bold : std);
  text(String.format("P: Partikelgröße: %d", size), 20, 50);
}

void keyPressed() {
  switch(key) {
  case 'd': 
  case 'D':
    mode = 0;
    break;
  case 's': 
  case 'S':
    mode = 1;
    break;
  case 'p': 
  case 'P':
    mode = 2;
  default:
    switch(mode) {
    case 0:
      switch(key) {
      case '1':
        decay = 10;   
        break;
      case '2': 
        decay = 50;   
        break;
      case '3': 
        decay = 100;  
        break;
      case '4': 
        decay = 250;  
        break;
      case '5': 
        decay = 750;  
        break;
      case '6': 
        decay = 1000; 
        break;
      }
      break;
    case 1:
      switch(key) {
      case '1':
        spread = 1;   
        break;
      case '2': 
        spread = 2;   
        break;
      case '3': 
        spread = 4;  
        break;
      case '4': 
        spread = 8;  
        break;
      case '5': 
        spread = 16;  
        break;
      case '6': 
        spread = 32; 
        break;
      }
      break;
    case 2:
      switch(key) {
      case '1':
        size = 1;   
        break;
      case '2': 
        size = 2;   
        break;
      case '3': 
        size = 3;  
        break;
      case '4': 
        size = 4;  
        break;
      case '5': 
        size = 5;  
        break;
      case '6': 
        size = 6; 
        break;
      }
      break;
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    pyro.addExplosion(mouseX, mouseY, 255, 0, 255, decay, size, spread);
  }
}