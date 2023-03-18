output vpcid {
    value   = "${aws_vpc.default.id}"
}

output vpcname {
    value   = "${aws_vpc.default.tags.name}"
}

output all_public_subnets {
    value     = "${aws_subnet.public-subnets.*.id}"
}

output all_private_subnets {
    value     = "${aws_subnet.private-subnets.*.id}"
}

output sgid {
    value   = "${aws_security_group.allow_all.id}"
}

output env {
    value = "${aws_vpc.default.tags.environment}"
}

output nat_ids {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = "${aws_eip.nat_eip.*.id}"
}

output natgw_ids {
  description = "List of NAT Gateway IDs"
  value       = "${aws_nat_gateway.nat_gateway.*.id}"
}