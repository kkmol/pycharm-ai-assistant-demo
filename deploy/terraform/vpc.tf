data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc.eu-west-2"]
  }
}
