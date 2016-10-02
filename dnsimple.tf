provider "dnsimple" {
  token = "CIgUGFynuCm3Frv4Jt1TKZJnLa2bRwDp"
  email = "dnsimple@loweschmidt.se"
}

resource "dnsimple_record" "demo" {
  domain = "loweschmidt.se"
  name   = "demo"
  value  = "${aws_alb.demo.dns_name}"
  type   = "CNAME"
  ttl    = "3600"
}
