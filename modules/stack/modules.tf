module "storage" {
  source    = "../storage"
  partition = data.aws_partition.current.partition
  suffix    = var.suffix

  providers = {
    aws    = aws
    random = random
  }
}
