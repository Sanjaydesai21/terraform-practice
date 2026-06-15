variable "owners_id" {
  default = "099720109477"
}

variable "ingress_ssh" {
  default = 22
}

variable "ingress_http" {
  default = 80
}

variable "ingress_cidr" {
  default = "0.0.0.0/0"
}

variable "instance_type" {
  default = "t3.micro"
}
