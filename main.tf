
provider "azurerm" {
  features {}
}


###
# CREATE AVAILABILITY SET
###
resource "azurerm_resource_group" "ngfw-rg" {
  name     = var.rg-name
  location = var.location

    tags = {
    environment = var.environment
    costcenter = var.costcenter
  }
}

resource "azurerm_availability_set" "avset" {
  name                = var.av-set-name
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  platform_update_domain_count = 2
  platform_fault_domain_count = 2
}

### 
# CREATE NGFW-01
###


resource "azurerm_network_interface" "ngfw-01-int1" {
  name                = var.ngfw-01-nics[0]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[0]
    subnet_id                     = var.vnet-subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ngfw-01-int2" {
  name                = var.ngfw-01-nics[1]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[1]
    subnet_id                     = var.vnet-subnets[1]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ngfw-01-int3" {
  name                = var.ngfw-01-nics[2]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[2]
    subnet_id                     = var.vnet-subnets[2]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ngfw-01-int4" {
  name                = var.ngfw-01-nics[3]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[3]
    subnet_id                     = var.vnet-subnets[3]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "krs-ngfw-01" {
  name                = var.ngfw-name[0]
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  location            = var.location
  size                = "Standard_D3_v2"
  disable_password_authentication = false
  admin_username      = var.admin-username
  admin_password      = var.admin-password
  availability_set_id = azurerm_availability_set.avset.id
  network_interface_ids = [
    azurerm_network_interface.ngfw-01-int1.id, azurerm_network_interface.ngfw-01-int2.id, azurerm_network_interface.ngfw-01-int3.id, azurerm_network_interface.ngfw-01-int4.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "cisco"
    offer     = "cisco-ftdv"
    sku       = "ftdv-azure-byol"
    version   = "latest"
  }

    plan {
    name      = "ftdv-azure-byol"
    publisher = "cisco"
    product   = "cisco-ftdv"
  }

    tags = {
    environment = var.environment
    costcenter = var.costcenter
  }
}

### 
# CREATE NGFW-02
###


resource "azurerm_network_interface" "ngfw-02-int1" {
  name                = var.ngfw-02-nics[0]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[0]
    subnet_id                     = var.vnet-subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ngfw-02-int2" {
  name                = var.ngfw-02-nics[1]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[1]
    subnet_id                     = var.vnet-subnets[1]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ngfw-02-int3" {
  name                = var.ngfw-02-nics[2]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[2]
    subnet_id                     = var.vnet-subnets[2]
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface" "ngfw-02-int4" {
  name                = var.ngfw-02-nics[3]
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name

  ip_configuration {
    name                          = var.ngfw-interfaces[3]
    subnet_id                     = var.vnet-subnets[3]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "krs-ngfw-02" {
  name                = var.ngfw-name[1]
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  location            = var.location
  size                = "Standard_D3_v2"
  disable_password_authentication = false
  admin_username      = var.admin-username
  admin_password      = var.admin-password
  availability_set_id = azurerm_availability_set.avset.id
  network_interface_ids = [
    azurerm_network_interface.ngfw-02-int1.id, azurerm_network_interface.ngfw-02-int2.id, azurerm_network_interface.ngfw-02-int3.id, azurerm_network_interface.ngfw-02-int4.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "cisco"
    offer     = "cisco-ftdv"
    sku       = "ftdv-azure-byol"
    version   = "latest"
  }

    plan {
    name      = "ftdv-azure-byol"
    publisher = "cisco"
    product   = "cisco-ftdv"
  }

    tags = {
    environment = var.environment
    costcenter = var.costcenter
  }
}

###
# CREATE PUBLIC IP
###

resource "azurerm_public_ip" "krs-pip-01" {
  name                = var.elb-pip
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  allocation_method   = "Static"
  sku = "Standard"
}

###
# CREATE EXTERNAL LOAD BALANCER
###

resource "azurerm_lb" "krs-elb-01" {
  name                = var.elb-name
  location            = var.location
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = var.elb-pip
    public_ip_address_id = azurerm_public_ip.krs-pip-01.id
  }
}
resource "azurerm_lb_backend_address_pool" "ngfw-external-backend-pool" {
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id     = azurerm_lb.krs-elb-01.id
  name                = var.elb-backend-pool-name
}

resource "azurerm_network_interface_backend_address_pool_association" "ngfw-01-elb-pool" {
  network_interface_id    = azurerm_network_interface.ngfw-01-int3.id
  ip_configuration_name   = var.ngfw-interfaces[2]
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-external-backend-pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ngfw-02-elb-pool" {
  network_interface_id    = azurerm_network_interface.ngfw-02-int3.id
  ip_configuration_name   = var.ngfw-interfaces[2]
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-external-backend-pool.id
}

resource "azurerm_lb_probe" "external-ngfw-probe" {
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id     = azurerm_lb.krs-elb-01.id
  name                = var.health-probe-name
  port                = var.health-probe-port
}
resource "azurerm_lb_rule" "http" {
  resource_group_name            = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id                = azurerm_lb.krs-elb-01.id
  name                           = "RULE.${var.lb-ports[0]}"
  protocol                       = "Tcp"
  frontend_port                  = var.lb-ports[0]
  backend_port                   = var.lb-ports[0]
  frontend_ip_configuration_name = var.elb-pip
  load_distribution = "SourceIP"
  disable_outbound_snat = true
  enable_floating_ip = true
  probe_id = azurerm_lb_probe.external-ngfw-probe.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-external-backend-pool.id

}

resource "azurerm_lb_rule" "https" {
  resource_group_name            = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id                = azurerm_lb.krs-elb-01.id
  name                           = "RULE.${var.lb-ports[1]}"
  protocol                       = "Tcp"
  frontend_port                  = var.lb-ports[1]
  backend_port                   = var.lb-ports[1]
  frontend_ip_configuration_name = var.elb-pip
  load_distribution = "SourceIP"
  disable_outbound_snat = true
  enable_floating_ip = true
  probe_id = azurerm_lb_probe.external-ngfw-probe.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-external-backend-pool.id
}
resource "azurerm_lb_outbound_rule" "ngfw-outbound-rule" {
  resource_group_name     = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id         = azurerm_lb.krs-elb-01.id
  name                    = var.outbound-rule-name
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-external-backend-pool.id

  frontend_ip_configuration {
    name = var.elb-pip
  }
}
###
# CREATE INTERNAL LOAD BALANCER
###

resource "azurerm_lb" "krs-ilb-01" {
  name                = var.ilb-name
  location            = var.location  
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  sku = "Standard"

  frontend_ip_configuration {
    name              = var.ilb-frontend-name
    subnet_id         = var.vnet-subnets[3]
    private_ip_address_allocation = "Static"
    private_ip_address = var.ilb-frontend-ip
  }
}
resource "azurerm_lb_backend_address_pool" "ngfw-internal-backend-pool" {
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id     = azurerm_lb.krs-ilb-01.id
  name                = var.ilb-backend-pool-name
}

resource "azurerm_network_interface_backend_address_pool_association" "ngfw-01-ilb-pool" {
  network_interface_id    = azurerm_network_interface.ngfw-01-int4.id
  ip_configuration_name   = var.ngfw-interfaces[3]
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-internal-backend-pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "ngfw-02-ilb-pool" {
  network_interface_id    = azurerm_network_interface.ngfw-02-int4.id
  ip_configuration_name   = var.ngfw-interfaces[3]
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-internal-backend-pool.id
}

resource "azurerm_lb_probe" "internal-ngfw-probe" {
  resource_group_name = azurerm_resource_group.ngfw-rg.name
  loadbalancer_id     = azurerm_lb.krs-ilb-01.id
  name                = var.health-probe-name
  port                = var.health-probe-port
}
resource "azurerm_lb_rule" "lb_haports_rule" {
  backend_port = 0
  frontend_ip_configuration_name = var.ilb-name
  frontend_port = 0
  loadbalancer_id = azurerm_lb.krs-ilb-01.id
  name = var.ilb-haports-rule-name
  protocol = "All"
  load_distribution = "SourceIP"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ngfw-internal-backend-pool.id
  probe_id = azurerm_lb_probe.internal-ngfw-probe.id
  resource_group_name = azurerm_resource_group.ngfw-rg.name
}


