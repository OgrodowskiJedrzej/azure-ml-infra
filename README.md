# Azure ML Infrastructure (Terraform)

Simple and reproducible infrastructure automation for **Azure Machine
Learning** using **Terraform**.

This project provides a minimal, modular setup to create a complete
Azure ML environment (workspace + dependencies) with a single
`terraform apply`.

------------------------------------------------------------------------

## Motivation

When migrating Machine Learning projects between Azure subscriptions or
accounts, recreating the same Azure ML environment manually is: -
time-consuming - error-prone - hard to keep consistent

This repository solves that problem by defining **Azure ML
infrastructure as code**, allowing the same setup to be recreated
reliably in any Azure environment.

------------------------------------------------------------------------

## What This Project Creates

Using Terraform, the project provisions:

-   Resource Group
-   Azure Machine Learning Workspace
-   Storage Account (datastore)
-   Azure Container Registry
-   Key Vault
-   Application Insights
-   Azure ML Compute Cluster (CPU/GPU-ready)

All resources are created in a **reproducible and portable way**.

------------------------------------------------------------------------

## Requirements

-   Terraform `>= 1.5`
-   Azure CLI
-   Azure subscription with permissions to create resources

``` bash
az login
az account set --subscription <SUBSCRIPTION_ID>
```

------------------------------------------------------------------------

## Usage

1.  Clone the repository:
``` bash
git clone https://github.com/OgrodowskiJedrzej/azure-ml-infra.git
cd azure-ml-infra
```
2.  Initialize Terraform:
``` bash
terraform init
```
3.  Review the execution plan:
``` bash
terraform plan
```
4.  Create the infrastructure:
``` bash
terraform apply
```

------------------------------------------------------------------------

## Reproducibility

The same infrastructure can be recreated by: - changing variable
values - running Terraform in a different Azure subscription or account

No manual setup in the Azure Portal is required.

------------------------------------------------------------------------

## Roadmap (Future Improvements)

-   Remote Terraform backend (Azure Storage)
-   Multiple environments (`dev / prod`)
-   Managed identities instead of admin credentials
-   Private endpoints and networking
-   CI/CD with GitHub Actions
-   Model training & experiment tracking pipelines

------------------------------------------------------------------------


Great sources:

https://microsoft.github.io/azureml-ops-accelerator/3-Deploy/ARMTemplates/
https://github.com/papagala/sagemaker-isolated/