# notify-active-rds-for-slack
This solution is designed to prevent forgetting to stop RDS.

Slack will be notified when the following three conditions are met.

- When RDS is created
- When RDS starts up
- Automatic startup after 7 days of RDS outage

## Architecture
![image](https://user-images.githubusercontent.com/52056195/228822795-5555303b-0c94-4a67-9595-1661b918a4ba.png)

## Environment
- Terraform v1.0.0　
- aws-cli

## ファイル構成
```
$ stop-ec2-instance-from-slack# tree .
.
├── README.md
└── terraform
    ├── env-name
    │   ├── backend.tf
    │   ├── main.tf
    │   └── provider.tf
    └── modules
        ├── notify-active-rds
        │   ├── cloudwatch-event.tf
        │   └── variable.tf
        └── stop-active-instance
            ├── chatbot.tf
            ├── role.tf
            ├── sns.tf
            └── variable.tf
```

## Deploy AWS Resources
- AWS SNS
- AWS CloudWatchEvnets
- AWS ChatBot
  - It does not contain client settings.
- IAM Role,Policy

## Usage
### Advance preparation
- From the AWS console screen, configure the client settings for the Slack workspace that sends notifications.
  - reference：https://qiita.com/hayao_k/items/529539bbb07736ea0f41#aws-chatbot%E3%81%AE%E8%A8%AD%E5%AE%9A

### Terrafom Modules

```
module "mo_stop-active-instance" {
  source = "../modules/stop-active-instance"

  chatbot_configuration_name = "notify-active-rds-chatbot"
  slack_channel_id           = "CXXXXXXXXXX"
  slack_workspace_id         = "TXXXXXXX"
  chatbot_role_name          = "notify-active-rds-role"
  chatbot_policy_name        = "notify-active-rds-policy"
  sns_topic_name             = "notify-active-rds-topic"
}
```

```
module "mo_notify-active-rds" {
  source = "../modules/notify-active-rds"

  cloudwatch_event_name = "notify-active-rds-event"
  sns_topic_arn         = module.mo_stop-active-instance.sns-topic.arn
}
```

### Exec
Create AWS Resources
```
$ cd terraform/env-name
$ terraform init
$ terraform apply
```
Destroy AWS Resources
```
$ terraform destroy
```
