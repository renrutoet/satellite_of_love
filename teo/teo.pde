import processing.pdf.*;

//array to store table data
Table[] tables;
//array to store mapped people nos
float [] peopleNums = new float[364];
//array to store circular positions -- Daily Data
PVector[] pos;
//array to store avg people nos -- Weekly Data
PVector [] peopleAvg;
//array to store lerping values and used for drawing
PVector [] lerpArr;
PVector[] lerpArr2;
//array of yearly avgs 
int [] yrAvg = {24583, 22710, 20100, 17253, 15426};

float i;
int j;

//year
PVector[] year1Weekly, year1Daily, year2Daily, year2Weekly;

int val, interval, interval2, cx, cy, tab;
float peopleNo, mapVal, min, max, angle, angle2, avgpeopleno, cSize, avg;

color [] colours = {#BF809F, #2A3F59, #66C6E3, #FFFFFF, #000000};


void setup() {

  size(750,750);
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
  
  //min = min(peopleNums);
  //max=max(peopleNums);

  pos = new PVector[364]; // Daily Data Array -- PVector
  peopleAvg = new PVector[52]; // Weekly Data Array -- PVector
  lerpArr = new PVector[52]; // Array containing all of the lerped values between Weeks
  lerpArr2 = new PVector[52]; // Array containing all of the lerped values between Days
  
  //function saves the daily and weekly data into the |pos| and |peopleAvg| arrays as PVectors.
  year1Weekly = storeWeeklyData(tables[0]);
  year1Daily = storeDailyData(tables[0]);
  year2Weekly = storeWeeklyData(tables[1]);
  year2Daily = storeDailyData(tables[1]);
  
  i = 0.0;
  j = 0;
  
}

/*
  drawing functions
  
  drawlines() -- PVector[]
  drawDailyPoints() -- PVector[]
  drawAvgPoints() -- PVector[]
  drawAvgCircle() -- int
*/

void draw() {
  
    background(255);
    if(i > 1){
     i = 0.0; 
    }
    if(j >= 52){
     j = 0; 
    }
    
    lerpArr = lerpArr(year1Weekly,year2Weekly,j,i);
    lerpArr2 = lerpArr(year1Daily,year2Daily,j,i);

    //rendering functions
    //draw lines between weekly data points
    if(mousePressed){
    /*
    drawLines(year2Weekly);
    //draws daily dots
    drawDailyPoints(year2Daily);
    //draws weekly dots
    drawAvgPoints(year2Weekly);
    //draw average circle
    drawAvgCircle(1);
    */
    
    drawLines(lerpArr);
    
    drawDailyPoints(lerpArr2);
    
    //draws weekly dots
    drawAvgPoints(lerpArr);
    
    //println(i);
    //println(j);
    
    }
    else{
    drawLines(year1Weekly);
    //draws daily dots
    drawDailyPoints(year1Daily);
    //draws weekly dots
    drawAvgPoints(year1Weekly);
    //draw average circle
    drawAvgCircle(0);
    }
    j++;
    i += 1.0/50.0;
}
