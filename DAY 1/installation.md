1. Installation of terraform on Linux
We create a virtual machine to install terraform, create a Virtual machine with following details 
        
In Networking section 
       
VM is created
       



Installation of terraform:
Install required packages
     sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
         
Securely add HashiCorp’s GPG key to Linux system
     wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
        
You are adding the HashiCorp APT repository to your system, so apt can install Terraform and keep it updated via the package manager.
•	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg]  https://apt.releases.hashicorp.com $(lsb_release -cs) main" |  sudo tee /etc/apt/sources.list.d/hashicorp.list
•	sudo apt update
        
Once we have added the repository and updated run the command to install terraform
       sudo apt-get install terraform
          
Check the version using command
       terraform –v
          



