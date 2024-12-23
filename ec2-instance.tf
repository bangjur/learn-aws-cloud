# Create two EC2 instances, each on private and public subnet.

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webapp_server1" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Ubuntu 24.04 AMI
  instance_type = "t2.medium"
  subnet_id     = "subnet-07e04cdf75d50469b"  # Public subnet
  security_groups = ["sg-03c7dfa36ab3dafca"]  # Existing security group
  
  user_data = file("setup-script.sh")

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
  subnet_id     = "subnet-0f608aef51cc73a45"  # Private subnet
  security_groups = ["sg-03c7dfa36ab3dafca"]  # Existing security group

  user_data = file("setup-script.sh")

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
