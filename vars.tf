# Variables for Netwok creation

variable "cidr_block_vpc" {
  description = "Network CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "cidr_block_public_subnet_1" {
  description = "Network CIDR for the Public subnet 1"
  type        = string
  default     = "10.0.0.0/26"
}

variable "cidr_block_public_subnet_2" {
  description = "Network CIDR for the Public subnet 2"
  type        = string
  default     = "10.0.0.64/26"
}

variable "cidr_block_private_subnet_1" {
  description = "Network CIDR for the Private subnet 1"
  type        = string
  default     = "10.0.0.128/26"
}

variable "cidr_block_private_subnet_2" {
  description = "Network CIDR for the Private subnet 2"
  type        = string
  default     = "10.0.0.192/26"
}

variable "az_1" {
  description = "AWS availability zone 1 to create the resources"
  type        = string
  default     = "eu-west-1a"
}

variable "az_2" {
  description = "AWS availability zone 2 to create the resources"
  type        = string
  default     = "eu-west-1b"
}


# Variables for Security Groups

variable "lb_security_group" {
  description = "Name of the security group for the lb layer"
  type        = string
  default     = "elb_security_group"
}

variable "ec2_security_group" {
  description = "Name of the security group for the web application layer"
  type        = string
  default     = "webapp_security_group"
}


# Variables for Load Balancer

variable "lb_name" {
  description = "Name of the load balancer resource"
  type        = string
  default     = "web-elb"
}

variable "lb_port" {
  description = "Load balancer running port"
  type        = number
  default     = 80
}

variable "application_port" {
  description = "Application running port"
  type        = number
  default     = 80
}


# EC2 instance scaleset Variables

variable "web_server_name" {
  description = "Name of the Web Application"
  type        = string
  default     = "Myweb"
}

variable "image_id" {
  type    = string
  default = "ami-00c90dbdc12232b58"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_min_count" {
  type    = number
  default = 1
}

variable "ec2_max_count" {
  type    = number
  default = 3
}

variable "ec2_normal_count" {
  type    = number
  default = 2
}

variable "ssh_key" {
  type    = string
  default = "west-eur-key"
}



# IAM Role Variables

variable "iam_role" {
  description = "IAM Role Name"
  type        = string
  default     = "app_iam_role"
}

variable "iam_profile" {
  description = "IAM Profile Name"
  type        = string
  default     = "app_instance_profile"
}


variable "iam_policy" {
  description = "IAM Policy Name"
  type        = string
  default     = "app_iam_role_policy"
}

