Describe 'Get-RandomWinFact' {
    BeforeAll {
        $manifest           = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
        $outputDir          = Join-Path -Path $ENV:BHProjectPath -ChildPath 'Output'
        $outputModDir       = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
        $outputModVerDir    = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion

        Get-Module $env:BHProjectName | Remove-Module -Force
        Import-Module -Name (Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1") -Verbose:$false -ErrorAction Stop
    }

    it 'Does not throw an error' {
        {Get-RandomWinFact} | Should -Not -Throw
    }

    it 'Have one fact' {
        @(Get-RandomWinFact).Count | Should Be 1
    }

    it 'Should be a String' {
        (Get-RandomWinFact).GetType().Name | Should be 'String'
    }

    it 'Should return strings' {
        0 .. 100 | ForEach-Object{
            (RandomWinFact).GetType().Name | Should be 'String'
        }
    }
}
