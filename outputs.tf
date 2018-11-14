output "vpc-id" {
  value = "${module.network.vpc-id}"
}

output "apics-host1" {
  value = "${module.compute.apics-node-1-host}"
}

output "apics-host2" {
  value = "${module.compute.apics-node-2-host}"
}
