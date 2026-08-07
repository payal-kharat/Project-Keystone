variable "DB_NAME" {
  type = string
}
variable "DB_SUBNET_GROUP_NAME" {
  type = string
}
variable "DB_INSTANCE_NAME" {
  type = string
}
variable "DB_USERNAME" {
  type = string
}
variable "DB_PASSWORD" {
  type = string
}
variable "DB_ENGINE" {
  type = string
}
variable "DB_ENGINE_VERSION" {
  type = string
}
variable "DB_INSTANCE_CLASS" {
  type = string
}
variable "ALLOCATED_STORAGE" {
  type = number
}
variable "DB_STORAGE_TYPE" {
  type = string
}
variable "SUBNET_IDS" {
  type = list(string)
}
variable "SECURITY_GROUP_ID" {
  type = string
}
