@{
    PSDependOptions = @{
        Target = 'CurrentUser'
    }
    'AWSLambdaPSCore' = @{
        Version = '1.2.0.0'
    }
    'VaporShell' = @{
        Version = '2.9.4'
    }
    'Pester' = @{
        Version = '4.9.0'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'psake' = @{
        Version = '4.8.0'
    }
    'BuildHelpers' = @{
        Version = '2.0.11'
    }
    'PowerShellBuild' = @{
        Version = '0.4.0'
    }
}
