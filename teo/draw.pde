//this draws all of the DAILY points - stored in pvector array - pos 
void drawPoints(int tab) {
  for (int l = 0; l < pos.length-1; l++) {


    cSize = map(peopleNums[l], 0, 50000, 0, mapVal);

    cSize = constrain(cSize, 5, 50);


    stroke(0);
    //line(width/2,height/2,pos[l].x,pos[l].y);
    //noStroke();
    //noFill();
    fill(0);
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

    //draws an ellipse at each point depending on people no
    noStroke();
    // fill(colours[1]);
    //strokeWeight(2);

    fill(0);
    ellipse(pos[l].x, pos[l].y, cSize, cSize);
  }
}


//this draws all of the average points - stored in pvector array peopleAvg - IGNORE peopleNums, leave that the same that just determines the size of the ellipses drawn, which should stay the same 
void drawAvgPoints() {
  for (int i = 0; i < peopleAvg.length; i++) {
    //fill(colours[0]);
    ellipse(peopleAvg[i].x, peopleAvg[i].y, peopleNums[i]/30, peopleNums[i]/30);
  }

  avg = map(yrAvg[tab], 0, 50000, 0, 500);
  //NEED TO MAP THE AVERAGE
  noFill();
  stroke(0, 255);
  strokeWeight(3);
  ellipse(width/2, height/2, avg, avg);
}


//this draws lines uotwards to points
void drawLines() {

  for (int m = 0; m < peopleAvg.length; m++) {
    // line(width/2, height/2, peopleAvg[m].x, peopleAvg[m].y);
  }

  stroke(0, 50);

  strokeWeight(0.5);

  for (int m = 0; m < peopleAvg.length-1; m++) {
    for (int p = 0; p < peopleAvg.length; p++) {
      line(peopleAvg[m].x, peopleAvg[m].y, peopleAvg[p].x, peopleAvg[p].y);
    }
  }
}
