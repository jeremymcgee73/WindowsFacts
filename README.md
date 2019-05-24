# WindowsFacts
An API to get Windows Facts. This is written in PowerShell using AWS Lambda / API Gateway.


## Description
This is a project for an API to deliver Windows Facts... really for entertainment. I have wanting to build an API using PowerShell and AWS Lambda for awhile now. So here it is. The current URL is temporary until the domain registration goes through. This is mostly going to be a place for me to get better at CI/CD, AWS and testing. I am hopeful the community will submit PRs to add more facts! 😃

Thanks to [Josh Rickard](https://github.com/MSAdministrator) for the idea!


```powershell
Invoke-RestMethod https://api.windowsfacts.com/fact

Invoke-RestMethod https://api.windowsfacts.com/factcount
```
