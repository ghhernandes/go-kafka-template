resource "aws_msk_serverless_cluster" "msk_cluster" {
  cluster_name = "twitchapi-cluster"

  vpc_config {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.sg.id]
  }

  client_authentication {
    sasl {
      iam {
        enabled = true
      }
    }
  }
}
