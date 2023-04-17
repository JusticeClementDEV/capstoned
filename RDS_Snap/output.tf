output "db_connection_string" {
  value = format("psql://%s:%s@%s:%s/%s", aws_db_instance.capstone.username, aws_db_instance.capstone.password, aws_db_instance.capstone.endpoint, aws_db_instance.capstone.port, aws_db_instance.capstone.name)
}