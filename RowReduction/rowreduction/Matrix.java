import java.util.ArrayList;

public class Matrix {
  
  public float[][] entries;
  
  public int rows;
  public int columns;
  
  public Matrix( float[][] entries) {
    rows = entries.length;
    columns = entries[0].length;
    this.entries = new float[rows][columns];
    for (int r = 0; r < rows; r++) {
      for (int c= 0; c < columns; c++) {
        this.entries[r][c] = entries[r][c];
      }
    }
  }
  
  public Matrix(int rows, int columns) {
    entries = new float[rows][columns];
    this.rows = rows;
    this.columns = columns;
  }
  
    public String toString() {
    String str = "";
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        str = str + " " + entries[r][c]; 
      }
      str = str + "\n";
    }
    return str;
  }
  
    public String prettytoString() {
    String str = "\\begin{bmatrix}";
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        if (c == columns - 1) {
          str = str + " &  |";
        }
        if (c > 0) {
          str = str + " & "; 
        }
        str = str + " " + (int) entries[r][c]; 
      }
      str = str + "\\\\";
    }
    str = str + "\\end{bmatrix} \\\\";
    
    return str;
  }
  
  public float entry(int row, int column) {
    return entries[row][column]; 
  }
  
  
  //the following three functions perform elementary row operations
  public static Matrix replaceRow(Matrix matrix, int rowToReplace, int otherRow, float multipleOfOtherRow) {
    Matrix replacer = Matrix.elementaryReplaceMatrix(matrix.rows, rowToReplace,  otherRow, multipleOfOtherRow);
    return Matrix.multiply(replacer, matrix);
  }
  
  public static Matrix scaleRow(Matrix matrix, int row, float scale) {
    Matrix scalar = Matrix.elementaryRowScaleMatrix(matrix.rows, row, scale);
    return Matrix.multiply(scalar, matrix);
  }
  
  public static Matrix swapRows(Matrix matrix, int row1, int row2) {
     Matrix swapper = Matrix.elementyRowSwapMatrix(matrix.rows,row1, row2);
     return Matrix.multiply(swapper, matrix);
  }
  
  
  //the following three functions construct the elemetary matrices
  public static Matrix elementaryReplaceMatrix(int numberOfRows, int rowToReplace, int other, float multipleOfOtherRow) {
    Matrix initial = Matrix.zeroMatrix(numberOfRows, numberOfRows);
    for (int i = 0; i < numberOfRows; i++) {
        initial.entries[i][i] = 1; 
    }
    initial.entries[rowToReplace][other] = multipleOfOtherRow;
    return initial;
  }
  
  public static Matrix elementaryRowScaleMatrix(int numberOfRows, int rowToScale, float scaler) {
    Matrix initial = Matrix.zeroMatrix(numberOfRows, numberOfRows);
    for (int i = 0; i < numberOfRows; i++) {
      if (i != rowToScale) {
        initial.entries[i][i] = 1; 
      }
    }
    initial.entries[rowToScale][rowToScale] = scaler;
    return initial;
  }
  
  public static Matrix elementyRowSwapMatrix(int numberOfRows, int row1, int row2) {
    Matrix initial = Matrix.zeroMatrix(numberOfRows, numberOfRows);
    for (int i = 0; i < numberOfRows; i++) {
      if (i != row1 && i != row2) {
        initial.entries[i][i] = 1; 
      }
    }
    initial.entries[row1][row2] = 1;
    initial.entries[row2][row1] = 1;
    return initial;
  }
  
  public static Matrix zeroMatrix(int rows, int columns) {
    float[][] values = new float[rows][columns];
    for (int r = 0; r < rows; r++) {
      for (int c= 0; c < columns; c++) {
        values[r][c] = 0; 
      }
    }
    return new Matrix(values);
  }
  
  public static Matrix multiply(Matrix matrixLeft, Matrix matrixRight) {
    Matrix product = new Matrix(matrixLeft.rows, matrixRight.columns);
    for (int r = 0; r < product.rows; r++) {
      for (int c = 0; c < product.columns; c++) {
        float sum = 0;
         for (int i = 0; i < matrixLeft.columns; i++) {
           sum = sum + matrixLeft.entry(r, i)*matrixRight.entry(i,c);
         }
         product.entries[r][c] = sum;
      }
    }
    return product;
  }
  
  public static Matrix add(Matrix matrixLeft, Matrix matrixRight) {
    Matrix sum = new Matrix(matrixLeft.rows, matrixRight.columns);
    for (int r = 0; r < sum.rows; r++) {
      for (int c = 0; c < sum.columns; c++) {
         sum.entries[r][c] = matrixLeft.entries[r][c] + matrixRight.entries[r][c];
      }
    }
    return sum;
  }
  
    public static Matrix scale(float scale, Matrix matrixRight) {
    Matrix sum = new Matrix(matrixRight.rows, matrixRight.columns);
    for (int r = 0; r < sum.rows; r++) {
      for (int c = 0; c < sum.columns; c++) {
         sum.entries[r][c] = scale*matrixRight.entries[r][c];
      }
    }
    return sum;
  }
  
  public static Matrix matCopy(Matrix matrix) {
    return new Matrix(matrix.entries);
  }
  
  
  //we perform the ref algorithm
  public static Matrix ref(Matrix matrix) {
    Matrix holder = Matrix.matCopy(matrix);
    int rowsCompleted = 0;
    double roundError = 0.0001;
    holder = Matrix.roundDown(matrix, roundError);
    for (int c = 0; c < matrix.columns; c++) {
      //first find a row, where row >= rowsCompleted, such that entry[row][column] != 0
      int chosenRow = -1;
      boolean entryFound = false;
      for (int r = rowsCompleted; r < matrix.rows; r++) {
        if (holder.entries[r][c] != 0 && !entryFound && (holder.entries[r][c] > roundError || holder.entries[r][c] < -roundError)) {
          entryFound= true;
           chosenRow = r;
        }
      }
      if (chosenRow != -1) {
        //we have a nonzero leading term
        holder = Matrix.swapRows(holder, rowsCompleted, chosenRow);
        chosenRow = rowsCompleted;
        float scalar = 1/holder.entries[chosenRow][c];
        //now scale said rows
        holder = Matrix.scaleRow(holder, chosenRow, scalar);
        // the chosenrow should now be like (0, 0, 1, 54, 2, 5, 5,0, 4)
        //now iterate through all other rows subtracting stuff off
        for (int rowToReplace = 0; rowToReplace < matrix.rows; rowToReplace++) {
          if (rowToReplace != chosenRow) {
            float multipleOfChosenRow = -holder.entries[rowToReplace][c];
            holder = Matrix.replaceRow(holder, rowToReplace, chosenRow, multipleOfChosenRow); 
          }
        }
        rowsCompleted++;
      }
    }
    return holder;
  }
  
  public static boolean areEqual(Matrix mat1, Matrix mat2) {
    boolean eq = true;
    for (int r = 0; r < mat1.rows || r < mat2.rows; r++) {
      for (int c = 0; c < mat1.columns || c < mat2.columns; c++) {
        if (mat1.entries[r][c] != mat2.entries[r][c]) {
          eq = false;
          return eq;
        }
      }
    }
    return eq;
  }
  
  public static ArrayList<Matrix> stepsInREF(Matrix matrix) {
    ArrayList<Matrix> steps = new ArrayList<Matrix>();
    Matrix current = Matrix.matCopy(matrix);
    steps.add(current);
    
    Matrix next = Matrix.steppedREF(current);
    while (!Matrix.areEqual(current, next)) {
      current = next;
      steps.add(current);
      next = Matrix.steppedREF(current);
    }
    
    return steps;
  }
  
  public static Matrix roundDown(Matrix matrix, double zero) {
    Matrix holder = Matrix.matCopy(matrix);
    for (int r = 0; r < holder.rows; r++) {
      for (int c = 0; c < holder.columns; c++) {
        if (Math.abs(holder.entries[r][c]) <= zero) {
            holder.entries[r][c] = 0;
        }
      }
    }
    return holder;
  }
  
  //performs one steps in the ref algorithm
  public static Matrix steppedREF(Matrix matrix) {
    Matrix holder = Matrix.matCopy(matrix);
        double roundError = 0.001;
        holder = Matrix.roundDown(matrix, roundError);
        
    boolean nonTrivialOperationPerformed = false;

    int rowsCompleted = 0;
    for (int c = 0; c < matrix.columns; c++) {
      //first find a row, where row >= rowsCompleted, such that entry[row][column] != 0
      int chosenRow = -1;
      boolean entryFound = false;
      for (int r = rowsCompleted; r < matrix.rows; r++) {
        if (Math.abs(holder.entries[r][c]) > roundError && !entryFound) {
         // System.out.println("called");
     //     System.out.println(holder.entries[r][c]);
          entryFound= true;
           chosenRow = r;
        }
      }
      if (chosenRow != -1) {
        //we have a nonzero leading term
        holder = Matrix.swapRows(holder, rowsCompleted, chosenRow);
        if (chosenRow != rowsCompleted) {
          nonTrivialOperationPerformed = true;
          return holder;
        }
        chosenRow = rowsCompleted;
        float scalar = 1/holder.entries[chosenRow][c];
        //now scale said rows
        holder = Matrix.scaleRow(holder, chosenRow, scalar);
        if (scalar != 1) {
           nonTrivialOperationPerformed = true;
          return holder;
        }
        // the chosenrow should now be like (0, 0, 1, 54, 2, 5, 5,0, 4)
        //now iterate through all other rows subtracting stuff off
        for (int rowToReplace = 0; rowToReplace < matrix.rows; rowToReplace++) {
          if (rowToReplace != chosenRow) {
            float multipleOfChosenRow = -holder.entries[rowToReplace][c];
            if (multipleOfChosenRow != 0) {
              holder = Matrix.replaceRow(holder, rowToReplace, chosenRow, multipleOfChosenRow); 
              return holder;
            }
          }
        }
        rowsCompleted++;
      }
    }
    return holder;
  }
  
  public static ArrayList<Matrix> interoplatedMatrices(Matrix matrix, int numberOfPointsBetweenSteps) {
    ArrayList<Matrix> interpolated = new ArrayList<Matrix>();
    ArrayList<Matrix> steps = Matrix.stepsInREF(matrix);
    
    for (int i = 0; i < steps.size()-1; i++) {
       Matrix mat1 = steps.get(i);
       Matrix mat2 = steps.get(i+1);
       
       Matrix negativeMat1 = Matrix.scale(-1, mat1);
       Matrix mat2MinusMat1 = Matrix.add(mat2, negativeMat1);
       
       
       
       for (int t = 0; t < numberOfPointsBetweenSteps; t++) {
          float scaleTerm = (float) t/numberOfPointsBetweenSteps;
          Matrix toAdd = Matrix.scale(scaleTerm, mat2MinusMat1 );
          Matrix interp = Matrix.add(mat1, toAdd);
          interpolated.add(interp);
       }
       
    }
    Matrix last = steps.get(steps.size()-1);
    interpolated.add(last);
    
    return interpolated;
    
    
  }
  
}
