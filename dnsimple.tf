provider "dnsimple" {
  token = "oH9EvZWAfcQDIphIqyS"
  email = "dnsimple@loweschmidt.se"
}

resource "dnsimple_record" "demo" {
  domain = "loweschmidt.se"
  name   = "demo"
  value  = "${aws_elb.demo.dns_name}"
  type   = "CNAME"
  ttl    = "3600"
}
