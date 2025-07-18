variable "aws_region" {
  description = "aws_region"
  default = "eu-west-1"
}

variable "instance_type" {
  description = "value"
  default = "t2.large"
}

variable "my_environment" {
  description = "which config required for instance"
  default = "dev"
}