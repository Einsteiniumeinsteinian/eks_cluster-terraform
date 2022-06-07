variable "access_key" {}

variable "secret_key" {}

variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "eksCluster" {
  type = object({
    name : string
    version : string
  })

  default = {
    local_name = "value"
    name       = "einstein"
    version    = "1.21"
  }
}

variable "nodeGroup" {
  type = object({
    name : string
    node_group_type : string
    desired_size : number
    max_size : number
    min_size : number
    ami_type : string
    instance_types : list(string)
    capacity_type : string
    disk_size : number
  })
  default = {
    ami_type        = "AL2_x86_64"
    capacity_type   = "ON_DEMAND"
    desired_size    = 2
    disk_size       = 10
    instance_types  = ["t3.micro"]
    max_size        = 2
    min_size        = 2
    name            = "einstein"
    node_group_type = "t3_micro"
  }
}
