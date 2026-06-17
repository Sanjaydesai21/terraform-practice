variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1a_cidr" {
  default = "10.0.0.0/24"
}

variable "public_subnet_az_1a" {
  default = "ap-south-1a"
}

variable "public_subnet_2b_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_az_2b" {
  default = "ap-south-1b"
}

variable "private_subnet_1a_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_az_1a" {
  default = "ap-south-1a"
}

variable "private_subnet_2b_cidr" {
  default = "10.0.3.0/24"
}

variable "private_subnet_az_2b" {
  default = "ap-south-1b"
}

variable "ami" {
  default = "ami-01a00762f46d584a1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "mykey"
}

