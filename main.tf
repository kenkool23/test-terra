terraform {
  backend "s3" {
    bucket = "terraform-fbjhvfiys"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_instance" "web" {
  ami           = var.my_image
  instance_type = var.my_type
  key_name = "newKeyOhio"
  security_groups = [aws_security_group.terra_sg.name]
  tags = {
    Name = var.my_tag
  }
}

resource "aws_security_group" "terra_sg" {
  name        = "allow_ports"
  description = "Allow Some ports"

  ingress {
    description      = "Custom sg"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Custom sg2"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.my_tag
  }
}

# Database ...