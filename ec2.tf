provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webapp_server1" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Ubuntu 24.04 AMI
  instance_type = "t2.medium"
  subnet_id     = "subnet-0821ba00a02445cd4"  # Public subnet
  security_groups = ["sg-0677d504f0e8016e5"]  # Existing security group
  
  # Instance storage (EBS volume of 20GB)
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  # IAM Role (No key pair, using IAM role for instance profile)
  iam_instance_profile = "LabInstanceProfile"  # Or use "LabInstanceRole" if preferred

  tags = {
    Name = "webapp-server1"
  }
}

resource "aws_instance" "db_server1" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Ubuntu 24.04 AMI
  instance_type = "t2.medium"
  subnet_id     = "subnet-0b98b58a183f3061a"  # Private subnet
  security_groups = ["sg-0677d504f0e8016e5"]  # Existing security group

  # Instance storage (EBS volume of 20GB)
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  # IAM Role (No key pair, using IAM role for instance profile)
  iam_instance_profile = "LabInstanceProfile"  # Or use "LabInstanceRole" if preferred

  tags = {
    Name = "db-server1"
  }
}
