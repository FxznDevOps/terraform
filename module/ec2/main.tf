resource "aws_instance" "webserver" {

    ami = var.ec2_ami
    instance_type = var.inst_type
    key_name = "Docker"

    subnet_id = var.subnet_id

    root_block_device {
      volume_size = 8
    }
  
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  
  tags = {
    Name = var.servername
  }

}


resource "aws_security_group" "ec2_sg" {
  vpc_id      = var.vpc_id1

  
  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}
