provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "92837c13eadd6fa2f39d50f97223822e12609442"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2022-02-10 15:42:30"
    git_last_modified_by = "bobhlop@gmail.com"
    git_modifiers        = "bobhlop"
    git_org              = "BorisLevanov"
    git_repo             = "terragoat"
    yor_trace            = "c1ea6034-e2c6-4ddf-ad1f-4d7aa8ef2e7e"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "92837c13eadd6fa2f39d50f97223822e12609442"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2022-02-10 15:42:30"
    git_last_modified_by = "bobhlop@gmail.com"
    git_modifiers        = "bobhlop"
    git_org              = "BorisLevanov"
    git_repo             = "terragoat"
    yor_trace            = "91203aa0-c60e-4e79-bc02-e8c33ece2dc7"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
