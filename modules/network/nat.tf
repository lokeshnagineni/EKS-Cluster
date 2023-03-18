resource aws_eip nat_eip {
  count = min(length(var.azs), length(var.private_subnets))

  vpc = true

  tags = merge(
    {
      "Name" = format(
        "%s-${var.natgw_subnet_suffix}-%s",
        var.name,
        lower(substr(element(var.azs, count.index), -1, 1)),
      )
    }
  )
}

resource aws_nat_gateway nat_gateway {
  count = min(length(var.azs), length(var.private_subnets))

  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public-subnets.*.id, count.index)
  depends_on    = [aws_internet_gateway.default]

  tags = merge(
    {
      "Name" = format(
        "%s-%s",
        var.name,
        lower(substr(element(var.azs, count.index), -1, 1)),
      )
    }
  )
}

resource aws_route private_nat_gateway {
  count = min(length(var.azs), length(var.private_subnets))

  route_table_id         = element(aws_route_table.private-routing-table.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat_gateway.*.id, count.index)

  timeouts {
    create = "5m"
  }
}