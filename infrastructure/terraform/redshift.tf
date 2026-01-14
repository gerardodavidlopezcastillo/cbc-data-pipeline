# Subnet Group para Redshift
resource "aws_redshift_subnet_group" "cbcmobility_subnet_group" {
  name        = "${var.prefix}-subnet-group"
  description = "Subnet group for CBC Mobility Redshift cluster"
  subnet_ids = [
    "subnet-00c52eee0b5226053",
    "subnet-0eaffef0f194c1de9"
  ]

  tags = {
    Name        = "${var.prefix}-redshift-subnet-group"
    Environment = var.environment
  }
}

# Creamos el cluster basico de Redshift
resource "aws_redshift_cluster" "cbcmobility_cluster" {
  cluster_identifier  = "${var.prefix}-cluster"
  database_name       = "${var.prefix}_db"
  master_username     = var.redshift_username
  master_password     = var.redshift_password
  node_type           = "ra3.large"
  cluster_type        = "single-node"
  publicly_accessible = true

  cluster_subnet_group_name = aws_redshift_subnet_group.cbcmobility_subnet_group.name

  iam_roles = [
    aws_iam_role.redshift_role.arn
  ]

  tags = {
    Name        = "${var.prefix}-redshift-cluster"
    Environment = var.environment
  }
}
