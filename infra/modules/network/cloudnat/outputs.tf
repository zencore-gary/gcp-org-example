output "nat_ip" {
  value       = { for ip in google_compute_address.ext_ip : ip.address => ip }
  description = "NAT gateway IPs"
}
