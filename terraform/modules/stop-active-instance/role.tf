##################################
##Chatbotのロール
##################################
resource "aws_iam_role" "chatbot_role" {
  name               = var.chatbot_role_name
  description        = "Chatbot Role for Notify RDS."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "chatbot.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

##################################
##ポリシーアタッチ
##################################
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.chatbot_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
