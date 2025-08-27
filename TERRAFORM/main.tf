# -------------------------------
# Security Group
# -------------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group-darshan"
  description = "Allow SSH, HTTP, and custom app port"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow custom app port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -------------------------------
# Application Node
# -------------------------------
resource "aws_instance" "application_node" {
  ami                    = "ami-0a716d3f3b16d290c"
  instance_type          = "t3.micro"
  key_name               = "darshan-8"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Darshan_Application_Node"
  }
}

# -------------------------------
# Jenkins Master Node
# -------------------------------
resource "aws_instance" "jenkins_master" {
  ami                    = "ami-0a716d3f3b16d290c"
  instance_type          = "t3.micro"
  key_name               = "darshan-8"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Darshan_Jenkins_Master"
  }
}
