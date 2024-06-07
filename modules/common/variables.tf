variable "project_id" {
  description = "The ID of the project where the resources will be created."
  type        = string
  default     = "itsme-1234"
}

variable "region" {
  description = "The region where the resources will be created."
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "The name of the VPC network."
  type        = string
  default     = "vendorvpc0000"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC network."
  type        = string
  default     = "10.0.0.0/16"
} 

variable "public_subnets" {
  description = "A list of maps describing the public subnets."
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "vendorvpc-publicsubnet0000"
      cidr = "10.0.1.0/24"
    }
  ]
}

variable "private_subnets" {
  description = "A list of maps describing the private subnets."
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "vendorvpc-privatesubnet0000"
      cidr = "10.0.3.0/24"
    }
  ]
}

variable "service_account_email" {
  description = "The email of the service account to which the IAM roles will be assigned."
  type        = string
  default  = "jyotikarki99160@gmail.com"
}