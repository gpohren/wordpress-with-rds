variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS Profile"
  default     = "main"
}

variable "ami" {
  description = "Ubuntu, 20.04 LTS"
  default     = "ami-0261755bbcb8c4a84"
}

variable "instance_micro" {
  description = "Instance type micro"
  default     = "t2.micro"
}

variable "aws_key_path" {
  description = "Key path"
  default     = "../../keys/aws_key.pub"
}
