color purple = color(162,24,170);
color white = color(255,255,255);
color green = color(45,245,0);

void displayPlot(ArrayList<Integer> points, float wid, float hit, color c) {
   stroke(c);
   for (int i = points.size() - 1; i >= 0; i--) {
     float xLocation = wid - (points.size() - i);
     float yValue = map(points.get(i), 0, totalPeople, 0, hit);
     point(xLocation, yValue);
   }
   
}



void displayPlotQ(ArrayList<Float> points, float wid, float hit, color c) {
   stroke(c);
   for (int i = points.size() - 1; i >= 0; i--) {
     float xLocation = wid - (points.size() - i);
     float yValue = map(points.get(i), 0, totalPeople, 0, hit);
     point(xLocation, yValue);
   }
   
}
