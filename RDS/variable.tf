variable "engine" {
  type = string
  default = "PostgreSQL"
}

variable "engine_version" {
  type = string
  default  = "5.7"
}

variable "db_instance_class" {
  type = string
  default = "db.t2.micro"
}

variable "db_instance_name" {
  type = string
  default = "capstone-db"

}
#psql://postgres:postgres@terraform-20230415183552794000000001.chr0d0l6vzpl.us-east-1.rds.amazonaws.com:5432/

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
  default = "Capstone_DB"
  description = "This is a name used to identify the snapshot to be reused by a new RDS"
}