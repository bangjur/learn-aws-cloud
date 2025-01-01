variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0e2c8caa4b6378d8c"
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.medium"
}

variable "volume_size" {
  description = "Size of EBS volume in GB"
  type        = number
  default     = 20
}

variable "volume_type" {
  description = "Type of EBS volume"
  type        = string
  default     = "gp3"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
  default     = "myS3Role"
}

variable "instance_tags" {
  description = "Tags for EC2 instances"
  type        = map(string)
  default = {
    webapp = "webapp-server1"
    db     = "db-server1"
  }
}