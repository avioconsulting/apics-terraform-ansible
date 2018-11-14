provider "aws" {
  access_key = "${var.access-key}"
  secret_key = "${var.secret-key}"
  region     = "${var.region}"
}


module "network" {
  source = "./network"
  owner = "${var.owner}"
  vpc-cidr = "192.168.16.0/21"
  vpc-name = "apics-vpc"
}

module "compute" {
  source = "./compute"
  owner = "${var.owner}"
  vpc-id = "${module.network.vpc-id}"
  public-a = "${module.network.public-a}"
  public-b  = "${module.network.public-b}"
  private-a = "${module.network.private-a}"
  private-b = "${module.network.private-b}"
  instance-name = "APICS-Node"
  logical-gateway = "${var.logical-gateway}"
  logical-gateway-id = "${var.logical-gateway-id}"
  management-service-url = "${var.management-service-url}"
  gateway-execution-mode = "${var.gateway-execution-mode}"
  idcs-url = "${var.idcs-url}"
  request-scope = "${var.request-scope}"
  ami = "${var.ami}"
  public-key-location = "${var.public-key-location}"
  instance-type = "${var.instance-type}"


  gateway-user = "${var.gateway-user}"
  gateway-user-pass = "${var.gateway-user-pass}"
  gateway-manager-user = "${var.gateway-manager-user}"
  gateway-manager-pass = "${var.gateway-manager-pass}"
  gateway-manager-runtime-user = "${var.gateway-manager-runtime-user}"
  gateway-manager-runtime-pass = "${var.gateway-manager-runtime-pass}"

  client-id = "${var.client-id}"
  client-secret = "${var.client-secret}"

  gateway-id = "${var.logical-gateway-id}"
  apics-token = "${var.apics-token}"
  download-url = "${var.download-url}"
}

