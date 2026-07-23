resource "aws_instance" "jenkins_server" {

  ami                    = var.ami_id

  instance_type          = var.instance_type

  key_name               = var.key_name

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {

    Name = "Capstone-Server"

  }

}
