# WindowsFacts
An API to get Microsoft Windows Facts. This is written in PowerShell using AWS Lambda / API Gateway.


## Description
This is a project for an API to deliver Microsoft Windows Facts... really for entertainment.  I have been wanting to build an API using PowerShell and AWS Lambda for awhile now. I got this working in a few hours. It is far from perfect. This is mostly going to be a place for me to get better at CI/CD, AWS and testing. I am hopeful the community will submit PRs to add more facts! 😃

Thanks to [Josh Rickard](https://github.com/MSAdministrator) for the idea!

## Examples

```powershell
Invoke-RestMethod https://api.windowsfacts.com/fact

Invoke-RestMethod https://api.windowsfacts.com/factcount
```

## Troll your coworkers

Thanks [bigbeardtoejam](https://www.reddit.com/r/PowerShell/comments/6550a7/using_powershell_for_office_pranks/)

```powershell
#Run this every 1/2 hour and in an 8 hour work day there will be approximately 3 times per day that your victim hears a cat fact
if ((Get-Random -Maximum 10000) -lt 1875) {
    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $WindowsFact = (Invoke-RestMethod https://api.windowsfacts.com/fact).fact
    $SpeechSynth.Speak("Did you know? $WindowsFact")
}
```