# Introduction

This repository sets up a GKE Autopilot cluster for demo purposes.

Please refer to the official GKE Autopilot cluster documentation on how to set up all the permissions for the service account and how it can be run with both `gcloud` CLI and `terraform`: https://cloud.google.com/kubernetes-engine/docs/how-to/creating-an-autopilot-cluster

## Terragrunt
### Environment variables
In order to use this repo you need to have the following environment variables set:
```
GKE_PROJECT_ID
GKE_ACL_CIDR
GKE_CREDENTIALS_PATH
```

`GKE_PROJECT_ID` is the project ID in google cloud

`GKE_ACL_CIDR` is the access list to further lock down the public endpoint of the GKE kubernetes API. For example `192.168.0.100/32`

`GKE_CREDENTIALS_PATH` should point to the file location where the credentials for the respective service account are stored.

These three variables are used in the `infrastructure/terragrunt/workspace.hcl` file.

The region is set in the `region.hcl` file that is present in every region top level folder. For demo purposes there is only one region and the file can be found here: `infrastructure/terragrunt/gcp/europe-north1`.

Similarly in every region there is a specific env folder which holds the specific terragrunt resource input definitions and also an `env.hcl` file for environment specific variables.

### Create resources

If your environment variables are set, please navigate to `infrastructure/terragrunt/gcp/europe-north1/dev/gke` folder and run:
```
terragrunt init
```

and then simply:

```
terragrunt apply
```

Review the plan carefully before typing `yes` to create the resources. This will create the resources and save the terraform state file locally on your computer.