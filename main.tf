terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.2"

    }
  }

  required_version = ">=1.1.0"
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf-rg" {
  name     = "terraform-rg"
  location = "East Us"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "tf-vnet" {
  name                = "terraform-vnet"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  address_space       = ["10.123.0.0/16"]
  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "tf-subnet" {
  name                 = "terraform-subnet"
  resource_group_name  = azurerm_resource_group.tf-rg.name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "tf-nsg" {
  name                = "terraform-nsg"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
  tags = {
    environment = "dev"
  }
}


resource "azurerm_network_security_rule" "tf-nsr" {
  name                        = "terraform-dev-nsr"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tf-rg.name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}


resource "azurerm_subnet_network_security_group_association" "tf-nsg-association" {
  subnet_id                 = azurerm_subnet.tf-subnet.id
  network_security_group_id = azurerm_network_security_group.tf-nsg.id
}


resource "azurerm_public_ip" "tf-pip" {
  name                = "terraform-pip"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
  allocation_method   = "Dynamic"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "tf-nic" {
  name                = "terraform-nic"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name


  ip_configuration {
    name                          = "interanl"
    subnet_id                     = azurerm_subnet.tf-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf-pip.id
  }


  tags = {
    environment = "dev"
  }
}


resource "azurerm_linux_virtual_machine" "tf-vm" {
  name                  = "terraform-vm"
  resource_group_name   = azurerm_resource_group.tf-rg.name
  location              = azurerm_resource_group.tf-rg.location
  size                  = "standard_B1s"
  admin_username        = "ubuntu"
  network_interface_ids = [azurerm_network_interface.tf-nic.id]

  custom_data = filebase64("custom_data.tpl")

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/terraformazurevmkey.pub")

  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-shh-config-adder-script.tpl", {
      hostname      = self.public_ip_address,
      user          = "ubuntu",
      identity_file = "~/.ssh/terraformazurevmkey"

    })

    interpreter = ["PowerShell", "-Command"]
  }


  tags = {
    environment = "dev"
  }


}


data "azurerm_public_ip" "tf-pip" {
  name                = azurerm_public_ip.tf-pip.name
  resource_group_name = azurerm_resource_group.tf-rg.name
}

output "public_ip_address" {
 value = "${azurerm_linux_virtual_machine.tf-vm.admin_username}:${data.azurerm_public_ip.tf-pip.ip_address}"
}
