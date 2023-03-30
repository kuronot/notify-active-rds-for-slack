resource "aws_cloudwatch_event_rule" "this" {
    name                = var.cloudwatch_event_name
    description         = "Notify Active RDS Start"
    event_pattern = <<EOF
{
  "source": ["aws.rds"],
  "detail-type": ["RDS DB Instance Event"],
  "detail": {
    "EventCategories": ["notification"],
    "SourceType": ["DB_INSTANCE", "CLUSTER"],
    "EventID": ["RDS-EVENT-0005", "RDS-EVENT-0088", "RDS-EVENT-0154"]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "this" {
    rule      = "${aws_cloudwatch_event_rule.this.name}"
    target_id = "ActiveRDS"
    arn       = var.sns_topic_arn
}
