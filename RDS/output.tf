output "db_connection_string" {
  value = format("psql://%s:%s@%s:%s/%s", aws_db_capstone.example.username, aws_db_capstone.example.password, aws_db_capstone.example.endpoint, aws_db_capstone.example.port, aws_db_capstone.example.name)
}