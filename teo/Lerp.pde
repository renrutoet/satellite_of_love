PVector[] lerpArr(PVector[] arr,PVector[] arr2, float i){
  
    PVector[] tempArr = new PVector[arr.length];

    //fill tempArr with lerp values for each index of both arrays before returning the temp array

    for(int n = 0; n < tempArr.length; n++) {
       PVector newPos = new PVector();

      newPos.x = lerp(arr[n].x,arr2[n].x,i);
      newPos.y = lerp(arr[n].y,arr2[n].y,i);
      //println(n);
      //println(newPos.x);
      tempArr[n] = newPos;
      //printArray(tempArr);
    }

  return tempArr;
}
