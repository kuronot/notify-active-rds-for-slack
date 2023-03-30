resource "aws_sns_topic" "this" {
  name = var.sns_topic_name
  lifecycle {
    ignore_changes = [
      policy
    ]
  }
}

output sns-topic {
  value       = aws_sns_topic.this

}
