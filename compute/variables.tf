

variable "public-a" {
  description = "The public-a"
  type = "string"
}

variable "public-b" {
  description = "The public-b"
  type = "string"
}

variable "private-a" {
  description = "The private-a"
  type = "string"
}

variable "private-b" {
  description = "The private-b"
  type = "string"
}

variable "owner" {
  description = "The owner"
  type = "string"
}

variable "vpc-id" {
  description = "The vpc-id"
  type = "string"
}

variable "instance-name" {
  description = "The name for the AWS Instance"
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
  description = "Location of your public-key (/home/terraform/.ssh/id_rsa.pub)"
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
  description = "URL to Management Portal https://XXX-XXXXX.apiplatform.ocp.oraclecloud.com:443"
  type = "string"
}

variable "gateway-execution-mode" {
  description = "Execution mode of the gateway (Development)"
  type = "string"
}

variable "idcs-url" {
  description = "From My Services -> Users -> Link at the top has 'Identity Console' - ex. https://idcs-eaf9a9988034raeaf9987.identity.oraclecloud.com"
  type = "string"
}

variable "request-scope" {
  description = "https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-scope-oracle-api-platform-cloud-service-rest-apis.html - ex. https://7AAFJPO99997850D71EAE0BA.apiplatform.ocp.oraclecloud.com:443.apiplatform"
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

variable "gateway-id" {
  description = "Numeric value of the logical gateway (100)"
  type = "string"
}

variable "apics-token" {
  description = "From MyServices, select your apics instance, and you should have a 'Generate Access Token' link, copy in the token value from there.  This is only valid for a short time."
  type = "string"
}

#    gateway_user_pass: "Gateway1234"
#    gateway_manager_user: "avio.admin"
#    gateway_manager_pass: "chunky@8MoTIf"
#    gateway_manager_runtime_user: "avio.admin"
#    gateway_manager_runtime_pass: "chunky@8MoTIf"
#    # https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-your-client-id-and-client-secret.html
#    client_id: "7A29E0B76062424191DAE4ED71EAE0BA_APPID"
#    client_secret: "e1e439ec-1310-4445-8311-80ffd9cee2ef"
#    management_url: "https://apics-gse00015092.apiplatform.ocp.oraclecloud.com/apiplatform/management/v1"
#    gateway_id: "100"
#    my_token: "eyJ4NXQjUzI1NiI6IkNOdlZYM0xDcVdKaTFKUHVNWHE0dG1WdDRqcUh4NHR4MVVPQ1FBVHZ2SFUiLCJ4NXQiOiJ0VEtOc0NMUVItWDFLbHM3bHhkc1pxdHRjbGciLCJraWQiOiJTSUdOSU5HX0tFWSIsImFsZyI6IlJTMjU2In0.eyJ1c2VyX3R6IjoiQW1lcmljYVwvQ2hpY2FnbyIsInN1YiI6ImNsb3VkLmFkbWluIiwidXNlcl9sb2NhbGUiOiJlbiIsImlkcF9uYW1lIjoibG9jYWxJRFAiLCJ1c2VyLnRlbmFudC5uYW1lIjoiaWRjcy1lYWYwMzhhMzBmZGE0OTU0YjQ3MzkwOGFhMGYwNDAwNyIsImlkcF9ndWlkIjoibG9jYWxJRFAiLCJhbXIiOlsiVVNFUk5BTUVfUEFTU1dPUkQiXSwiaXNzIjoiaHR0cHM6XC9cL2lkZW50aXR5Lm9yYWNsZWNsb3VkLmNvbVwvIiwidXNlcl90ZW5hbnRuYW1lIjoiaWRjcy1lYWYwMzhhMzBmZGE0OTU0YjQ3MzkwOGFhMGYwNDAwNyIsImNsaWVudF9pZCI6IjdBMjlFMEI3NjA2MjQyNDE5MURBRTRFRDcxRUFFMEJBX0FQUElEIiwic3ViX3R5cGUiOiJ1c2VyIiwic2NvcGUiOiIuYXBpcGxhdGZvcm0iLCJjbGllbnRfdGVuYW50bmFtZSI6ImlkY3MtZWFmMDM4YTMwZmRhNDk1NGI0NzM5MDhhYTBmMDQwMDciLCJ1c2VyX2xhbmciOiJlbiIsImV4cCI6MTU0MjA0MTgwMSwiaWF0IjoxNTQyMDM4MjAxLCJjbGllbnRfZ3VpZCI6IjIxZDcwZjQ5MTVhZjQ2NzliM2FhZGVlYTBlMjA2ZjE5IiwiY2xpZW50X25hbWUiOiJBUElDU0FVVE9fYXBpY3MiLCJpZHBfdHlwZSI6IkxPQ0FMIiwidGVuYW50IjoiaWRjcy1lYWYwMzhhMzBmZGE0OTU0YjQ3MzkwOGFhMGYwNDAwNyIsImp0aSI6IjFlMTA1YWM3LWVlODMtNGYzMS05ZTk4LTczMWI0M2VlOGY2OSIsInVzZXJfZGlzcGxheW5hbWUiOiJDbG91ZCBBZG1pbiIsInN1Yl9tYXBwaW5nYXR0ciI6InVzZXJOYW1lIiwidG9rX3R5cGUiOiJBVCIsImF1ZCI6WyJodHRwczpcL1wvN0EyOUUwQjc2MDYyNDI0MTkxREFFNEVENzFFQUUwQkEuYXBpcGxhdGZvcm0ub2NwLm9yYWNsZWNsb3VkLmNvbTo0NDMiLCJ1cm46b3BjOmxiYWFzOmxvZ2ljYWxndWlkPTdBMjlFMEI3NjA2MjQyNDE5MURBRTRFRDcxRUFFMEJBIl0sInVzZXJfaWQiOiIwMDlmZjQ3MGRmMTQ0NjMwOTcxZmRlYzYyNTg3NjJkNCJ9.YgcY2ulEy6yLYi4T63oE-eKCf30HHgarm6NxaDZ0R5nnoYL6tlLoM0ADoHw0dA0ntGcE4WCZikHGSI7nlZzdonaGlDS1VKxX_hq4LDE_swq8nVuyHrx0GfgAsPpIVu_-Tw-yKXYAvE88Bzdcqy7EPf241h5NeDYX9Dhjxe7TJfrBZt2YPBmtxlw7lUwhXbPrUjCRAvnbTZILAuBM9IcR0gJp67b6qhDjc8bywlorN1kxjssByEj33k2Usn9O9d_odiECr9qnUFAcjXu_9h7ryeSrKAIXHVEXVtdYWv245JVtlb70O5_zHN-iQrwq22kqkHIZxdHVs-K5bfK1h1izxg"



