# VPC-related variables
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = "vpc-078483a327ee4eadf"
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet"
  type        = string
  default     = "subnet-0ff23a4a90fcb3889"
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet"
  type        = string
  default     = "subnet-02ddf00f998da7c2e"
}

variable "internet_gateway_id" {
  description = "ID of the existing Internet Gateway"
  type        = string
  default     = "igw-016adff65e6f82909"
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
  default     = "sg-0a000f632454e2634"
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed for ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Name = "default-natgw"
  }
}