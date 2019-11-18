provider "aws" {
    region = "us-west-2"
}

terraform {
  backend "s3" {}
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                       = 2
  identifier                  = "aurora-cluster-demo-${count.index}"
  cluster_identifier          = "${aws_rds_cluster.default.id}"  
  engine                       = var.engine
  engine_version               = var.engine-version
  instance_class               = var.instance_class
  publicly_accessible          = var.publicly_accessible
  db_subnet_group_name         = var.subnet_group_name
  db_parameter_group_name      = var.db_parameter_group_name
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  promotion_tier               = "0"
  performance_insights_enabled = var.performance_insights_enabled


  tags = {
    "Adobe.ArchPath" = "EC.Magento.PaaS.EKS"
    "Adobe.Environment" = "Perf"
    "Adobe.Owner" = "Magento PaaS Engineering"
    "Adobe.CostCenter" = "103060"
    "Adobe.PCIData" = "false"
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier                = "aurora-cluster-demo"
  availability_zones                = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name                     = "mydb"
  master_username                   = "dbadmin"
  master_password                   = "barbut8chars"
  final_snapshot_identifier         = "ci-aurora-cluster-backup"
  skip_final_snapshot               = true

  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window

  storage_encrypted                   = var.storage_encrypted
  apply_immediately                   = var.apply_immediately


}