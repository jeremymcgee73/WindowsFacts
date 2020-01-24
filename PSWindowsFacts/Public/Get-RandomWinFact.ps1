
Function Get-RandomWinFact {
    <#
    .SYNOPSIS
        Returns a random windows fact.
    .DESCRIPTION
        Returns a random windows fact.
    .EXAMPLE
        PS> Get-RandomWinFact

        Runs the command
    #>

    $facts = Get-WindowsFact
    $randomNum = ((Get-Random -Minimum 0 -Maximum ($facts).count) - 1)
    $facts[$RandomNum]

}
