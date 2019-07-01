provider "vultr" { api_key = "" }

resource "vultr_instance" "unbound" {
  name              = "unbound"
  region_id         = "${data.vultr_region.silicon_valley.id}"
  plan_id           = "${data.vultr_plan.starter.id}"
  os_id             = "${data.vultr_os.container_bsd.id}"
  ssh_key_ids       = ["${data.vultr_ssh_key.root.id}"]
  hostname          = "unbound"
  tag               = "container-bsd"
  firewall_group_id = "${vultr_firewall_group.example.id}"
}

resource "vultr_startup_script" "bootstrap_script" {
  name       = "bootstrap.sh"
  content    = "${file("${path.module}/scripts/bootstrap.sh")}"
  type       = "boot"
}

data "vultr_region" "silicon_valley" {
  filter {
    name   = "name"
    values = ["London"]
  }
}

data "vultr_os" "container_bsd" {
  filter {
    name   = "name"
    values = ["FreeBSD 12 x64"]
  }
}

data "vultr_plan" "starter" {
  filter {
    name   = "price_per_month"
    values = ["5.00"]
  }

  filter {
    name   = "ram"
    values = ["1024"]
  }
}

data "vultr_ssh_key" "root" {
  filter {
    name   = "name"
    values = ["root"]
  }
}

resource "vultr_firewall_group" "example" {
  description = "example group"
}

resource "vultr_firewall_rule" "rule1" {
  firewall_group_id = "${vultr_firewall_group.example.id}"
  cidr_block        = "0.0.0.0/0"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "vultr_firewall_rule" "rule2" {
  firewall_group_id = "${vultr_firewall_group.example.id}"
  cidr_block        = "0.0.0.0/0"
  protocol          = "tcp"
  from_port         = 19844
  to_port           = 19844
}