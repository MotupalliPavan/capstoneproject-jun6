resource "aws_security_group" "jenkins_sg" {
  name = "jenkins-security-group"

  ingress {
    description = "SSH - restricted"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["183.83.227.241/32"] 
  }

  ingress {
    description = "Jenkins UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["183.83.227.241/32"]
  }

  ingress {
    description = "App - Tomcat"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Restricted egress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]       
  }

  tags = {
    Name = "jenkins-security-group"
  }
}
