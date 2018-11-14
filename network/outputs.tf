output "vpc-id" {
  value = "${aws_vpc.vpc.id}"
}

output "public-a" {
  value = "${aws_subnet.public-a.id}"
}
output "public-b" {
  value = "${aws_subnet.public-b.id}"
}
output "private-a" {
  value = "${aws_subnet.private-a.id}"
}
output "private-b" {
  value = "${aws_subnet.private-b.id}"
}