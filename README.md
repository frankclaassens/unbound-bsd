# ![UnboundBSD](https://www.unbound.net/gx/unbound-250.png)

## Overview

UnboundBSD makes use of Terraform & Ansible to provision and configure a new FreeBSD instance in the cloud (Vultr as provider) running Unbound DNS.
This allows you to use your very own DNS Server to protect your online privacy.

## [Download the latest release](https://github.com/frankclaassens/unbound-dns-freebsd/releases/latest)

Available as source code (Terraform & Ansible) for most operating systems and architectures (see below).

## Features

* DNS traffic encryption and authentication. Supports DNSCrypt and CurveDNS for fully encrypted end-to-end queries.
* Filtering: block ads, malware, and other unwanted content. Compatible with all DNS services
* Transparent redirection of specific domains to specific resolvers
* DNS caching, to reduce latency and improve privacy
* Local IPv6 blocking to reduce latency on IPv4-only networks
* Automatic background updates of resolvers lists
* Can force outgoing connections to use TCP
* Compatible with DNSSEC
