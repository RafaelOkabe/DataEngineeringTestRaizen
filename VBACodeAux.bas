Attribute VB_Name = "Module1"
Public Sub ExtractPivotTableData()

    Dim objActiveBook As Workbook
    Dim objSheet As Worksheet
    Dim objPivotTable As PivotTable
    Dim objTempSheet As Worksheet
    Dim objTempPivot As PivotTable
    Dim contador As Integer
    
    contador = 0

    If TypeName(Application.Selection) <> "Range" Then
        Beep
        Exit Sub
    ElseIf WorksheetFunction.CountA(Cells) = 0 Then
        Beep
        Exit Sub
    Else
        Set objActiveBook = ActiveWorkbook
    End If

    With Application
        .ScreenUpdating = False
        .DisplayAlerts = False
    End With

    For Each objSheet In objActiveBook.Sheets
        For Each objPivotTable In objSheet.PivotTables
            With objActiveBook.Sheets.Add(, objSheet)
                With objPivotTable.PivotCache.CreatePivotTable(.Range("A1"))
                    .AddDataField .PivotFields(1)
                End With
                .Range("B2").ShowDetail = True
                objActiveBook.Sheets(.Index - 1).Name = "SOURCE DATA FOR SHEET " & objSheet.Index + contador
                objActiveBook.Sheets(.Index - 1).Tab.Color = 255
                contador = contador + 1
                .Delete
            End With
        Next
    Next

    With Application
        .ScreenUpdating = True
        .DisplayAlerts = True
    End With

End Sub
