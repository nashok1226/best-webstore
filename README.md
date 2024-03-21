# tf-webstore

For executing the tf scripts, please follow the below steps:
(Can be run against any blank aws account, default VPC is not used)

1. Export the AWS credentails

    export AWS_ACCESS_KEY_ID="XXXX"
    export AWS_SECRET_ACCESS_KEY="XXXX"

2. To run the tf-code input the vars file ::  terraform  plan -var-file=best.tfvars

3. output will print the web url like:
    web_fqdn = "http://web-http-lb-xxxxxxxx.eu-central-1.elb.amazonaws.com"

4. Any modification on the input parameters could be made on the file "best.tfvars"

5. Any change in the user_data script on "ec2_install_apache.sh"
