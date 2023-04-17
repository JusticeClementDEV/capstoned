variable "region"{
    type = string(any)
    
}
variable "profile" {
  type = string(any)
}

variable "key_name" {
  type = string(any)
}

variable "ami_id"{
    type =  string(any)
}

variable "instance_type" {
   type = string(any)
}

variable "tags" {
  type = map(string)
}