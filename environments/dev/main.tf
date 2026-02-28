module "ec2" {
  source = "../../modules/ec2"

  ami            = "ami-0c02fb55956c7d316"
  instance_type  = "t2.micro"
  instance_name  = "dev-terraform-instance"
  sg_name        = "dev-terraform-sg"
  allowed_cidr   = ["0.0.0.0/0"]
}

output "public_ip" {
  value = module.ec2.public_ip
}