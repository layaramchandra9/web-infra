variable "ami" {
  description = "AMI"
  default     = "ami-0a4a70bd98c6d6441"
}

variable "vpc_id" {
  description = "VPC"
  default     = "vpc-e0a09b88"
}

variable "subnet_id" {
  description = "Subnet"
  default     = "subnet-25cbeb4d"
}

variable "availability_zone_id" {
  description = "AZ used to create EC2 instances."
  default     = "ap-south-1a"
}

variable "region" {
  description = "region"
  default     = "ap-south-1"
}

variable "ingressrules" {
  type    = list(number)
  default = [80, 22]
}