data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name = "state"
    values = [ "available" ]
  }

  filter {
    name = "name"
    values = [ "ubuntu-*-amd64-*" ]
  }
}

resource "aws_key_pair" "keys" {
  key_name = "bankapp-automation-key"
  public_key = file("bankapp-automation-key.pub")
}

resource "aws_default_vpc" "ec2_default" {
  
}

resource "aws_security_group" "allow_user_to_connect" {
  name = "allow TSL"
  description = "Allow users to connect"
  vpc_id = aws_default_vpc.ec2_default.id
  ingress {
    description = "port 22 allow ssh"
    to_port = "22"
    from_port = "22"
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    description = "Allow all outgoing traffic"
    to_port = "0"
    from_port = "0"
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "Port 80 allow http"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    description = "Port 443 allow https"
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "bankapp-security"
  }
}

resource "aws_instance" "appinstance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.keys.key_name
  security_groups = [ aws_security_group.allow_user_to_connect.name ]
  tags = {
    Name = "Bankapp-Automation-Server"
  }
  root_block_device {
    volume_size = "30"
    volume_type = "gp3"
  }
}