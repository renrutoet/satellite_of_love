//this draws all of the DAILY points - stored in pvector array - pos 
void drawDailyPoints(PVector[] arr) {
  
  
  for (int l = 0; l < arr.length-1; l++) {

    //set size of dot
    cSize = map(peopleNums[l], 0, 50000, 0, mapVal);
    cSize = constrain(cSize, 5, 50);


    //stroke(0); --maybe delete
    
    fill(0);
    /*
    if (peopleNums[l] == min) {
      fill(0);
    }
    if (peopleNums[l] == max) {
      fill(0);
      cSize = 15;
      //draws a line from the centre to the day with the max no of visitors
      stroke(0, 255);
      strokeWeight(3);
      line(width/2, height/2, pos[l].x, pos[l].y);
    }
    */

    //draws an ellipse at each point depending on people no
    noStroke();
    fill(0);
    ellipse(arr[l].x, arr[l].y, cSize, cSize);
  }
}


//this draws all of the average points - stored in pvector array peopleAvg - IGNORE peopleNums, leave that the same that just determines the size of the ellipses drawn, which should stay the same 
//Draws weekly data points
void drawAvgPoints(PVector[] arr) {
  fill(0);
  for (int i = 0; i < arr.length; i++) {
    ellipse(arr[i].x, arr[i].y, peopleNums[i]/30, peopleNums[i]/30);
  }
}

void drawAvgCircle(int year){
  //draw Circle showing average people for the whole year
  avg = map(yrAvg[year], 0, 50000, 0, 500);
  //NEED TO MAP THE AVERAGE
  noFill();
  stroke(0, 255);
  strokeWeight(3);
  ellipse(width/2, height/2, avg, avg);
}


//this draws lines uptowards to points
void drawLines(PVector[] arrToDraw) {

  stroke(0, 50);

  strokeWeight(0.5);

  for (int m = 0; m < peopleAvg.length-1; m++) {
    for (int p = 0; p < peopleAvg.length; p++) {
      line(arrToDraw[m].x, arrToDraw[m].y, arrToDraw[p].x, arrToDraw[p].y);
    }
  }
}
