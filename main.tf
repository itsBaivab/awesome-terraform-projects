module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source               = "./modules/virtual_network"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.location
}

module "subnet" {
  source               = "./modules/subnet"
  subnet_prefix        = var.subnet_prefix
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.virtual_network_name
}

module "network_interface_card" {
  source              = "./modules/network_interface_card"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  nic_prefix          = var.nic_prefix
  subnet_id           = module.subnet.subnet_id
}


module "linux_virtual_machine" {

  source               = "./modules/linux_virtual_machine"
  vm_prefix            = var.vm_prefix
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.resource_group_name
  network_interface_id = var.network_interface_id
  depends_on           = [module.network_interface_card]

}

