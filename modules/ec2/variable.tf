variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "sg_name" {}
variable "allowed_cidr" {
  type = list(string)
}