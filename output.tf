// output "subnet_a" {
//
//   value = data.aws_subnet.internal_a
// }

output "vpc" {
  value = data.aws_vpc.vpc.id
}
