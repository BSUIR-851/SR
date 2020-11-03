function getMatrixFromExcel(maxRows, maxCols, data) {
    var matrix = [];
    for (var i = 0; i <= maxRows - 1; i++) {
        var tempArr = [];
        for (var j = 0; j <= maxCols - 1; j++) {
            tempArr.push(data.Value("num" + IntToStr(i) + IntToStr(j)));
        } 
        matrix.push(tempArr);
    }
    return(matrix);
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

function fillMatrixInWindow(matrix, name, form) {
    for (var i = 0; i <= matrix.length - 1; i++) {
        for (var j = 0; j <= matrix[i].length - 1; j++) {
            form.VCLObject("e" + name + IntToStr(i) + IntToStr(j)).wText = matrix[i][j];
        }
    }
}

function clearSpace(form) {
    form.VCLObject("gbMatrA").VCLObject("bClearA").ClickButton();
    form.VCLObject("bClearRes").ClickButton();
    if(form.VCLObject("cCheck").Checked) {
        form.VCLObject("cCheck").Checked = false;
    }
}

function Test1()
{
    TestedApps.MatrixOperations.Run();
    
    var filePath = "Z:\\Study\\npo\\laba5\\calcData.xlsx";
    var data = DDT.ExcelDriver(filePath, "Лист1", true);
    
    var maxRows = 3;
    var maxCols = 3;
    var matrA;
    
    form1 = Sys.Process("MatrixOperations").VCLObject("Form1");

    while(!data.EOF()) {
        matrA = getMatrixFromExcel(maxRows, maxCols, data);
        clearSpace(form1);
    
        fillMatrixInWindow(matrA, "A", form1);
        form1.VCLObject("gbMatrA").VCLObject("bDetA").ClickButton();
        
        stringMatrix = getStringMatrix(matrA);
        Log.Picture(form1, "Result window", "Source matrix: \n" + stringMatrix 
                                            + "Expected determinate: " 
                                            + IntToStr(data.Value("determinate")));
        
        data.Next();
    }
    
    DDT.CloseDriver(data.Name);
}
