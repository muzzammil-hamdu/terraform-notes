Here are **detailed notes on Azure CLI (Command-Line Interface)**—covering authentication, account management, resource groups, virtual machines, and Azure Active Directory service principal creation.

# Azure CLI: Detailed Notes

Azure CLI (`az`) is a command-line tool to **manage Azure resources**, automate workflows, and interact programmatically or interactively with Azure.

## 1. **Authentication & Login**

- **Sign in** with:
  ```sh
  az login
  ```
  - Opens a browser for Microsoft sign-in. Lists accessible subscriptions after success.
- Useful for:
  - Local development
  - Interactive use
  - Scripting (service principals or managed identities for automation)[1][2][3].

## 2. **Account Management**

- **List available accounts/subscriptions:**
  ```sh
  az account list
  ```
  - Shows all subscriptions the user can access.

- **Set an active subscription:**
  ```sh
  az account set --subscription 
  ```
  - Ensures operations affect the desired subscription[4].

## 3. **Resource Groups**

- A **resource group** is a logical container for resources (VMs, storage, etc).
- **List all resource groups:**
  ```sh
  az group list
  ```
- **Create a resource group:**
  ```sh
  az group create -n  -l 
  # Example:
  az group create -n test -l westus
  ```
- **Delete:**
  ```sh
  az group delete -n 
  ```
- Location is typically an Azure region code, e.g., `eastus`, `westeurope`[5][6].

## 4. **Virtual Machines (VMs)**

- **List VMs:**
  ```sh
  az vm list
  ```
  - Returns JSON by default. Add `-o table` for readable output.

- **Start a VM:**
  ```sh
  az vm start -g  -n 
  ```

- **Show VM details:**
  ```sh
  az vm show -g  -n 
  ```

- **Create a new VM:**
  - Get help & required params:
    ```sh
    az vm create -h
    ```
  - Minimal production command:
    ```sh
    az vm create -g test -n vm1 --image UbuntuLTS --admin-username azureuser --generate-ssh-keys
    ```
    - Add parameters like `--size`, `--public-ip-address`, etc., as needed[7][8].

## 5. **Azure Active Directory (Entra ID): Service Principals for RBAC**

- Service principals are **non-interactive Azure AD identities** for automation, CI/CD, etc.
- **Create a service principal and assign an RBAC role:**
  ```sh
  az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/"
  ```
  - This grants the service principal (SP) Contributor rights over the specified subscription or resource.
  - The output will include fields like `appId`, `password`, `tenant`, etc., for use in scripts or other tools[9][10].

## **Best Practices and Tips**
- Use `az login` with **service principals** (via `az login --service-principal ...`) for CI/CD and automation, not for human users.
- Always verify which subscription you’re operating in with `az account show`.
- Use `-o table` or `-o json` on most commands for custom output formatting.
- Leverage `az interactive` for a shell with autocomplete and documentation.

## **Quick Reference Table**

| Task                     | Command/Example                                       |
|--------------------------|------------------------------------------------------|
| Login                    | az login                                             |
| List subscriptions       | az account list                                      |
| Set subscription         | az account set --subscription                    |
| List resource groups     | az group list                                        |
| Create resource group    | az group create -n test -l westus                    |
| List VMs                 | az vm list -o table                                  |
| Start VM                 | az vm start -g test -n vm1                           |
| Show VM details          | az vm show -g test -n vm1                            |
| Create VM                | az vm create -g test -n vm1 ...                      |
| Create service principal | az ad sp create-for-rbac --role="Contributor" ...    |

**For more command examples, use**:
```sh
az  -h
az   -h
```
for on-demand help.

