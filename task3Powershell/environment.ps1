$path=$args[0]

if ($path = 1) {

Write-Host "$env:COMPUTERNAME"
$env:COMPUTERNAME
Write-Host "To know the name of your computer"

}

if ($path = 2) {

Write-Host "$env:SciTE_USERHOME"
$env:SciTE_USERHOME
Write-Host "Show the path where scite save files"


}

if ($path = 3) {

Write-Host "$env:SESSIONNAME"
$env:SESSIONNAME
Write-Host "Show where are you operating"

}

if ($path = 4) {


Write-Host "$env:SESSIONNAME"
$env:SystemRoot
Write-Host "Show where is located root path"

}

if ($path = 5) {

Write-Host "$env:TMP"
$env:TMP
Write-Host "Show the TMP path and his files"

}
