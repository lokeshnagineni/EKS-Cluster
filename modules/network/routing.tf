resource "aws_route_table" "public-routing-table" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
    tags = {
        Name = "${var.Main_Routing_Table}" 
    }
}

resource "aws_route_table" "private-routing-table" {
    vpc_id = "${aws_vpc.default.id}"
    tags = {
        Name = "${var.private_Routing_Table}"
    }   
}

resource "aws_route_table_association" "public-routing-assos" {
    count = "${length(var.public_subnets)}"
    subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.public-routing-table.id}"
}

resource "aws_route_table_association" "private-routing-assos" {
    count = "${length(var.private_subnets)}"
    subnet_id = "${element(aws_subnet.private-subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.private-routing-table.id}"
}
