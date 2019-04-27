void storeData(int year) {
  interval2=0;
  //for the number of rows
  for (int rows = 0; rows < 52; rows++) {
    //get the value 
    val = tables[year].getInt(rows, 7);
    //calculate the angles for the number of values (365)
    angle2 = map(interval2, 0, 52, 0, TWO_PI) - HALF_PI;
    //map the value to one we can use 
    avgpeopleno = map(val, 0, 50000, 0, mapVal);
    for (int n = peopleAvg.length-1; n > 0; n--) {
      peopleAvg[n] = peopleAvg[n-1];
      peopleAvg[0] =new PVector (cx + cos(angle2)*avgpeopleno, cy + sin(angle2)*avgpeopleno);
    }
    interval2++;
  }
  interval=0;
  for (int rows = 0; rows < 52; rows++) {
  //and for the number of columns
  for (int cols = 0; cols < 7; cols++) {

    //get the value 
    val = tables[year].getInt(rows, cols);

    //map the value to one we can use 
    peopleNo = map(val, 0, 50000, 0, mapVal);

    //store the mapped peopleNos in an array - we can use these for line length/circle size etc.
    for (int n = peopleNums.length-1; n > 0; n--) {
      peopleNums[n] = peopleNums[n-1];
      peopleNums[0] = peopleNo;
    }


    //calculate the angles for the number of values (365)
    angle = map(interval, 0, 365, 0, TWO_PI) - HALF_PI;

    for (int n = pos.length-1; n > 0; n--) {
      pos[n] = pos[n-1];
      pos[0] =new PVector (cx + cos(angle)*peopleNo, cy + sin(angle)*peopleNo);
    }

      interval++;

  }
}
//find the minimum 
min = min(peopleNums);
max=max(peopleNums);

println(max);
}
