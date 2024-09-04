variable "credentials" {
  type = object({
    region     = string
    assume_role_arn = string
  })

  default = {
    region = "us-east-1"
    assume_role_arn = "arn:aws:iam::920373028346:role/DevOpsNaNuvem"
  }
}

variable "tags" {
  type = object({
    Environment = string
    Project     = string 
  })

  default = {
    Environment = "production"
    Project     = "devops-na-nuvem"
  }
}

variable "vpc" {
  type = object({
    cidr_block = string
    name   = string
    internet_gateway_name = string
    nat_gateway_name = string
    public_route_table_name = string
    private_route_table_name = string
    public_subnets = list(object({
      cidr_block = string
      name = string
      availability_zone = string
      map_public_ip_on_launch = bool
    }))
    private_subnets = list(object({
      cidr_block = string
      name = string
      availability_zone = string
      map_public_ip_on_launch = bool
    }))
  })

  default = {
    cidr_block = "10.0.0.0/24"
    name = "devops-na-nuvem-vpc"
    internet_gateway_name = "devops-na-nuvem-igw"
    nat_gateway_name = "devops-na-nuvem-nat-gateway"
    public_route_table_name = "devops-na-nuvem-public-route-table"
    private_route_table_name = "devops-na-nuvem-private-route-table"
    public_subnets = [
      {
        cidr_block = "10.0.0.0/26"
        name = "devops-na-nuvem-public-subnet-us-east-1a"
        availability_zone = "us-east-1a"
        map_public_ip_on_launch = true
      },
      {
        cidr_block = "10.0.0.64/26"
        name = "devops-na-nuvem-public-subnet-us-east-1b"
        availability_zone = "us-east-1b"
        map_public_ip_on_launch = true
      }
    ]
    private_subnets = [
      {
        cidr_block = "10.0.0.128/26"
        name = "devops-na-nuvem-private-subnet-us-east-1a"
        availability_zone = "us-east-1a"
        map_public_ip_on_launch = false
      },
      {
        cidr_block = "10.0.0.192/26"
        name = "devops-na-nuvem-private-subnet-us-east-1b"
        availability_zone = "us-east-1b"
        map_public_ip_on_launch = false
      }
    ]
  }
}

variable "eks_cluster" {
  type = object({
    name = string
    access_config_authentication_mode = string
    enabled_cluster_log_types = list(string)
    role_name = string
    node_group = object({
      role_name = string
      instance_types = list(string)
      capacity_type = string
      scaling_config_desired_size = number
      scaling_config_max_size = number
      scaling_config_min_size = number
    })
  })

  default = {
    name = "devops-na-nuvem-eks-cluster"
    access_config_authentication_mode = "API_AND_CONFIG_MAP"
    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    role_name = "DevOpsNaNuvemEKSClusterRole"
    node_group = {
      role_name = "DevOpsNaNuvemEKSClusterNodeGroup"
      instance_types = ["t3.medium"]
      capacity_type = "ON_DEMAND"
      scaling_config_desired_size = 2
      scaling_config_max_size = 2
      scaling_config_min_size = 2
    }
  }
}