variable "access_key" {
  type = string
  description = "Access key for AWS account "
  sensitive = true
}

variable "secret_key" {
  type = string
  description = "Secret key for AWS account "
  sensitive = true
}

variable "aws_region" {
  type        = string
  description = "Region for AWS Resources"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}


variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "subnet_cidr_block" {
  type        = string
  description = "Base CIDR Block For Subnet "
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_block_private1" {
  type        = string
  description = "Base CIDR Block For Subnet "
  default     = "10.0.2.0/24"
}
variable "subnet_cidr_block_private2" {
  type        = string
  description = "Base CIDR Block For Subnet "
  default     = "10.0.3.0/24"
}
variable "aws_avail_zone1" {
  type        = string
  description = "Avaialability Zone 1 for AWS Subnet"
  default     = "us-east-1a"
}
variable "aws_avail_zone2" {
  type        = string
  description = "Avaialability Zone 2 for AWS Subnet"
  default     = "us-east-1b"
}
variable "private_ip" {
  type        = string
  description = "Private IP For Network Card Interface "
  default     = "10.0.1.50"
}
variable "ami_image" {
    type = string
    description = "Ubuntu AMI For EC2"
    default = "ami-0c4f7023847b90238"
  
}

variable "key_pem" {
    type = string
    default = "website-key"
  
}

variable "inst_class" {
    type = string
    default = "db.t3.micro"
  
}

variable "user_name" {
  type = string 
  description = "Username for the Database"
}

variable "pass" {
  type = string 
  description = "Password for the Database"
}

variable "sender_email" {
  type = string 
  default = ""
}
variable "receiver_email" {
  type = string 
  default = ""
}
