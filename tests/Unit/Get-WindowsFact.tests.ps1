Describe 'Get-WindowsFact' {
    BeforeAll {
        $manifest           = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
        $outputDir          = Join-Path -Path $ENV:BHProjectPath -ChildPath 'Output'
        $outputModDir       = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
        $outputModVerDir    = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion

        Get-Module $env:BHProjectName | Remove-Module -Force
        Import-Module -Name (Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1") -Verbose:$false -ErrorAction Stop
    }

    it 'Does not throw an error' {
        {Get-WindowsFact} | Should -Not -Throw
    }

    it 'Has more than one fact' {
        (Get-WindowsFact).Count | Should BeGreaterThan 0
    }

    it 'Has the same number from the json file as the function' {
        $jsonFacts = Get-Content (Join-Path -Path $outputModVerDir -ChildPath 'facts.json') | ConvertFrom-Json
        (Get-WindowsFact).Count | Should be $jsonFacts.Count
    }

    it 'Should be an array' {
        (Get-WindowsFact).GetType().Name | Should be 'Object[]'
    }

    it 'Should return strings' {
        $facts = (Get-WindowsFact)
        0 .. ($facts.count - 1) | ForEach-Object{
            ($facts[$_]).GetType().Name | Should be 'String'
        }

    }
}
