resource "aws_subnet" "public-subnets" {
    count = "${length(var.public_subnets)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.public_subnets, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"
    tags = {
        Name = "public-subnet-${count.index+1}"
    }
}

resource "aws_subnet" "private-subnets" {
    count = "${length(var.private_subnets)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.private_subnets, count.index)}"
    availability_zone = "${element(var.azs, count.index)}"
    tags = {
        Name = "private-subnet-${count.index+1}"
    }
}



