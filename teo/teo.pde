import processing.pdf.*;

PFont source;
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
PVector[] lastYearDaily;
float year1Circle;
float year2Circle;
float lerpSize;
float i;
boolean fullReset;
boolean lerp;
//---------------------End of Lerping variables-------------------------------------
PVector largestDay;
float maxIndex;
int currentYear;

//array of yearly avgs 
int [] yrAvg = {24583, 22710, 20100, 17253, 15426,7418};

float year1Min;
float year1Max;
ArrayList<Integer> maxArr = new ArrayList<Integer>();

//year
PVector[] year1Weekly, year1Daily, year2Daily, year2Weekly;
PVector[][] weeklyArr, dailyArr;

int val, interval, interval2, cx, cy, tab;
float peopleNo, mapVal, min, max, angle, angle2, avgpeopleno, cSize, avg;

color [] colours = {#BF809F, #2A3F59, #66C6E3, #FFFFFF, #000000};
String[] years = {"2014","2015","2016","2017","2018","2014"};

boolean pause;
int count;


void setup() {
  
  count = 0;
  pause = false;

  size(1000,1000,P3D);
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
  //tables[5] = loadTable("2019.csv");


  pos = new PVector[364]; // Daily Data Array -- PVector
  peopleAvg = new PVector[52]; // Weekly Data Array -- PVector
  lastYearDaily = new PVector[364];

  
  weeklyLerpArr = new PVector[52]; // Array containing all of the lerped values between Weeks
  dailyLerpArr = new PVector[52]; // Array containing all of the lerped values between Days
  //function saves the daily and weekly data into the |pos| and |peopleAvg| arrays as PVectors.
  
  weeklyArr = new PVector[tables.length][];
  dailyArr = new PVector[tables.length][];
  largestDay = new PVector();
  
  
  //storing all table data in arrays
  for(int i = 0 ; i < tables.length ; i++){
    weeklyArr[i] = storeWeeklyData(tables[i]);
    dailyArr[i] = storeDailyData(tables[i],i);
  }
  lerp = true;
  i = 0.0;
  currentYear = 1;
  
  
  source = createFont("SourceCodePro-Semibold.ttf" , 40);
  textSize(40);
  textAlign(CENTER);
  textFont(source);
}

void draw() {

    if(!pause){
    background(255);

//-----------------------------------------------------
    if(!lerp){
    
    //uses weekly data
    //draw lines from weekly dots
    drawLines(weeklyArr[currentYear]);
    //draws weekly dots
    drawAvgPoints(weeklyArr[currentYear]);
    
    //draws daily dots
    drawDailyPoints(dailyArr[currentYear]);
    
    //draw line for largest day
    largestDay = getLargestDay(dailyArr[currentYear],currentYear);
    float x = largestDay.x;
    float y = largestDay.y;
    drawMaxLine(x,y);
    
    //draw average circle
    drawAvgCircle(getAvgCircle(currentYear));
    }
//-----------------------------------------------------
      else{
      
      if(currentYear == 1){
        lastYearDaily = lerpArr(dailyArr[0],dailyArr[1],i);
      }

      if(currentYear == weeklyArr.length){
      weeklyLerpArr = lerpArr(weeklyArr[weeklyArr.length - 1],weeklyArr[0],i);
      dailyLerpArr = lerpArr(dailyArr[weeklyArr.length - 1],dailyArr[0],i);
      fullReset = true;
      }
      else {
        if(fullReset){
           currentYear = 1;
           fullReset = false;
        }
      weeklyLerpArr = lerpArr(weeklyArr[currentYear - 1],weeklyArr[currentYear],i);
      dailyLerpArr = lerpArr(dailyArr[currentYear - 1],dailyArr[currentYear],i);
      }

      //uses weekly data
      //draw lines from weekly dots
      drawLines(weeklyLerpArr);
      //draws weekly dots
      drawAvgPoints(weeklyLerpArr);
      
      //draw daily dots
      drawDailyPoints(dailyLerpArr);

//-----------Draw Max Line --------------------------------------
      //draw line for largest day
      if(!fullReset){
      PVector lastYear = getLargestDay(lastYearDaily,currentYear - 1);
      largestDay = getLargestDay(dailyLerpArr,currentYear);
      float x = largestDay.x;
      float y = largestDay.y;
      
      float temp = i;
      temp = abs(i - 0.5) * 2;
        if(i < 0.5){
            x = lastYear.x;
            y = lastYear.y;
            x = lerp(x,width/2,i * 2);
            y = lerp(y,height/2,i * 2);
            drawMaxLine(x,y);
        }
        else if(i >= 0.5){
            x = lerp(width/2,x,constrain(temp,0,1));
            y = lerp(height/2,y,constrain(temp,0,1));
            drawMaxLine(x,y);
          }
        }
      else{
      
      largestDay = getLargestDay(dailyLerpArr,0);
      float x = largestDay.x;
      float y = largestDay.y;
      x = lerp(width/2,x,i);
      y = lerp(height/2,y,i);
      drawMaxLine(x, y);
      }
      
      
//-------- Drawing Avg circle ------------------------------------
      //getting circle start and stop values
      if(!fullReset){
      year1Circle = getAvgCircle(currentYear - 1);
      year2Circle = getAvgCircle(currentYear);
      }
      else{
      year1Circle = getAvgCircle(weeklyArr.length);
      year2Circle = getAvgCircle(0);
      }
      //calculate the circles lerp values
      lerpSize = lerp(year1Circle,year2Circle,i);
      
      //draws the circle
      drawAvgCircle(lerpSize);
//-------- end of circle ------------------------------------------
//-------- Text ---------------------------------------------------

      text(years[currentYear],width/2,height - height/12);

      //incrementing lerp values
      i += 1.0/600.0;
      
      //lerp interpolation value reset
      if(i > 1){
       i = 0.0;
       //lerp = false;
       currentYear++;
       if(currentYear >= 6){
         currentYear = 1;
        }
        lastYearDaily = dailyLerpArr;
        pause = true;
      }
    }
    
    }
    else {
    count++;
      if(count >= 300){
        pause = false;
        count = 0;
      }
    }
} // end of draw

void mousePressed(){
  i = 0;
  lerp = true;
  currentYear++;
  if(currentYear >= 5){
   currentYear = 1; 
  }
}
