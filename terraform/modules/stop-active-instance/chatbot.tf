resource "awscc_chatbot_slack_channel_configuration" "notification" {
  configuration_name = var.chatbot_configuration_name
  iam_role_arn       = aws_iam_role.chatbot_role.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  sns_topic_arns     = [aws_sns_topic.this.arn]
}
