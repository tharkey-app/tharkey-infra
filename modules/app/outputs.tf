output "app_name" {
  value = "${var.app_name}"
}
output "name" {
  value = "${var.app_name}-${var.phase}"
}

output "bucket" {
  value = "${var.app_name}-static-${var.phase}"
}

output "domain" {
  value = "${var.domain}"
}

output "phase" {
  value = "${var.phase}"
}

output "subdomain" {
  value = "${var.phase}.${var.domain}"
}
