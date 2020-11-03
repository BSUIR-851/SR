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
            form.VCLObject("e" + name + IntToStr(i) + IntToStr(j)).wText = matrix[i][j];
        }
    }
}

function Test1()
{
    TestedApps.MatrixOperations.Run();
    
    var maxNumber = 10000;
    var maxRows = 3;
    var maxCols = 3;
    var matrA = getRandomMatrix(maxNumber, maxRows, maxCols);
    var matrB = getRandomMatrix(maxNumber, maxRows, maxCols);
    
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
    
}
