Attribute VB_Name = "Module1"
Sub stockData()

'looping through all worksheets
Dim ws As Worksheet


For Each ws In Worksheets

    'ticker symbol and total volume variables
    Dim tickerSym As String
    Dim totalVol As Double

    'year open and close variable
    Dim yearOpen As Double
    Dim yearClose As Double

    'summary table row variable
    Dim summaryRow As Integer
    summaryRow = 2

    'print summary table headers
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Total Volume"
    ws.Cells(1, 11).Value = "Yearly Change"
    ws.Cells(1, 12).Value = "Percent Change"
    
    
    'Find Last row
    
    Dim lasrRow As Double
    lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    For i = 2 To lastRow
    
    'if no opening price then skip the row
    
    If (ws.Cells(i, 3).Value = 0) Then
    
 'if last cell for a ticker symbol with no data , then set ticker symbol
       
        If (ws.Cells(i + 1).Value <> ws.Cells(i, 1).Value) Then
        
        'set ticker symbol variable
          tickerSym = ws.Cells(i, 1).Value
        
     End If
     
     'if next cell = current cell, add to total volume
        ElseIf (ws.Cells(i + 1, 1).Value = ws.Cells(i, 1).Value) Then
            totalVol = totalVol + ws.Cells(i, 7).Value
            'if last cell <> this cell, set yearOpen
            If (ws.Cells(i - 1, 1).Value <> ws.Cells(i, 1).Value) Then
                yearOpen = ws.Cells(i, 3).Value
            End If
            
            Else
            'set ticker symbol variable
            tickerSym = ws.Cells(i, 1).Value
            'add to total volume
            totalVol = totalVol + ws.Cells(i, 7).Value
            'set yearClose
            yearClose = ws.Cells(i, 6).Value
            'print ticker symbol and total volume in summary table
            ws.Cells(summaryRow, 9).Value = tickerSym
            ws.Cells(summaryRow, 10).Value = totalVol
            'to avoid dividing by zero
            If (totalVol > 0) Then
                'print yearly change in summary table
                ws.Cells(summaryRow, 11).Value = yearClose - yearOpen
                    
    'change color to green if > 0, else red
    
    If (ws.Cells(summaryRow, 11).Value > 0) Then
                        ws.Cells(summaryRow, 11).Interior.ColorIndex = 4
                    Else
                        ws.Cells(summaryRow, 11).Interior.ColorIndex = 3
                    End If
                'print % change in summary table
                ws.Cells(summaryRow, 12).Value = ws.Cells(summaryRow, 11).Value / yearOpen
            Else
            'set yearly and % change to zero if no stock data
                ws.Cells(summaryRow, 11).Value = 0
                ws.Cells(summaryRow, 12).Value = 0
            End If
            'set cell format to percent
            ws.Cells(summaryRow, 12).Style = "percent"
            'reset total volume
            totalVol = 0
            'next summary row
            summaryRow = summaryRow + 1
        End If
    Next i
    
    'Finding greatest total volume
    Dim GrtTolVol As Double
    
    'print table labels
    
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Greatest Total Volume"
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    
    'set baseline for greatest total volume
    GrtTolVol = 0
    
     'offset summaryRow to equal number of ticker symbols
    summaryRow = summaryRow - 2
    
    'if cell > greatest total volume, set cell as greatest total volume
    For i = 2 To summaryRow
        If (ws.Cells(i, 10).Value > GrtTolVol) Then
            GrtTolVol = ws.Cells(i, 10).Value
            
    'print ticker symbol in table
            ws.Cells(4, 16).Value = ws.Cells(i, 9).Value
        End If
    Next i
    
    'print greatest total volume in table
    ws.Cells(4, 17).Value = GrtTolVol
    
     'Assign greatest % increase and decrease variables
    Dim increasePer As Double
    Dim decreasePer As Double

 'set baseline for greatest & increase and decrease
    increasePer = 0
    decreasePer = 0
    
    For i = 2 To summaryRow
        'if cell > greatest % increase, set cell as greatest % increase
        If (ws.Cells(i, 12).Value > increasePer) Then
            increasePer = ws.Cells(i, 12).Value
            
  'print ticker symbol in table
    ws.Cells(2, 16) = ws.Cells(i, 9).Value

'if cell < greatest % decrease, set cell as greatest % decrease
    ElseIf (ws.Cells(i, 12).Value < decreasePer) Then
            decreasePer = ws.Cells(i, 12).Value
    
 'print ticker symbol in table
            ws.Cells(3, 16).Value = ws.Cells(i, 9).Value
        End If
    Next i

    'print greatest % increase and decrease in table
    ws.Cells(2, 17).Value = increasePer
    ws.Cells(3, 17).Value = decreasePer
    
    
    'set cell format to percent
    ws.Cells(2, 17).Style = "percent"
    ws.Cells(3, 17).Style = "percent"

    'auto fit table columns
    ws.Columns("I:Q").AutoFit

Next ws

End Sub

    
    
    
    
    
    

    
    
    
    
