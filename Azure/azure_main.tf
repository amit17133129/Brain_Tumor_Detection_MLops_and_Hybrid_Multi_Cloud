resource "azurerm_resource_group" "jenkinsRG" {
  name     = "jenkinsRG"
  location = "eastus"
  count    = terraform.workspace == "azure_prod" ? 1 : 0
  tags = {
    environment = "Terraform Demo"
  }
}
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  count               = terraform.workspace == "azure_prod" ? 1 : 0
  resource_group_name = azurerm_resource_group.jenkinsRG[count.index].name
  #element(tostring(azurerm_resource_group.myterraformgroup), 0)

  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_subnet" "myterraformsubnet" {
  count               = terraform.workspace == "azure_prod" ? 1 : 0
  name                = "mySubnet"
  resource_group_name = azurerm_resource_group.jenkinsRG[count.index].name
  #element(tostring(azurerm_resource_group.myterraformgroup), 0)
  virtual_network_name = azurerm_virtual_network.myterraformnetwork[count.index].name
  #element(tostring(azurerm_virtual_network.myterraformnetwork), 0)
  address_prefixes = ["10.0.1.0/24"]

}

resource "azurerm_public_ip" "myterraformpublicip" {
  count               = terraform.workspace == "azure_prod" ? 1 : 0
  name                = var.publi_ip_names[0]
  location            = terraform.workspace == "azure_prod" ? "eastus" : "westus"
  resource_group_name = azurerm_resource_group.jenkinsRG[count.index].name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}


resource "azurerm_network_security_group" "myterraformnsg" {
  count               = terraform.workspace == "azure_prod" ? 1 : 0
  name                = "myNetworkSecurityGroup"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.jenkinsRG[count.index].name

  security_rule {
    name                       = "SSH"
    priority                   = terraform.workspace == "azure_prod" ? 1001 : 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_network_interface" "myterraformnic" {
  count               = terraform.workspace == "azure_prod" ? 1 : 0
  name                = var.NIC_cards[0]
  location            = terraform.workspace == "azure_prod" ? "eastus" : "westus"
  resource_group_name = azurerm_resource_group.jenkinsRG[count.index].name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet[count.index].id
    private_ip_address_allocation = terraform.workspace == "azure_prod" ? "Dynamic" : false
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip[count.index].id
  }

  tags = {
    environment = "Terraform Demo"
  }
}


resource "azurerm_network_interface_security_group_association" "example" {
  count                     = terraform.workspace == "azure_prod" ? 1 : 0
  network_interface_id      = azurerm_network_interface.myterraformnic[count.index].id
  network_security_group_id = azurerm_network_security_group.myterraformnsg[count.index].id
}


# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  count = terraform.workspace == "azure_prod" ? 1 : 0
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.jenkinsRG[count.index].name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
  name                     = "diag${random_id.randomId[count.index].hex}"
  resource_group_name      = azurerm_resource_group.jenkinsRG[count.index].name
  location                 = terraform.workspace == "azure_prod" ? "eastus" : "westus"
  count                    = terraform.workspace == "azure_prod" ? 1 : 0
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Demo"
  }
}



# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm_master" {
  count                 = terraform.workspace == "azure_prod" ? 1 : 0
  name                  = var.vm_names[0]
  location              = terraform.workspace == "azure_prod" ? "eastus" : "westus"
  resource_group_name   = azurerm_resource_group.jenkinsRG[count.index].name
  network_interface_ids = [azurerm_network_interface.myterraformnic[count.index].id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = var.Disk_names[0]
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = lookup(var.type, terraform.workspace)
    offer     = lookup(var.image, terraform.workspace)
    sku       = "7.5"
    version   = "latest"
  }

  computer_name                   = var.vm_names[0]
  admin_username                  = var.vm_user[0]
  disable_password_authentication = false
  admin_password                  = var.vm_password[0]
  custom_data                     = filebase64("D://Users/Amit/Desktop/k8s cluster/jenkins.sh")


  #  boot_diagnostics {
  #    storage_account_uri = azurerm_storage_account.mystorageaccount[count.index].primary_blob_endpoint
  #  }

  tags = {
    environment = "Jenkins Master"
  }

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = var.vm_user[0]
      password = var.vm_password[0]
      host     = azurerm_linux_virtual_machine.myterraformvm_master[count.index].public_ip_address
    }
    inline = [
      "echo  azure@123   |   sudo  -S yum install wget git -y",
      "echo  azure@123   |   sudo  -S yum install java-1.8.0-openjdk-devel -y",
      "sudo  wget O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo",
      "sudo   mv /home/azureusermaster/jenkins.repo   /etc/yum.repos.d/jenkins.repo",
      "echo  azure@123   |   sudo  -S rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "echo  azure@123   |   sudo  -S yum install jenkins -y",
      "echo  azure@123   |   sudo  -S systemctl start jenkins",
      "echo  azure@123   |   sudo  -S systemctl enable jenkins"
      #"echo  azure@123   |   sudo  -S cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]

  }
}



