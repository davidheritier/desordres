/**
 Programme créé pour le Master Media Design
 à l'occasion des portes ouvertes 2020 de la HEAD–Genève
 Génère un visuel inspiré par la série (Dés)Ordres de Vera Molnar
 Les paramètres d1, d2 et d3 sont définis par des lancers de dé (1-6)
 
 La touches espace génère des valeurs aléatoires pour d1 à d3
 La touche "s" sauvegarde un PDF de l'image
 Les touches 1, 2 et 3 incrémentent les valeurs d1 à d3
 **/

import processing.pdf.*;
boolean record;
PFont font;
int fSize = 16;

// Lancer 1: nombre de colonnes
int d1 = 1;

// Lancer 2: nombre de carrés concentriques
int d2 = 1;

// Lancer 3: intensité du déplacement des sommets
int d3 = 1;

void setup() {
  size(800, 800);
  colorMode(RGB, 1);

  font = createFont("SpaceMono-Regular.ttf", fSize);
  textFont(font);
}

void draw() {
  noFill();
  stroke(0);
  strokeWeight(1);
  background(1);

  // Nombre de colonnes et largeur de chaque case
  float size = width / d1;
  // Taille de l'espace blanc entre les carrés concentriques
  float gap = size / d2 * .5;
  // Intensité du déplacement aléatoire de chaque sommet 
  float r = size * map(d3, 1, 6, .01, .1);

  if (record) {
    beginRecord(PDF, "./PDF/desordres" + d1 + d2 + d3 + "-" + hour() + "h" + minute() + "m" + second() + "s" + ".pdf");
  }

  for (int y = 0; y < size * d1; y += size) {
    for (int x = 0; x < size * d1; x += size) {
      for (int i = 0; i < d2; i++) {
        // Valeur de déplacement des sommets du carré
        float j = i * gap;

        // Sommets du carré
        float x1 = x + j;
        float y1 = y + j;
        float x2 = x + size - j;
        float y2 = y + size - j;

        beginShape();
        vertex(x1 + random(r), y1 + random(r));
        vertex(x2 - random(r), y1 + random(r));
        vertex(x2 - random(r), y2 - random(r));
        vertex(x1 + random(r), y2 - random(r));
        endShape(CLOSE);
      }
    }
  }

  if (record) {
    endRecord();
    record = false;
  }

  fill(sin(frameCount * .001), sin(frameCount * .005), sin(frameCount * .007));
  textAlign(LEFT);
  text("(Dés)Ordres, Vera Molnár", fSize, fSize * 1.8);
  text("Espace: lance les dés", fSize, height - fSize);
  textAlign(RIGHT);
  text("S: sauvegarde l’image", width - fSize, height - fSize);
  text(d1 + " " + d2 + " " + d3, width - fSize, fSize * 1.8);
}

void keyPressed() {
  if (key == 115) {
    record = true;
  }

  if (key == 49 && d1 < 6) {
    d1++;
  } else if (key == 49 && d1 >= 6) {
    d1 = 1;
  }

  if (key == 50 && d2 < 6) {
    d2++;
  } else if (key == 50 && d2 >= 6) {
    d2 = 1;
  }

  if (key == 51 && d3 < 6) {
    d3++;
  } else if (key == 51 && d3 >= 6) {
    d3 = 1;
  }

  if (key == 32) {
    d1 = round(random(1, 6));
    d2 = round(random(1, 6));
    d3 = round(random(1, 6));
  }
}
