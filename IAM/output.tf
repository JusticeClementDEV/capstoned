output "iam_role_id_permission_details" {
  value = aws_iam_role.capstone-role.permissions_boundary
}
output "iam_role_id_permission_details" {
  value = aws_iam_role.test_role.permissions_boundary

}
output "iam_role_id_permission_details" {
  value = aws_iam_role.capstone-role.assume_role_policy
}
output "iam_policy_detail" {
  value = aws_iam_role_policy.s3_policy_acl.id
}