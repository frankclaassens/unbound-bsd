provider "vultr" { 
  api_key = "${var.vultr_api_key}" 
}

###############################################################################################
# DATA
###############################################################################################
data "vultr_region" "london" {
  filter {
    name   = "name"
    values = ["London"]
  }
}

# data "vultr_os" "container_bsd" {
#   filter {
#     name   = "name"
#     values = ["FreeBSD 12 x64"]
#   }
# }

data "vultr_plan" "starter" {
  filter {
    name   = "price_per_month"
    values = ["20.00"]
  }

  filter {
    name   = "ram"
    values = ["4096"]
  }
}

data "vultr_snapshot" "unbound-base" {
  description_regex = "unbound-base-image"
}

# data "vultr_ssh_key" "root" {
#   filter {
#     name   = "name"
#     values = ["root"]
#   }
# }
###############################################################################################
# RESOURCES
###############################################################################################
# resource "vultr_startup_script" "bootstrap" {
#   name       = "bootstrap"
#   content    = "${file("${path.module}/scripts/bootstrap.sh")}"
#   type       = "boot"
# }

resource "vultr_ssh_key" "unbound" {
  name       = "unbound-server"
  public_key = "${file("${var.ssh_public_key}")}"
}

resource "vultr_firewall_group" "unbound" {
  description = "unbound server firewall group"
}

resource "vultr_firewall_rule" "rule1" {
  firewall_group_id = "${vultr_firewall_group.unbound.id}"
  cidr_block        = "0.0.0.0/0" 
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
}
###############################################################################################
# INSTANCES
###############################################################################################
resource "vultr_instance" "unbound" {
  name                = "unbound"
  region_id           = "${data.vultr_region.london.id}"
  plan_id             = "${data.vultr_plan.starter.id}"
  # os_id               = "${data.vultr_os.container_bsd.id}"
  snapshot_id         = "${data.vultr_snapshot.unbound-base.id}"
  ssh_key_ids         = ["${vultr_ssh_key.unbound.id}"]
  firewall_group_id   = "${vultr_firewall_group.unbound.id}"
  private_networking  = true
  ipv6                = true
  # startup_script_id = "${vultr_startup_script.bootstrap.id}"

  hostname          = "unbound"
  tag               = "unbound"

connection {
    type = "ssh"
    host = "${vultr_instance.unbound.ipv4_address}"
    user = "root"
    private_key = "${file("${var.ssh_key_private}")}"
    agent = "false"
  }

provisioner "remote-exec" {
    inline = ["echo hallo world > /root/hello"]
}

# provisioner "local-exec" {
#     command = "sleep 5; ANSIBLE_HOST_KEY_CHECKING=False TF_STATE=terraform.tfstate ansible-playbook --verbose -u root --private-key ${var.ssh_key_private} -i '${vultr_instance.unbound.ipv4_address},' playbooks/configure-server.yml"
# }

}
###############################################################################################
# OUTPUT
###############################################################################################
// Output all of the virtual machine's IPv4 addresses to STDOUT when the infrastructure is ready.
output ip_addresses {
  value = "${list(vultr_instance.unbound.ipv4_address)}"
}

output ipv6_addresses {
  value = "${list(vultr_instance.unbound.ipv6_addresses)}"
}

output root_password {
  value = "${list(vultr_instance.unbound.default_password)}"
}