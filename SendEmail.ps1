#exercice sur l'envoie d'email
$processes = Get-Process

$contenuEmail = "" 
foreach($process in $processes)
{
    $contenuEmail = $contenuEmail + $process.ProcessName + "<br/>"
}

Send-MailMessage -From "abc@xyz.com" -To "abc@xyz.com" -Subject "Process qui roulent" -Body $contenuEmail -SmtpServer "localhost" -BodyAsHtml