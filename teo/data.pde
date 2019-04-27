/*
This page of code currently saves all processed weekly/daily data from the CSV files into arrays.

--- First Step ---
Get values from CSV file and then store the int.

--- Second Step ---
Find the angle of the circle for the dot to be drawn at.

*/

PVector[] storeWeeklyData(Table year) {
  
  PVector[] tempArr = new PVector[52];
  
  interval2=0;
  //for the number of rows
  for (int rows = 0; rows < 52; rows++) {
    //get the value 
    val = year.getInt(rows, 7);
    //calculate the angles for the number of values (365)
    angle2 = map(interval2, 0, 52, 0, TWO_PI) - HALF_PI;
    //map the value to one we can use 
    avgpeopleno = map(val, 0, 50000, 0, mapVal);
// --------------------------------------------------------------------------------------------------------------------------
    //weekly data
    //fill peopleAvg array
    for (int n = peopleAvg.length-1; n > 0; n--) {
      //shift array up by one
      tempArr[n] = tempArr[n-1];
      tempArr[0] =new PVector (cx + cos(angle2)*avgpeopleno, cy + sin(angle2)*avgpeopleno);
    }
//---------------------------------------------------------------------------------------------------------------------------
    interval2++;
  }
  return tempArr;
}
//------------------------------------------------End of Weekly Data---------------------------------------------------------
  
//---------------------------------------------------------------------------------------------------------------------------
  //daily data handling
  
 PVector[] storeDailyData(Table year){
   interval = 0;
   
   PVector[] tempArr = new PVector[364];
   
  for (int rows = 0; rows < 52; rows++) {
  //and for the number of columns
  for (int cols = 0; cols < 7; cols++) {

    //get the value 
    val = year.getInt(rows, cols);

    //map the value to one we can use 
    peopleNo = map(val, 0, 50000, 0, mapVal);

    //store the mapped peopleNos in an array - we can use these for line length/circle size etc.
    for (int n = peopleNums.length-1; n > 0; n--) {
      peopleNums[n] = peopleNums[n-1];
      peopleNums[0] = peopleNo;
    }


    //calculate the angles for the number of values (365)
    angle = map(interval, 0, 365, 0, TWO_PI) - HALF_PI;

    //stores the position coordinates for the daily dots as Vectors
    for (int n = pos.length-1; n > 0; n--) {
      tempArr[n] = tempArr[n-1];
      tempArr[0] =new PVector (cx + cos(angle)*peopleNo, cy + sin(angle)*peopleNo);
    }

      interval++;
 
      }
    }
  return tempArr;
 }
