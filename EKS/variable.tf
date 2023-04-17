variable "eks_cluster_name" {
  type = string
  default = "capstone"
}
variable "eks_nodegroup_name" {
  type = string
  default = "capstone-workers"
}
variable "eks_workers_subnet_id" {
  type = list(string)
  default =  ["subnet-03aacbed8fdf11c42", "subnet-042a0dae2ee2d68dc", "subnet-0c777d4fb163ba2c0"]
}

variable "eks_workers_asg"{
    type = map(string)
    default = {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

}
variable "subnet_ids" {
  type = list(string)
  default = 
}