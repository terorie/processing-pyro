/** terorie pyro 1.0: Pyrotechnik mit Partikeln
 * 
 * Anleitung:
 * - Alle Schritte (1, 2, 3) müssen vorhanden sein
 * - Entweder 2.1 oder 2.2 oder 2.x … bei jedem schritt
 *
 * 1. Pyro definieren:
 *    1.1: Pyro pyro;
 *
 * 2. Pyro erstellen in setup()
 *    2.1: pyro = new Pyro();
 *    2.2: pyro = new Pyro({maximale gleichzeitige explosionen}, {partikel in jeder explosion});
 *
 * 3. Pyro zeichnen in draw()
 *    3.1: pyro.draw()
 *
 * 4. Explosionen erstellen
 *    4.1: pyro.addExplosion({x,y koordinaten}, {r,g,b farben});
 *    4.2: pyro.addExplosion({x,y koordinaten}, {r,g,b farben}, {dauer}, {partikelgröße}, {explosionsgröße});
 * 
 * @author Richie Patel  <terorie@alphakevin.club> */
public class Pyro {

  final Explodierer[] explodierer;
  final int partikel;
  int explodierPtr = 0;
  
  public Pyro() {
    this(10, 100);
  }

  public Pyro(int maxExplosionen, int partikel) {
    this.partikel = partikel;
    this.explodierer = new Explodierer[maxExplosionen];
    for(int i = 0; i < maxExplosionen; i++) {
      explodierer[i] = new Explodierer();
    }
  }

  public void draw() {
    for(Explodierer e : explodierer) {
      e.draw();
    }
  }

  public void addExplosion(int x, int y, int r, int g, int b) {
    addExplosion(x, y, r, g, b, 100, 1, 4);
  }
  
  public void addExplosion(int x, int y, int r, int g, int b, int decay, int size, int spread) {
    explodierer[explodierPtr].explode(x, y, r, g, b, decay, size, spread);
    explodierPtr = (explodierPtr + 1) % explodierer.length;
  }

  class Explodierer {
    int tick = -1;
    int decay = 0;
    int size = 0;
    int spread = 4;
    int r,g,b;
    // ersten 32bit X, letzten 32bit Y
    long[] particles = new long[partikel];

    void explode(int x, int y, int _r, int _g, int _b, int decay, int size, int spread) {
      if(decay == 0) decay = -1; // Division by zero
      r = _r; g = _g; b = _b;
      this.decay = this.tick = decay;
      this.size = size;
      this.spread = spread;
      for (int i = 0; i < particles.length; ++i) {
        particles[i] = (long) x<<32 | y & 0xFFFFFFFFL;
      }
    }

    void draw() {
      if (tick < 0) return;

      for (int i = 0; i < particles.length; ++i) {
        int x = (int) (particles[i] >> 32);
        int y = (int) particles[i];
        x += random(-spread, spread+1);
        y += random(-spread, spread+1);

        int alpha = tick * 255 / decay;
        stroke(r, g, b, alpha);
        strokeWeight(size);
        point(x, y);

        particles[i] = (long)x<<32 | y & 0xFFFFFFFFL;
      }
      tick--;
    }
  }
}