
function paramPath() {

    $paramPath = ".\src\parameters.json"
    $string = (Get-Content $paramPath)
    $parameters = $string | ConvertFrom-Json

    return $parameters
}

function disablingLabTest() {
    
    $param = (paramPath)
    $projectId = $param[0].featureId
    $featureName = "ms.vss-test-web.test"

    $token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($param[0].personalToken)"))
    $headers = @{authorization = "Basic $token" }
    $body = "{`"featureId`":`"ms.vss-test-web.test`",`"scope`":{`"settingScope`":`"project`",`"userScoped`":false},`"state`":0}"
    $urlComposition = "$($param[0].orgUrl)/_apis/FeatureManagement/FeatureStates/host/project/$($projectId)/$($featureName)?api-version=4.1-preview.1"
    
    $response = Invoke-RestMethod $urlComposition `
        -Method 'PATCH' `
        -ContentType "application/json" `
        -Headers $headers `
        -Body $body

    return $response
}

disablingLabTest | ConvertTo-Json