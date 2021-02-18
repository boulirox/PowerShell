#note : changer la première ligne du csv importé de colnet pour => nom;prenom;;;
Class Critere
{
    [string]$Nom
    [int]$NbPoints
}

#changer ici pour les criteres de l'evaluation en question
$criteres = New-Object System.Collections.Generic.List[Critere]
$criteres.Add((New-Object Critere -Property @{ Nom = "Test1"; NbPoints = 4 }))
$criteres.Add((New-Object Critere -Property @{ Nom = "Test2"; NbPoints = 4 }))
$criteres.Add((New-Object Critere -Property @{ Nom = "Test3"; NbPoints = 4 }))
$criteres.Add((New-Object Critere -Property @{ Nom = "Test4"; NbPoints = 4 }))

#creer excel et classeur
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true
$excel.DisplayAlerts = $false
$workbook = $excel.Workbooks.Add()

#import du csv de la liste d'eleves
$eleves = Import-Csv liste_classe.csv -Delimiter ';' -Encoding UTF7

#trier les eleves comme dans colnet
$eleves = $eleves | Sort-Object -Property nom, prenom

for($i = 0; $i -lt $eleves.Count; $i++)
{
    $worksheet
    if($i -eq 0)
    {
        $worksheet = $workbook.worksheets(1)
    }
    else 
    {
        $lastSheet = $workbook.Worksheets | Select-Object -Last 1
        $worksheet = $workbook.worksheets.Add([System.Reflection.Missing]::Value,$lastSheet)
    }
    $worksheet.Name = $eleves[$i].nom + ", " + $eleves[$i].prenom

    #les headers
    $worksheet.Cells(1, 2).Value = "Note"
    $worksheet.Cells(1, 3).Value = "Sur"
    $worksheet.Cells(1, 4).Value = "Commentaires"

    #les criteres
    for($j = 0; $j -lt $criteres.Count; $j++)
    {
        $worksheet.Cells($j + 2, 1).Value = $criteres[$j].Nom

		if($criteres[$j].NbPoints -ne 0)
        {
            $worksheet.Cells($j + 2, 3).Value = $criteres[$j].NbPoints.ToString()
        }
    }

    #le total
    $worksheet.Cells($criteres.Count + 2, 1).Value = "Total"
    $worksheet.Cells($criteres.Count + 2, 2).Formula = "=SUM(B2:B"+($criteres.Count+1)
    $worksheet.Cells($criteres.Count + 2, 3).Formula = "=SUM(C2:C"+($criteres.Count+1)

    $worksheet.UsedRange.EntireColumn.Autofit() 
}

#sauvegarder le fichier excel
$path = Join-Path -Path $PWD -ChildPath "notes.xlsx"
$workbook.SaveAs($path)
#$excel.Quit()