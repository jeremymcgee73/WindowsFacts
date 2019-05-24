#Requires -Modules @{ModuleName='AWSPowerShell.NetCore';ModuleVersion='3.3.343.0'}

$path = $LambdaInput.path

if ($LambdaInput) {
    $path = $LambdaInput.path
}
else {
    # Test value when running locally.
    $path = "/factcount"
}

if($path.StartsWith("/")) {
    $path = $path.Substring(1)
}

$tokens = $path -split "/"

function Get-WindowsFacts {
    Get-Content /tmp/facts.json | ConvertFrom-Json
}

function Get-RandomFact {
    $Facts = Get-WindowsFacts
    $RandomNum = ((Get-Random -Minimum 0 -Maximum ($Facts).count) - 1)
    $Facts[$RandomNum]
}

function Get-FactCount {
    (Get-WindowsFacts).Count
}

Read-S3Object -BucketName "windowsfacts-cf" -Key facts.json -File /tmp/facts.json | Out-Null

switch($tokens[0])
{
    'fact' {
        $Fact = Get-RandomFact 

        $result = [PSCustomObject]@{
            Fact = $Fact
            CharLength = $Fact.length
        } | ConvertTo-Json
    }
    'factcount' {$result = Get-FactCount | ConvertTo-Json}
}

@{
    'statusCode' = 200;
    'body' = $result;
    'headers' = @{'Content-Type' = 'application/json'}
}