
Function Get-WindowsFact {
    <#
    .SYNOPSIS
        Returns all of Windows Facts.
    .DESCRIPTION
        Returns all of the Windows Facts from the included json file.
    .EXAMPLE
        PS> Get-WindowsFact

        Runs the command
    #>
    Get-Content  (Join-Path -Path $PSScriptRoot -ChildPath '../facts.json') | ConvertFrom-Json
}
