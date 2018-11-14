# Automating the Creation of APICS Gateway Nodes using Terraform and Ansible on AWS

## Summary

Check out the blog [Automating the Creation of APICS Gateway Nodes using Terraform and Ansible on AWS](https://www.avioconsulting.com/blog/)

The project here, is a functional example of using Terraform and the [AWS API](https://www.terraform.io/docs/providers/aws/) to create an infrasture which includes 2 compute nodes, a load balancer, and the networking required, including private and public subnets, and security roles. 

Ansible playbooks are being invoked from Terraform after the creation of the compute instance.  Ansible will install and configure Java, and then install an API Gateway node and register it to APICS.

## Pre-Requisites

Basic knowledge of the following tools/technologies:

* [Oracle APICS](https://docs.oracle.com/en/cloud/paas/api-platform-cloud-um/apfad/): This the Oracle API Platform Cloud 
* [AWS](https://aws.amazon.com/): Amazon Web Services - This will be used to host our EC2 instances and application load balancer
* [Terraform](https://www.terraform.io/): A tool to write, plan, and create infrastructure as code. This is used to provision the network setup, and create the AWS compute instances
* [Ansible](https://www.ansible.com/): A tool to provide simple IT automation, including application deployment, configuration, and orchestration

## Executing terraform

Execute terraform init, followed by terraform apply
```
terraform@mycomputer:~/code/apics-terraform-ansible$ terraform init
Initializing modules...
- module.network
- module.compute

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.31"

Terraform has been successfully initialized!
```

Then execute terraform apply

```
terraform@mycomputer:~/code/apics-terraform-ansible$ terraform apply
. . .
Plan: 43 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
. . .
``` 

## Cleanup
To remove all created artifacts, just use terraform destroy

```
terraform@mycomputer:~/code/apics-terraform-ansible$ terraform destroy
```

## Project Structure
The apics-terraform-ansible directory contains a few terraform files that are required for execution.  The automation consists of 2 modules (network, compute) that terraform executes.

| Name | Description |
| ---- | -------------- |
| terraform.template.tfvars | Property file, this NEEDS to be filled out.  See below for more details. |
| variables.tf | Describes the variables used in the different modules. |
| outputs.tf | Output values after creation (hostnames). |
| base.tf | Executes the network and compute modules. |
	
### Network Module
The network module (in the network folder) contains all of the terraform automation to build out the network including a load balancer, and the networking required, including private and public subnets, and security roles.

	| Name | Description |
	| ---- | -------------- |
	| variables.tf | Describes the variables used in the network module. |
	| outputs.tf | Output values after creation (ids of the subnets). |
	| vpc.tf | Details of all of the network resources, and their configurations. |
	
### Compute Module
The compute module (in the computer folder) contains all of the terraform automation to provision an AWS EC2 instance, and then invokes the Ansible scripts

	| Name | Description |
	| ---- | -------------- |
	| variables.tf | Describes the variables used in the network module. |
	| outputs.tf | Output values after creation (ids of the subnets). |
	| compute.tf | Details of all of the compute resources, and their configurations and then executes the Ansible configurations. |

### Configure Module
Technically not a module, but the configure folder contains the playbooks for Ansible to install software.
	
	| Name | Description |
	| ---- | -------------- |
	| playbook-install-jdk8.yml | Installation and configuration of Java |
	| playbook-install-configure-join-apicsgatewaynode.yml | Installation and configuration of the API gateway node software. |
	| userdata.sh | Configures swap on the EC2 instaces. |

## terraform.template.tfvars Properties file
A template properties file has been provided.  This will need to be filled out to execute any of the automation. 


```
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
```

