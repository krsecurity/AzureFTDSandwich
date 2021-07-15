variable "costcenter" {
    description = "Cost center for resources"
    default = "IT"
}

variable "environment" {
     description = "Environment for resources"
     default = "Dev"
}

variable "location" {
  description = "The resource group location"
  default     = "West Europe"
}

variable "rg-name" {
    description = "Resource group name"
    default = "KRS-NGFW-RG"
}

variable "av-set-name" {
  description = "Availability set name"
  default     = "KRS-NGFW-AVSET-01"
}

variable "vnet-subnets" {
    description = "VNET ID's for each subnet"
    default = ["/subscriptions/98675d2c-9a5d-4a9b-a165-bfdc505a4364/resourceGroups/vnet-01-rg/providers/Microsoft.Network/virtualNetworks/KRS-TRANSIT-VNET/subnets/management",
    "/subscriptions/98675d2c-9a5d-4a9b-a165-bfdc505a4364/resourceGroups/vnet-01-rg/providers/Microsoft.Network/virtualNetworks/KRS-TRANSIT-VNET/subnets/diagnostic",
    "/subscriptions/98675d2c-9a5d-4a9b-a165-bfdc505a4364/resourceGroups/vnet-01-rg/providers/Microsoft.Network/virtualNetworks/KRS-TRANSIT-VNET/subnets/outside",
    "/subscriptions/98675d2c-9a5d-4a9b-a165-bfdc505a4364/resourceGroups/vnet-01-rg/providers/Microsoft.Network/virtualNetworks/KRS-TRANSIT-VNET/subnets/inside"]
}

variable "ngfw-name" {
    description = "NGFW naming convention"
    default = ["KRS-NGFW-01", "KRS-NGFW-02"]
}

variable "ngfw-interfaces" {
    description = "List of NGFW interface names"
    default = ["management", "diagnostic", "outside", "inside"]
}

variable "ngfw-01-nics" {
    description = "List of NGFW-01 NIC names"
    default = ["ngfw-01-management", "ngfw-01-diagnostic", "ngfw-01-outside", "ngfw-01-inside"]
}

variable "ngfw-02-nics" {
    description = "List of NGFW-02 NIC names"
    default = ["ngfw-02-management", "ngfw-02-diagnostic", "ngfw-02-outside", "ngfw-02-inside"]
}

variable "admin-password" {
    description = "Password"
    sensitive = true
}

variable "admin-username" {
    description = "Username"
    sensitive = true
}

variable "elb-pip" {
    description = "ELB public IP"
    default = "KRS-PIP-01"
}

variable "elb-name" {
    description = "ELB name"
    default = "KRS-ELB-01"
}

variable "elb-backend-pool-name" {
    description = "ELB backend pool name"
    default = "KRS-ELB-NGFW-BACKEND-POOL"
}

variable "health-probe-name" {
    description = "LB health probe"
    default = "KRS-SSH-HEALTH-PROBE"
}

variable "health-probe-port" {
    description = "LB health probe port"
    default = 22
}

variable "lb-ports" {
    description = "Ports to load balance"
    default = [80,443]
}

variable "outbound-rule-name" {
    description = "Name of outbound rule"
    default = "KRS-ELB-OUTBOUND-RULE"
}

variable "ilb-name" {
    description = "Name of ILB"
    default = "KRS-ILB-01"
}

variable "ilb-frontend-name" {
    description = "ILB frontend IP name"
    default = "KRS-ILB-IP-01"
}

variable "ilb-frontend-ip" {
    description = "ILB frontend IP address"
    default = "10.0.4.100"
}

variable "ilb-backend-pool-name" {
    description = "ILB backend pool"
    default = "KRS-ILB-NGFW-BACKEND-POOL"
}

variable "ilb-haports-rule-name" {
    description = "ILB HA port rule name"
    default = "KRS-ILB-ALL-PORTS-RULE"
}