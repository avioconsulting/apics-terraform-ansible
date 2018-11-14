## #################################################################################
## AWS Properties
## #################################################################################
region = "us-west-2"
owner = "kking@avioconsulting.com"
secret-key = "waW98HyWjszRIxxsfRaRUoly8FTLPBHLQ6eI7"
access-key = "AKIAIWABCDEFYMRMMFRIQ"

## https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
ami = "ami-0ad99772"
instance-type = "m5.large"
public-key-location = "/home/terraform/.ssh/id_rsa.pub"


## #################################################################################
## Oracle APICS
## Log into management console, go to your Gateway, and click 'Installation Wizard'
## The first screen has these APICS values.
## #################################################################################

logical-gateway = "DEV-Gateway"
logical-gateway-id = "100"

# URL to Management Portal without the context root - ${url}/apigateway
management-service-url = "https://myinstance-gse00000001.apiplatform.ocp.oraclecloud.com:443"
gateway-execution-mode = "Development"

## From My Services -> Users -> Link at the top has 'Identity Console'
# Example "https://idcs-eaf9a9988034raeaf9987.identity.oraclecloud.com"
idcs-url = "https://idcs-XXXX.identity.oraclecloud.com"

## https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-scope-oracle-api-platform-cloud-service-rest-apis.html
# Example "https://7AAFJPOEF23497850D71EAE0BA.apiplatform.ocp.oraclecloud.com:443.apiplatform"
request-scope = "https://XXXX.apiplatform.ocp.oraclecloud.com:443.apiplatform"

## https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfad/finding-your-client-id-and-client-secret.html
# Example "REQUEST-SCOPE-PREFIX_APPID"
client-id = "7A29E0B76062424191DAE4ED71EAE0BA_APPID"
# Example: "abcd1234-0000-1922-0613-80abbcd9aac2ab"
client-secret = "abcd1234-0000-1922-0613-80abbcd9aac2ab"


## #################################################################################
## Ansible playbook variables for software installation and configuration
## #################################################################################

# A location to the installer zip (ApicsGatewayInstaller.zip) needs to be provided, login and download the installer from APICS management portal
download-url = "https://hostedurl/ApicsGatewayInstaller.zip"

# user defined when installing and configuring the node
gateway-user = "gatewayuser"
gateway-user-pass = "Gateway1234"

# APICS management API users - These are actual users defined in APICS
gateway-manager-user = "cloud.admin"
gateway-manager-pass = "changeme"
gateway-manager-runtime-user = "cloud.admin"
gateway-manager-runtime-pass = "changeme"

## https://docs.oracle.com/en/cloud/paas/api-platform-cloud/apfrm/Authentication.html
# Large token string from .tok file 
apics-token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX3R6IjoiQW1lcmljYS9DaGljYWdvIiwic3ViIjoiW1wbGUiLCJ0ZW5hbnQiOiJzYW1wbGUiLCJqdGkiOiJzYW1wbGUifQ"
