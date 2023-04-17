variable "engine" {
  type = string
  default = "postgres"
}

variable "engine_version" {
  type = string
  default  = "10.17"
}

variable "db_instance_class" {
  type = string
  default = "db.t2.micro"
}

variable "db_instance_name" {
  type = string
  default = "capstonedb"

}

variable "username"{
    type = string
    default = "postgres"
}
variable "password" {
  type = string
  default = "postgres"
}

variable "storage_type"{
    type = string
    default = "gp2"
}

variable "snapshot_ID" {
  type = string
  default = "ReelcruitSnapDB"
  description = "This is a name used to identify the snapshot to be reused by a new RDS"
}