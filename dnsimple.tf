provider "dnsimple" {
  token = ""
  email = ""
}

resource "dnsimple_record" "demo" {
  domain = "slashignore.it"
  name   = "just"
  value  = "${aws_elb.demo.dns_name}"
  type   = "CNAME"
  ttl    = "3600"
}

output "DNS Record" {
  value = "${dnsimple_record.demo.hostname}"
}
