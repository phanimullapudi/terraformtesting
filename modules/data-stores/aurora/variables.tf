variable "db_password" {
    description = "The password for the database"
}

variable "engine" {
  type        = string
  default     = "aurora"
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
}

variable "engine-version" {
  type        = string
  default     = "5.6.10a"
  description = "Aurora database engine version."
}

variable "instance_class" {
  type        = string
  default     = "db.r5.large"
  description = "Instance type to use"
}

variable "publicly_accessible" {
  type        = string
  default     = "false"
  description = "Whether the DB should have a public IP address"
}

variable "subnet_group_name" {
  type        = string
  default     = "default-vpc-d67418bf"
  description = "Name given to DB subnet group"

}

variable "db_parameter_group_name" {
  type        = string
  default     = "default.aurora5.6"
  description = "The name of a DB parameter group to use"
}

variable "db_cluster_parameter_group_name" {
  type        = string
  default     = "default.aurora5.6"
  description = "The name of a DB Cluster parameter group to use"
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sun:05:00-sun:06:00"
  description = "When to perform DB maintenance"
}

variable "apply_immediately" {
  type        = string
  default     = "false"
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
}

variable "auto_minor_version_upgrade" {
  type        = string
  default     = "false"
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
}

variable "performance_insights_enabled" {
  type        = string
  default     = false
  description = "Whether to enable Performance Insights"
}

variable "backup_retention_period" {
  type        = string
  default     = "7"
  description = "How long to keep backups for (in days)"
}

variable "preferred_backup_window" {
  type        = string
  default     = "02:00-03:00"
  description = "When to perform DB backups"
}

variable "storage_encrypted" {
  type        = string
  default     = "true"
  description = "Specifies whether the underlying storage layer should be encrypted"
}