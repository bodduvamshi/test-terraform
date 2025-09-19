# Azure VM Terraform Project

This project is designed to provision and manage Azure infrastructure using Terraform. It includes modules for networking, compute resources, and security configurations, allowing for a modular and reusable approach to infrastructure as code.

## Project Structure

The project is organized into the following directories and files:

- **modules/**: Contains reusable Terraform modules.
  - **network/**: Manages networking resources.
    - `main.tf`: Defines the network resources such as VNet, subnets, and NSGs.
    - `outputs.tf`: Exports outputs like VNet ID and subnet IDs.
    - `variables.tf`: Defines input variables for the network module.
  - **compute/**: Manages compute resources.
    - `main.tf`: Defines the VM and associated resources.
    - `outputs.tf`: Exports outputs like VM ID and public IP address.
    - `variables.tf`: Defines input variables for the compute module.
  - **security/**: Manages security configurations.
    - `main.tf`: Defines NSGs and security rules.
    - `outputs.tf`: Exports outputs like NSG IDs and security rule IDs.
    - `variables.tf`: Defines input variables for the security module.

- **basics.tf**: Contains foundational infrastructure setup, including resource group and service principal configurations.

- **vars.tf**: Defines global input variables for the entire Terraform configuration.

- **outputs.tf**: Summarizes key outputs such as resource IDs and endpoints.

- **providers.tf**: Specifies the Azure provider configuration.

- **main.tf**: Entry point for the Terraform configuration, orchestrating module calls.

## Setup Instructions

1. **Install Terraform**: Ensure that Terraform is installed on your machine. You can download it from the [Terraform website](https://www.terraform.io/downloads.html).

2. **Configure Azure Credentials**: Set up your Azure credentials to allow Terraform to manage resources in your Azure account. You can use a service principal or Azure CLI for authentication.

3. **Clone the Repository**: Clone this repository to your local machine.

4. **Initialize Terraform**: Navigate to the project directory and run the following command to initialize the Terraform configuration:
   ```
   terraform init
   ```

5. **Plan the Deployment**: Run the following command to see the resources that will be created:
   ```
   terraform plan
   ```

6. **Apply the Configuration**: To create the resources defined in the configuration, run:
   ```
   terraform apply
   ```

7. **Destroy Resources**: To remove all resources created by this configuration, run:
   ```
   terraform destroy
   ```

## Usage Guidelines

- Modify the `vars.tf` file to customize the input variables according to your requirements.
- Use the modules in the `modules/` directory to extend or modify the infrastructure as needed.
- Refer to the outputs defined in `outputs.tf` for important resource information after deployment.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.