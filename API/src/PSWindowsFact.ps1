#Requires -Modules "pswindowsfacts"

$path = $LambdaInput.path

if ($LambdaInput) {
    $path = $LambdaInput.path
}
else {
    # Test value when running locally.
    $path = "/fact"
}

if($path.StartsWith("/")) {
    $path = $path.Substring(1)
}

$tokens = $path -split "/"
$statusCode = 404

switch($tokens[0])
{
    'fact' {
        $Fact = Get-RandomWinFact

        $result = [PSCustomObject]@{
            Fact = $Fact
            CharLength = $Fact.length
        } | ConvertTo-Json

        $statusCode = 200
    }
    'factcount' {
        $result = Get-WindowsFact.Count | ConvertTo-Json
        $statusCode = 200
    }
}

@{
    'statusCode' = $statusCode;
    'body' = $result;
    'headers' = @{'Content-Type' = 'application/json'}
}
