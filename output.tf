output "ec2_id"{
  value = "${aws_instance.ec2.id}"
}
output "SG_ec2" {
  value = "${aws_security_group.SG_ec2.id}"
}
output "SG_elb" {
 value = "${aws_security_group.SG_elb.id}"
}
output "DNS" {
  value = "${aws_elb.apachephp.dns_name}"
}
