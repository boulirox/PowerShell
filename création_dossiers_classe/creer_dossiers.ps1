#note : changer la premi�re ligne du csv import� de colnet pour => nom;prenom;;;

$eleves = Import-Csv liste_classe.csv -Delimiter ';' -Encoding UTF7
foreach($eleve in $eleves)
{
    $nomDossier = $eleve.nom + ", " + $eleve.prenom
    New-Item -Name $nomDossier -ItemType Directory
}


