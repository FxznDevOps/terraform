variable "ec2_ami" {
    type = string
  
}


variable "inst_type" {
    type = string
  
}



variable "subnet_id" {
    type = string
  
}

variable "servername" {
    type = string
  
}





variable "vpc_id1" {
    type = string
  
}


variable "ingress_rules" {
  
  default = [
    {port = "22" , protocol = "tcp" , cidr_blocks ="0.0.0.0/32"},
    {port = "80" , protocol = "tcp" , cidr_blocks ="0.0.0.0/32"},
  ]
}