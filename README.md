# tf-webstore

- This repo will cretae one EC2 from the EC2 module (task-1) and 2 EC2 instances (task-2) from the ASG Module
- To demonstrate S3 access, final webpage will fetch files from S3 whihc will also be created 
- output will print the web url like: (Might take few seconds to server traffic)
      - web_fqdn = "http://web-http-lb-xxxxxxxx.eu-central-1.elb.amazonaws.com"
- Any modification on the input parameters could be made on the file "best.tfvars"
- Although .tfvars file should not be included in public repo, I have included for demo purpose and have no sensitive informations
- For executing the tf scripts, please follow the below steps: (Can be run against any blank aws account, default VPC is not used)
    1. Export the AWS credentials
        - export AWS_ACCESS_KEY_ID="XXXX"
        - export AWS_SECRET_ACCESS_KEY="XXXX"

    2. To run the tf-code input the vars file:
        - terraform init
        - terraform apply -var-file=best.tfvars
