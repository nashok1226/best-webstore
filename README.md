# tf-webstore

For executing the tf scripts, please follow the below steps:

1. Export the AWs credentails

    export AWS_ACCESS_KEY_ID="XXXX"
    export AWS_SECRET_ACCESS_KEY="XXXX"

2. terraform  plan -var-file=best.tfvars

3. output will print the web url like:
    web_fqdn = "http://web-http-lb-596885706.eu-central-1.elb.amazonaws.com"