function sumMatrices(matrix1, matrix2) {
    var tempMatrix = [];
    for (var i = 0; i <= matrix1.length - 1; i++) {
        var tempArr = [];
        for (var j = 0; j <= matrix1[i].length - 1; j++) {
            tempArr.push(matrix1[i][j] + matrix2[i][j]);
        }
        tempMatrix.push(tempArr);
    }
    return(tempMatrix);
}

function getStringMatrix(matrix) {
    var stringMatrix = "";
    for (var i = 0; i <= matrix.length - 1; i++) {
        for (var j = 0; j <= matrix[i].length - 1; j++) {
            stringMatrix += IntToStr(matrix[i][j]) + "   ";
        } 
        stringMatrix += "\n";
    }
    return(stringMatrix);
}

function getRandomMatrix(maxNumber, maxRows, maxCols) {
    var randomMatrix = [];
    for (var i = 0; i <= maxRows - 1; i++) {
        var tempArr = [];
        for (var j = 0; j <= maxCols - 1; j++) {
            tempArr.push(Math.floor(Math.random() * maxNumber) - Math.floor(maxNumber / 2));
        } 
        randomMatrix.push(tempArr);
    }
    return(randomMatrix);
}

function fillMatrixInWindow(matrix, name, form) {
    for (var i = 0; i <= matrix.length - 1; i++) {
        for (var j = 0; j <= matrix[i].length - 1; j++) {
            form.VCLObject("e" + name + IntToStr(i) + IntToStr(j)).Keys(IntToStr(matrix[i][j]));
        }
    }
}

function Test1()
{
    TestedApps.MatrixOperations.Run();
    
    var maxNumber = 10;
    var maxRows = 3;
    var maxCols = 3;
    var matrA = getRandomMatrix(maxNumber, maxRows, maxCols);
    var matrB = getRandomMatrix(maxNumber, maxRows, maxCols);
    
    var stringMatrA = getStringMatrix(matrA);
    var stringMatrB = getStringMatrix(matrB);
    
    var resMatr = sumMatrices(matrA, matrB);
    var stringResMatr = getStringMatrix(resMatr);
    
    form1 = Sys.Process("MatrixOperations").VCLObject("Form1");
    form1.VCLObject("gbMatrA").VCLObject("bClearA").ClickButton();
    form1.VCLObject("gbMatrB").VCLObject("bClearB").ClickButton();
    form1.VCLObject("bClearRes").ClickButton();
    
    fillMatrixInWindow(matrA, "A", form1);
    fillMatrixInWindow(matrB, "B", form1);
    
    maskEdit = form1.VCLObject("eExpression");
    maskEdit.Click(44, 15);
    maskEdit.Keys("(A+B)");
    form1.VCLObject("bEnter").ClickButton();
    
    Log.Picture(form1, "Result window", "Source matrix A: \n" + stringMatrA 
                                            + "Source matrix B: \n" + stringMatrB 
                                            + "Expected sum: \n" + stringResMatr);
    
}
