New-AWSPowerShellLambdaPackage -ScriptPath PSWindowsFact.ps1 -OutputPackage PSWindowsFact.zip
aws cloudformation package --template-file serverless.template --s3-bucket windowsfacts-cf --output-template-file windowsfacts.template
aws cloudformation deploy --template-file windowsfacts.template --stack-name PSWindowsFact --capabilities CAPABILITY_IAM