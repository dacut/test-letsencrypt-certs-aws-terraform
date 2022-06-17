module "stack" {
  source       = "../../modules/stack"
  account_id   = local.account_id
  default_tags = local.default_tags
  region       = local.region
}
