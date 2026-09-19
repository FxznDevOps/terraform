variable "vpc_cidr" {
    type = string
  
}


variable "vpc_name" {
    type = string
  
}

variable "public_subnet" {
    type = list(string)
  
}

variable "azs" {
    type = string
  
}

variable "private_subnet" {
    type = list(string)
  
  
}