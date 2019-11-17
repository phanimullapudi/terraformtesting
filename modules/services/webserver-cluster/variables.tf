variable "server_port" {
    description = "The port the server will use for HTTP request"
    default = 8080
}

variable "cluster_name" {
    type        = string
    description = "Common naming standard for all the resources in the cluster"
}