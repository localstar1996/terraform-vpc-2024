### AWS VPC MODULE.

this modules create following resources, we are using HA, we are getting first 2az automatically.

* vpc 
* internet gateway with vpc association
* 2 public subnets in 1a nd 1b
* 2 privte subnets in 1a nd 1b 
* 2 database subnets in 1a nd 1b
* Elastic ip 
* NAT gateway in 1a public subnet
* public route table
* private route table 
* database route table 
* subnets and route table associations
* vpc peering if user requests 
* Adding the peering route in default vpc, if user don't provide acceptor vpc explicitly.
* Adding the peering routes in public, private and database route tables.



###  INPUTS

* project_name (REQUIRED) - Your project name
* envinormen (REQUIRED) - which envinorment you are working in.
* vpc cidr_block (OPTIONAL) - Default value is 10.0.0.0/16, user can over ride.
* enable_dns_hostnames (OPTIONAL) - Default value is true
* common_tags (OPTIONAL) - Better to provide
* vpc_tags  (OPTIONAL) - Default value is empty, type is map.
* igw_tags  (OPTIONAL) - Default value is empty, type is map.
* public_subnet_cidr (REQUIRED) - user must provide 2 vaild public subnet CIDR
* public_subnet_tags (OPTIONAL) - Default value is empty, type is map.
* private_subnet_cidr (REQUIRED) - user must provide 2 vaild privaate subnet CIDR
* private_subnet_tags (OPTIONAL) - Default value is empty, type is map.
* database_subnet_cidr (REQUIRED) -user must provide 2 vaild database subnet CIDR  
*  database_subnet_tags (OPTIONAL) - Default value is empty, type is map.
* nat_gateway_tags (OPTIONAL)  -  Default value is empty, type is map.
* route_table_pubic_tags (OPTIONAL) - Default value is empty, type is map.
* route_table_private_tags (OPTIONAL) - Default value is empty, type is map.
* route_table_databse_tags (OPTIONAL) - Default value is empty, type is map.
* is_peering_require - Default vaule is False 
* Acceptor_vpc_id (OPTIONAL) - Default value is default vpc id
* peering_tags (OPTIONAL) - Default value is empty, type is map.

## OUTPUTS 
 vpc_id = vpc id created 
 public_subnet_ids = 2 public subnet id created
 private_subnet_ids = 2 private subnet id created
 databse_subnet-ids = 2 database subnet id created