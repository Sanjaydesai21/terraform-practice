variable "ubuntu_owners_id" {
  default = "099720109477"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_sub_cidr" {
  default = "10.0.0.0/24"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "private_sub_cidr" {
  default = "10.0.16.0/24"
}

variable "rt_cidr" {
  default = "0.0.0.0/0"
}

variable "ssh_port" {
  default = 22
}

variable "http_port" {
  default = 80
}

variable "instance_type" {
  default = "t3.micro"
}
