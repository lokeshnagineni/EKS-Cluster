output all_public_subnets {
    value   = "${module.testenv.all_public_subnets}"
}

output all_private_subnets {
    value   = "${module.testenv.all_private_subnets}"
}

output sgid {
    value   = "${module.testenv.sgid}"
}

output env {
     value  = "${module.testenv.env}"
}


