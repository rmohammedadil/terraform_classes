variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  # default     = "t3.micro"
}

variable "ami" {
  type        = string
  description = "EC2 ami  for the web server"
  # default     = "ami-0fb110df4c5094d21"
}

variable "ami_west2" {
  type        = string
  description = "EC2 ami  for the web server in west 2"
  # default     = "ami-02167eae61967e403"
}