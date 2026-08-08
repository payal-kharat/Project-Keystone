variable "PROJECT_NAME" {
  type = string
}

variable "DB_IDENTIFIER" {
  type = string
}

variable "DB_NAME" {
  type = string
}

variable "DB_USERNAME" {
  type = string
}

variable "DB_PASSWORD" {
  type      = string
  sensitive = true
}

variable "DB_INSTANCE_CLASS" {
  type = string
}

variable "ALLOCATED_STORAGE" {
  type = number
}

# variable "ENGINE_VERSION" {
#   description = "MySQL Engine Version"
#   type = string
# }

variable "PRIVATE_DB_SUBNET_IDS" {
  type = list(string)
}

variable "RDS_SG_ID" {
  type = string
}