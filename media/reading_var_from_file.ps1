$pathParam = "C:\Users\thborn\books\azure\AzureDevOps\Rest_APIs\rest_apis\services\src\parameters.txt"
Get-Content   $pathParam | Foreach-Object {
    $var = $_.Split('=')
    New-Variable -Name $var[0] -Value $var[1]
    Write-Host -Name $var[0] -Value $var[1]
}
