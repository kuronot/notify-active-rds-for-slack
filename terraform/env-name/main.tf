data "aws_caller_identity" "self" {}
data "aws_region" "current" {}

output "account_id" {
  value = data.aws_caller_identity.self.account_id
}
output "aws_region" {
  value = data.aws_region.current.name
}


# Stop Active EC2 Instances
module "mo_stop-active-instance" {
  source = "../modules/stop-active-instance"

  chatbot_configuration_name = "notify-active-rds-chatbot"
  slack_channel_id           = "CXXXXXXXXXX"
  slack_workspace_id         = "TXXXXXXX"
  chatbot_role_name          = "notify-active-rds-role"
  chatbot_policy_name        = "notify-active-rds-policy"
  sns_topic_name             = "notify-active-rds-topic"
}

# Notify Active RDS
module "mo_notify-active-rds" {
  source = "../modules/notify-active-rds"

  cloudwatch_event_name = "notify-active-rds-event"
  sns_topic_arn         = module.mo_stop-active-instance.sns-topic.arn

}
