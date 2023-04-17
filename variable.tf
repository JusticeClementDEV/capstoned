variable "engine" {
  type = string
}

variable "engine_version" {
  type = string

}

variable "db_instance_class" {
  type = string

}

variable "db_instance_name" {
  type = string


}

variable "username"{
    type = string

}
variable "password" {
  type = string
}

variable "storage_type"{
    type = string
}

variable "snapshot_ID" {
  type = string
  description = "This is a name used to identify the snapshot to be reused by a new RDS"
}