output "apics-node-1-host" {
  value = "${aws_instance.apics-node-1.public_dns}"
}

output "apics-node-2-host" {
  value = "${aws_instance.apics-node-2.public_dns}"
}