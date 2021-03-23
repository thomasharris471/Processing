class tVector {
  float x;
  float y;
  
  tVector(float xp, float yp) {
    x = xp;
    y = yp;
  }
  
  tVector(tVector v) {
    x = v.x;
    y = v.y;
  }
  
}

class tMatrix {
  
  tVector row1;
  tVector row2;
  
  tVector column1;
  tVector column2;
  
  tMatrix(float a11p, float a12p, float a21p, float a22p) {
    row1 = new tVector(a11p,a12p);
    row2 = new tVector(a21p, a22p);
    
    column1 = new tVector(row1.x, row2.x);
    column2 = new tVector(row1.y, row2.y);
  }
  
  tMatrix(tVector r1, tVector r2) {
    row1 = new tVector(r1);
    row2 = new tVector(r2);
    column1 = new tVector(row1.x, row2.x);
    column2 = new tVector(row1.y, row2.y);
  }
  
  void printMatrix() {
    println("{{" + row1.x + "," +  row1.y + "},{" + row2.x + "," + row2.y +"}}");
  }
  
  
}

float angleFromTo(tVector from, tVector to) {
  tVector nFrom = normalize(from);
  tVector nTo = normalize(to);
  float theta =  acos(dotProduct(nFrom, nTo));
  if (to.y < 0) {
     theta = -theta;
  }
  return theta;
}

tVector add(tVector v1, tVector v2) {
  return new tVector(v1.x + v2.x, v1.y + v2.y); 
}

tVector subtract(tVector v1, tVector v2) {
  return add(v1, multiply(-1, v2));
}

float dotProduct(tVector v1, tVector v2) {
  return v1.x*v2.x + v1.y*v2.y; 
}

tVector multiply(tMatrix m, tVector v) {
  float x = dotProduct(m.row1, v);
  float y = dotProduct(m.row2, v);
  return new tVector(x,y);
}

tVector multiply(float c, tVector v) {
  return new tVector(c*v.x, c*v.y);
}

tMatrix transpose(tMatrix m) {
  return new tMatrix(m.row1.x, m.row2.x, m.row1.y, m.row2.y); 
}

tMatrix multiply(tMatrix m1, tMatrix m2) {  
  float a11 = dotProduct(m1.row1, m2.column1);
  float a12 = dotProduct(m1.row1, m2.column2);
  float a21 = dotProduct(m1.row2, m2.column1);
  float a22 = dotProduct(m1.row2, m2.column2);
  return new tMatrix(a11, a12, a21, a22);
}

tMatrix multiply(float c, tMatrix m) {
  return new tMatrix(multiply(c, m.row1), multiply(c, m.row2));
}

tMatrix add(tMatrix m1, tMatrix m2) {
  return new tMatrix(add(m1.row1 ,m2.row1), add(m1.row2 ,m2.row2) );
}

tMatrix identity() {
  return new tMatrix(1,0,0,1); 
}

tMatrix zeroMatrix() {
   return new tMatrix(0,0,0,0); 
}

tMatrix rotation(float t) {
  return new tMatrix(cos(t),-sin(t), sin(t), cos(t)); 
}

tMatrix xMirror() {
  return new tMatrix(1,0,0,-1); 
}

float determinant(tMatrix m) {
  return m.row1.x*m.row2.y - m.row1.y*m.row2.x; 
}

tMatrix add(tMatrix ... a) {
   tMatrix current = zeroMatrix();
   for (tMatrix m : a) {
     current = add(current, m);
   }
   return current;
}

tMatrix power(tMatrix m, int n) {
  tMatrix current = identity();
  for (int i = 0; i < n; i++) {
    current = multiply(current, m); 
  }
  return current;
}


tVector projection(tVector u, tVector a) {
  float numerator = dotProduct(u,a);
  float den = dotProduct(u,u);
  if (den == 0) {
    return multiply(0, u); 
  } else {
    return multiply(numerator/den, u);
  }
}

float norm(tVector u) {
  return sqrt(dotProduct(u,u));
}

tVector normalize(tVector u) {
  if (norm(u) == 0) {
    return multiply(0, u); 
  } else {
    return multiply((float)(1/norm(u)), u); 
  }
}

tMatrix QMatrix(tMatrix m) {
  tVector u1 = m.column1;
  tVector u2 = subtract(m.column2, projection(u1, m.column2));
  tVector nu1 = normalize(u1);
  tVector nu2 = normalize(u2);
  return transpose(new tMatrix(nu1, nu2));
}

tMatrix RMatrix(tMatrix m) {
  tVector u1 = m.column1;
  tVector u2 = subtract(m.column2, projection(u1, m.column2));
  tVector e1 = normalize(u1);
  tVector e2 = normalize(u2);
  float a11 = dotProduct(e1, m.column1);
  float a12 = dotProduct(e1, m.column2);
  float a21 = 0;
  float a22 = dotProduct(e2, m.column2);
  return new tMatrix(a11, a12, a21, a22);
}

class DecomposedMatrix {

  tMatrix r;
  tMatrix q;
  float rotationAngle;
  
  DecomposedMatrix(tMatrix m) {
    r = RMatrix(m);
    q = QMatrix(m);
    tVector e1 = new tVector(1,0);
    rotationAngle = angleFromTo(e1, multiply(q,e1));
    if (determinant(q) < 0) {
      r = multiply(xMirror(), r);
      q = multiply( q, xMirror());
    } 
  }
  
  tMatrix interpolatedR(float t) {
     tMatrix rTerm = multiply(interpolationFunction(t), r);
     tMatrix iTerm = multiply(1-interpolationFunction(t), identity());
     return add(rTerm, iTerm);
   }
   
   tMatrix interpolatedQ(float t) {
     return rotation(rotationAngle*interpolationFunction(t));
   }
   
   tMatrix interpolate(float t) {
     if (t < 0) {
       return identity();
     }
     else if (t < .5) {
       return interpolatedR(2*t); 
     } else if (t < 1) {
       return multiply(interpolatedQ(2*(t - .5)), r);
     } else {
        return multiply(q, r); 
     }
   }
  
}


float interpolationFunction(float t) {
  return (sin(t*PI - PI/2) + 1)/2.0;
}

class OrthogonalShearScaleDecomposition {

  
  tMatrix orthogonal;
  tMatrix shear;
  tMatrix scale;
  
  float rotationAngle;
  float scaleX;
  float scaleY;
  float shearNumber;
  
  OrthogonalShearScaleDecomposition(tMatrix m) {
    tMatrix r = RMatrix(m);
    orthogonal = QMatrix(m);
    tVector e1 = new tVector(1,0);
    rotationAngle = angleFromTo(e1, multiply(orthogonal,e1));
    if (determinant(orthogonal) < 0) {
      r = multiply(xMirror(), r);
      orthogonal = multiply( orthogonal, xMirror());
    } 
    float upperleft = r.row1.x;
    float upperright = r.row1.y;
    float lowerright = r.row2.y;
    
    float upperRightShear;
    if (upperleft == 0) {
       upperRightShear = 0;
    } else {
      upperRightShear = upperright/upperleft;
    }
    
    scale = new tMatrix(upperleft, 0, 0, lowerright);
    shear = new tMatrix(1, upperRightShear, 0, 1);
    scaleX = upperleft;
    scaleY = lowerright;
    shearNumber = upperRightShear;
    
  }
  
  tMatrix interpolatedScale(float t) {
     tMatrix rTerm = multiply(interpolationFunction(t), scale);
     tMatrix iTerm = multiply(1-interpolationFunction(t), identity());
     return add(rTerm, iTerm);
   }
   
   tMatrix interpolatedShear(float t) {
     tMatrix rTerm = multiply(interpolationFunction(t), shear);
     tMatrix iTerm = multiply(1-interpolationFunction(t), identity());
     return add(rTerm, iTerm);
   }
   
   tMatrix interpolatedOrthogonal(float t) {
     return rotation(rotationAngle*interpolationFunction(t));
   }
   
   tMatrix interpolate(float t) {
     if (t <= 0) {
       return identity();
     }
     else if (t <= 1.0/3.0) {
       return interpolatedShear(3*t); 
     } else if (t <= 2.0/3.0 ) {
       return multiply(interpolatedScale(3*(t - 1.0/3.0)), shear);
     } else if (t <= 1) {
       return multiply(interpolatedOrthogonal(3*(t - 2.0/3.0)), multiply(scale, shear));
     } else {
        return multiply(multiply(orthogonal, scale), shear); 
     }
   }
  
}
