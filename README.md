# acme-app-vpc-gcp-terraform

## Custom Machine Types

This example creates an instance with a custom machine type, a bastion host and a NAT gateway.

## Set some environment variables    
Be sure to set the following environment variables for your shell

```bash
export GOPATH=$HOME/src/go
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.gcloud/account.json

export GOOGLE_PROJECT="your-project-id"
export GOOGLE_CLOUD_PROJECT=${GOOGLE_PROJECT}
export GCLOUD_PROJECT=${GOOGLE_PROJECT}
export CLOUDSDK_CORE_PROJECT=${GOOGLE_PROJECT}

export GOOGLE_REGION="us-west2"
export GCLOUD_REGION=${GOOGLE_REGION}
export CLOUDSDK_COMPUTE_REGION=${GOOGLE_REGION}

export GOOGLE_ZONE="us-west2-a"
export GCLOUD_ZONE=${GOOGLE_ZONE}
export CLOUDSDK_COMPUTE_ZONE=${GOOGLE_ZONE}
```

## Install Terraform

Install Terraform on Linux if it is not already installed (visit [terraform.io](https://terraform.io) for other distributions):

```
curl -sL https://goo.gl/UYp3WG | bash
source ${HOME}/.bashrc
```

## Setup Environment

```
cd example-custom-machine-types/
```

Set the project, replace `YOUR_PROJECT` with your project ID:

```
gcloud config set project YOUR_PROJECT
```

```
test -z DEVSHELL_GCLOUD_CONFIG && gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)
```

## Configure remote backend
Configure Terraform [remote backend](https://www.terraform.io/docs/backends/types/gcs.html) for the state file.

```
BUCKET=${GOOGLE_PROJECT}-terraform
gsutil mb gs://${BUCKET}

PREFIX=tf-es-custom-machine/state
```

```
cat > backend.tf <<EOF
terraform {
  backend "gcs" {
    bucket     = "${BUCKET}"
    prefix     = "${PREFIX}"
  }
}
EOF
```

## Run Terraform

```
terraform init
terraform plan
terraform apply
```

## Testing

SSH into the bastion host with port forwarding to Cerebro and Kibana:

```
eval $(ssh-agent)
ssh-add ~/.ssh/google_compute_engine
eval $(terraform output bastion)
```

SSH into the custom machine:

```
ssh acme-custom-1
```

Verify external IP is the IP of the NAT gateway:

```
curl http://ipinfo.io/ip
```

## Cleanup

Exit the ssh sessions:

```
exit
```

Remove all resources created by terraform:

```
terraform destroy
```
