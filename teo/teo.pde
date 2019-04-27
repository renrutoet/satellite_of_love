import processing.pdf.*;

//array to store table data
Table[] tables;
//array to store mapped people nos
float [] peopleNums = new float[364];
//array to store circular positions 
PVector[] pos;
//array to store avg people nos
PVector [] peopleAvg;
//array of yearly avgs 
int [] yrAvg = {24583, 22710, 20100, 17253, 15426};

int val, interval, interval2, cx, cy, tab;
float peopleNo, mapVal, min, max, angle, angle2, avgpeopleno, cSize, avg;

color [] colours = {#BF809F, #2A3F59, #66C6E3, #FFFFFF, #000000};


void setup() {

  size(displayWidth, displayHeight);
  background(255);

  //change these to change the position it's drawn at
  cx = width/2;
  cy = height/2;
  //change this to change which table it uses
  tab = 0;
  //change this to change map value 
  mapVal = 500;
  interval = 0;
 interval2 = 0;

  //load the data
  tables = new Table[5];
  tables[0] = loadTable("2014.csv");
  tables[1] = loadTable("2015.csv");
  tables[2] = loadTable("2016.csv");
  tables[3] = loadTable("2017.csv");
  tables[4] = loadTable("2018.csv");

  pos = new PVector[364];
  peopleAvg = new PVector[52];

  
}

void draw() {

  //  drawLines();
  //  drawPoints(tab);
  //  drawAvgPoints();

  //  noLoop();



 // if (mousePressed) {

   // beginRecord(PDF, "img2" + frameCount + ".pdf");


   
    background(255);
    storeData(tab);
    drawLines();
    drawPoints(tab);
    drawAvgPoints();
    // noLoop();
    tab++;
  //}

  //endRecord();
   if (tab == 5) {
      tab = 0;
    }

}
