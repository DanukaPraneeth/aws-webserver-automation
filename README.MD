# Instructions

## Prerequisites
1. Create the below file and update the AWS profile information for authentication

```
vi ~/.aws/credentials

[danuka]
aws_access_key_id = XXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXX
```

2. Based on the profile name you give in the above file, update the providers.tf file in the repo with the correct profile name
3. Terraform (from 0.13 onwards)


## How to run:
1. Clone the repo and go inside the downloaded repo
2. Check the vars.tf and update any of the required variable files
3. Default index.html file for the web server is availble in the folder called 'uploads'. If you need to change your default web page, update the html file inside this folder
4. Run the terraform script using below commands,
```
	terraform init
	terraform apply
```

5. At the end of the execution, the domain name of the load balancer will be displayed. You can use this domain name to validate the nginx web server	

## Note
- Sysytem architectural diagram of this deployment is available in the folder 'architecture'
- Below is the list of all the aws resources that get created from these terraform scripts
	- vpc x 1
	- subnet x 4
	- internet gateway x 1
	- NAT gateway x 1
	- Elastic IP x 1
	- route table x 2
	- security groups x 2
	- elastic load balancer x 1
	- aws_launch_configuration x 1
	- aws_autoscaling_group x 1
	- aws_autoscaling_policy x 1
	- aws_autoscaling_policy x 2
	- aws_cloudwatch_metric_alarm x 2
	- aws_s3_bucket x 1
	- aws_s3_object x 1
	- aws_iam_role x 1
	- aws_iam_instance_profile x 1
	- aws_iam_role_policy x 1
	
- Screen captured taken during my implementation are included inside the folder called 'screenshots'	
