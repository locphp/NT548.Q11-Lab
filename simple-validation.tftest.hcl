# Simple validation test - just check if resources exist
run "validate_vpc" {
  command = plan

  assert {
    condition     = output.VPC.vpc_id != ""
    error_message = "VPC ID should not be empty"
  }

  assert {
    condition     = output.VPC.public_subnet_id != ""
    error_message = "Public subnet should exist"
  }

  assert {
    condition     = output.VPC.private_subnet_id != ""
    error_message = "Private subnet should exist"
  }

  assert {
    condition     = output.VPC.internet_gateway_id != ""
    error_message = "Internet Gateway should exist"
  }
}

run "validate_nat" {
  command = plan

  assert {
    condition     = output.NAT.nat_gateway_id != ""
    error_message = "NAT Gateway should exist"
  }
}

run "validate_route_tables" {
  command = plan

  assert {
    condition     = output.Route_Table.route_table_association_public != ""
    error_message = "Public route table association should exist"
  }

  assert {
    condition     = output.Route_Table.route_table_association_private != ""
    error_message = "Private route table association should exist"
  }
}

run "validate_security_groups" {
  command = plan

  assert {
    condition     = output.security_group.public_security_group_id != ""
    error_message = "Public security group should exist"
  }

  assert {
    condition     = output.security_group.private_security_group_id != ""
    error_message = "Private security group should exist"
  }
}

run "validate_ec2" {
  command = plan

  assert {
    condition     = output.EC2.public_instance_id != ""
    error_message = "Public EC2 instance should exist"
  }

  assert {
    condition     = output.EC2.private_instance_id != ""
    error_message = "Private EC2 instance should exist"
  }

  assert {
    condition     = output.EC2.public_instance_public_ip != ""
    error_message = "Public instance should have a public IP"
  }

  assert {
    condition     = output.EC2.private_instance_private_ip != ""
    error_message = "Private instance should have a private IP"
  }
}
