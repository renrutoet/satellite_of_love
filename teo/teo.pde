import processing.pdf.*;

//array to store table data
Table[] tables;
//array to store mapped people nos
float [] peopleNums = new float[364];
//array to store circular positions -- Daily Data
PVector[] pos;
//array to store avg people nos -- Weekly Data
PVector [] peopleAvg;

//---------------------Lerping variables-------------------------------------
//array to store lerping values and used for drawing
PVector [] weeklyLerpArr;
PVector[] dailyLerpArr;
float year1Circle;
float year2Circle;
float lerpSize;
float i;
int j;
boolean fullReset;
boolean lerp;
//---------------------End of Lerping variables-------------------------------------

float maxIndex;
int currentYear;

//array of yearly avgs 
int [] yrAvg = {24583, 22710, 20100, 17253, 15426};

float year1Min;
float year1Max;
ArrayList<Integer> maxArr = new ArrayList<Integer>();

//year
PVector[] year1Weekly, year1Daily, year2Daily, year2Weekly;
PVector[][] weeklyArr, dailyArr;

int val, interval, interval2, cx, cy, tab;
float peopleNo, mapVal, min, max, angle, angle2, avgpeopleno, cSize, avg;

color [] colours = {#BF809F, #2A3F59, #66C6E3, #FFFFFF, #000000};


void setup() {

  size(displayWidth,displayHeight,P3D);
  background(255);
  frameRate(60);

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

  pos = new PVector[364]; // Daily Data Array -- PVector
  peopleAvg = new PVector[52]; // Weekly Data Array -- PVector
  
  weeklyLerpArr = new PVector[52]; // Array containing all of the lerped values between Weeks
  dailyLerpArr = new PVector[52]; // Array containing all of the lerped values between Days
  
  //function saves the daily and weekly data into the |pos| and |peopleAvg| arrays as PVectors.
  
  weeklyArr = new PVector[5][];
  dailyArr = new PVector[5][];
  
  
  //storing all table data in arrays
  for(int i = 0 ; i < tables.length ; i++){
    weeklyArr[i] = storeWeeklyData(tables[i]);
    dailyArr[i] = storeDailyData(tables[i],i);
  }
  
  i = 0.0;
  j = 0;
  
  currentYear = 0;
  printArray(maxArr);
}

void draw() {

    background(255);
    
    //fork ----are we transitioning from one year to the other or displaying a static image?
    
//-----------------------------------------------------

//if static run this code
    if(!lerp){
    if(fullReset){
     currentYear = 0;
     fullReset = false;
    }
    //uses weekly data
    //draw lines from weekly dots
    drawLines(weeklyArr[currentYear]);
    //draws weekly dots
    drawAvgPoints(weeklyArr[currentYear]);
    
    //draws daily dots
    drawDailyPoints(dailyArr[currentYear]);
    
    //draw line for largest day
    drawMaxLine(dailyArr[currentYear],currentYear);
    
    //draw average circle
    drawAvgCircle(getAvgCircle(currentYear));
    }
//-----------------------------------------------------
//if transition run this code
      else{
      //declare our start point and end point
      
      
      //println(currentYear);
      if(currentYear >= 4){
      //array of starting points
      weeklyLerpArr = lerpArr(weeklyArr[4],weeklyArr[0],i);
      
      //array of end point
      dailyLerpArr = lerpArr(dailyArr[4],dailyArr[0],i);
      fullReset=true;
      }
      else {
        //array of starting points
      weeklyLerpArr = lerpArr(weeklyArr[currentYear - 1],weeklyArr[currentYear],i);
      
      //array of end point
      dailyLerpArr = lerpArr(dailyArr[currentYear - 1],dailyArr[currentYear],i);
      }
      //printArray(weeklyLerpArr);
      
      //uses weekly data
      //draw lines from weekly dots
      drawLines(weeklyLerpArr);
      //draws weekly dots
      drawAvgPoints(weeklyLerpArr);
      
      //draw daily dots
      drawDailyPoints(dailyLerpArr);

      //draw line for largest day
      if(!fullReset){
      drawMaxLine(dailyLerpArr,currentYear);
      }
      else{
      drawMaxLine(dailyLerpArr,0);
      }
      
//-------- Drawing Avg circle ------------------------------------
      //getting circle start and stop values
      if(!fullReset){
      year1Circle = getAvgCircle(currentYear - 1);
      year2Circle = getAvgCircle(currentYear);
      }
      else{
      year1Circle = getAvgCircle(4);
      year2Circle = getAvgCircle(0);
      }
      //calculate the circles lerp values
      lerpSize = lerp(year1Circle,year2Circle,i);
      
      //draws the circle
      drawAvgCircle(lerpSize);
//-------- end of circle ------------------------------------------

      //incrementing lerp values
      j++;
      i += 1.0/120.0;
      
      //lerp interpolation value reset
      if(i >= 1){
       i = 0.0;
       lerp = false;
      }
      //weekly lerp step value reset
      if(j >= 52){
       j = 0;
      }
      
    }
} // end of draw

void mousePressed(){
  lerp = true;
  currentYear++;
  if(currentYear >= 5){
   currentYear = 1; 
  }
}
