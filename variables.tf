variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "common_tags" {
    type = map
    default = {}
}
variable "vpc_tags" {
    type = map
    default = {}
}

variable "project_name" {
    default = {}
  
}
variable "envinorment" {
    default = {}
  
}
variable "ig_tags" {
  type = map
  default = {}
}

variable "public_subnet_cidr" {
    type = list 
    validation {
    condition   = length(var.public_subnet_cidr) == 2
    error_message = "please give 2 valid public cidr value"
}
} 
    variable "private_subnet_cidr" {
    type = list 
    validation {
    condition   = length(var.private_subnet_cidr) == 2
    error_message = "please give 2 valid private cidr value"
}
}

    variable "database_subnet_cidr" {
    type = list 
    validation {
    condition   = length(var.database_subnet_cidr) == 2
    error_message = "please give 2 valid private cidr value"
}
}
variable "public_subnet_tags" {
    type = map
  default = {}
}
variable "private_subnet_tags" {
  type = map   
  default = {}
}

variable "database_subnet_tags" {
  type = map
  default = {}
}

variable "nat_gateway_tags" {
  
  type = map
  default = {}
}

variable "route_table_pubic_tags" {
  type = map
  default = {}
}

variable "route_table_private_tags" {
  default = {}
}

variable "route_table_databse_tags" {
  default = {}
}

variable "is_peering_require" {
  type = bool
  default = false
}

variable "acceptor_vpc_id" {
  type = string
  default = ""

}

variable "peering_tags" {
  default = {}
  
}