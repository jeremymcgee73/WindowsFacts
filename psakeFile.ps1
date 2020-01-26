properties {
    # Disable "compiling" module into monolithinc PSM1.
    # This modifies the default behavior from the "Build" task
    # in the PowerShellBuild shared psake task module
    $PSBPreference.Build.CompileModule = $false
    $localPackagePath = Join-Path -Path $ENV:BHProjectPath -ChildPath "\API\src\PSWindowsFact.zip"
}

task default -depends CleanupArtifacts

task BuildLambdaPackage -depends Test {
    $scriptPath = Join-Path -Path $ENV:BHProjectPath -ChildPath '\API\src\PSWindowsFact.ps1'

    $manifest           = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
    $outputDir          = Join-Path -Path $ENV:BHProjectPath -ChildPath 'Output'
    $outputModDir       = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
    $outputModVerDir    = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion
    $ModulePath = (Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1")

    # There is a bug with this cmdlet. It throws an error when using psake.
    # I believe it has something to do with runspaces. Running in a new process
    # fixes the issue.
    $packageResults = pwsh -command "Import-Module $ModulePath; New-AWSPowerShellLambdaPackage -ScriptPath $scriptPath -OutputPackage $localPackagePath"
    $packageResults
  }

  task UploadPackageToS3 -depends BuildLambdaPackage {
    $templatePath = Join-Path -Path $ENV:BHProjectPath -ChildPath '\API\src\serverless.template'
    $outputTemplatePath = Join-Path -Path $ENV:BHProjectPath -ChildPath '\API\Output\PSWindowsFact.template'

    Invoke-VSPackage -TemplateFile $templatePath -S3Bucket windowsfactstest-cf -OutputTemplateFile $outputTemplatePath -S3Prefix $(New-Guid) -Force -Verbose
  }

  task DeployPackage -depends UploadPackageToS3 {
    $outputTemplatePath = Join-Path -Path $ENV:BHProjectPath -ChildPath '\API\Output\PSWindowsFact.template'

    Invoke-VSDeploy -TemplateFile $outputTemplatePath -StackName "WindowsFactAPI" -Capabilities CAPABILITY_IAM
  }

  task CleanupArtifacts -depends DeployPackage {
    Remove-Item  $(Join-Path -Path $ENV:BHProjectPath -ChildPath "\API\src\*.zip") -Force
  }

task Test -FromModule PowerShellBuild -Version '0.4.0'
