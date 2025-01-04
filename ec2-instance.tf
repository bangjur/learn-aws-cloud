# Create two EC2 instances, each on private and public subnet.

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webapp_server1" {
  ami           = var.instance_ami # Ubuntu 24.04 AMI
  instance_type = "t2.medium"
  subnet_id     = var.public_subnet_id  # Public subnet
  security_groups = [var.security_group_id]  # Existing security group
  
  user_data = file("setup-ec2.sh")

  # Instance storage (EBS volume of 20GB)
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  # IAM Role (No key pair, using IAM role for instance profile)
  iam_instance_profile = var.iam_instance_profile  # Or use "LabInstanceRole" if preferred

  tags = {
    Name = "webapp-server1"
  }
}

resource "aws_instance" "db_server1" {
  ami           = var.instance_ami  # Ubuntu 24.04 AMI
  instance_type = "t2.medium"
  subnet_id     = var.private_subnet_id  # Private subnet
  security_groups = [var.security_group_id]  # Existing security group

  user_data = file("setup-ec2.sh")

  # Instance storage (EBS volume of 20GB)
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  # IAM Role (No key pair, using IAM role for instance profile)
  iam_instance_profile = var.iam_instance_profile  # Or use "LabInstanceRole" if preferred

  tags = {
    Name = "db-server1"
  }
}

resource "aws_instance" "bastion_host" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Ubuntu 24.04 AMI
  instance_type = "t2.micro"               # Small instance for bastion
  subnet_id     = var.public_subnet_id     # Place in the public subnet
  security_groups = [var.security_group_id] # Use an existing security group

  user_data = file("setup-ec2.sh")
  
  tags = {
    Name = "BastionHost"
  }
}
