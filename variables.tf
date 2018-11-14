# ################################
# AWS variables
# ################################
variable "region" {
  description = "The AWS region for the resources to be created in"
  type = "string"
}

variable "owner" {
  description = "Owner of the resources"
  type = "string"
}

variable "secret-key" {
  description = "AWS Secret Key"
  type = "string"
}

variable "access-key" {
  description = "AWS Access Key"
  type = "string"
}

variable "ami" {
  description = "The AWS AMI (ami-0ad99772)"
  type = "string"
}

variable "instance-type" {
  description = "The AWS EC2 instance type (m5.large)"
  type = "string"
}

variable "public-key-location" {
  description = "Location of your public-key (/home/terraform/.ssh/id-rsa.pub)"
  type = "string"
}


# ################################
# APICS variables
# ################################
variable "logical-gateway" {
  description = "Name of the logical gateway in APICS"
  type = "string"
}

variable "logical-gateway-id" {
  description = "Numeric value of the logical gateway in APICS"
  type = "string"
}

variable "management-service-url" {
  description = ""
  type = "string"
}

variable "gateway-execution-mode" {
  description = "Execution mode of the gateway (Development)"
  type = "string"
}

variable "idcs-url" {
  description = ""
  type = "string"
}

variable "request-scope" {
  description = "https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-scope-oracle-api-platform-cloud-service-rest-apis.html"
  type = "string"
}

# ################################
# Ansible Playbook variables for node installation
# ################################
variable "download-url" {
  description = "Location of the ApicsGatewayInstaller.zip"
  type = "string"
}

variable "gateway-user" {
  description = "Gateway user created during node configuration (gatewayuser)"
  type = "string"
}

variable "gateway-user-pass" {
  description = "Gateway user password used in creation of the gateway user (Gateway1234)"
  type = "string"
}

variable "gateway-manager-user" {
  description = "APICS management API user defined in APICS (cloud.admin)"
  type = "string"
}

variable "gateway-manager-pass" {
  description = "APICS management API user password defined in APICS"
  type = "string"
}

variable "gateway-manager-runtime-user" {
  description = "APICS management API runtime user defined in APICS"
  type = "string"
}

variable "gateway-manager-runtime-pass" {
  description = "APICS management API runtime user password defined in APICS"
  type = "string"
}

variable "client-id" {
  description = "https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-your-client-id-and-client-secret.html"
  type = "string"
}

variable "client-secret" {
  description = "https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-your-client-id-and-client-secret.html"
  type = "string"
}

variable "apics-token" {
  description = "From MyServices, select your apics instance, and you should have a 'Generate Access Token' link, copy in the token value from there.  This is only valid for a short time."
  type = "string"
}

