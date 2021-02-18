#exercice web request et utilisation API
$origin = Read-Host "Entrez l'origine"
$destination = Read-Host "Entrez la destination"

$origin = $origin.Replace(" ", "+") #on ne peut pas laisser d'espace dans l'adresse web
$destination = $destination.Replace(" ", "+")#meme chose ici

#$url = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&language=fr&region=CA"
$url = "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&language=fr&region=CA&key=ENTER_KEY_HERE"
$json = Invoke-WebRequest -Uri $url 
#Write-Host $json
$directions = ConvertFrom-Json -InputObject $json
$route = $directions.routes[0]
$leg = $route.legs[0]

Write-Host "Duree totale :" $leg.duration.text
Write-Host "Distance totale :" $leg.distance.text
Write-Host "Directions : "
foreach($step in $leg.steps)
{
    Write-Host "Direction :" $step.html_instructions ", Distance :" $step.distance.text ", Durée :" $step.duration.text
}
