# Tsipis

## Gathering Credentials

- Google
  - Create a project
  - Create a [Service Account](https://console.cloud.google.com/apis/credentials/serviceaccountkey) "Project/Owner" and save to `~/.tsipis/google.json`

## Using

I guess you have gathered all the credentials, as instructed above.
You will need to install `terraform` (> 0.12).

## Building the images with packer

You will need `jq`, `packer` & `virtualbox`.
VirtualBox also needs 'Oracle VM VirtualBox Extension Pack'.
On Arch Linux install it with `pacman -S virtualbox-ext-vnc`

Initialize image storage to build images with packer:

```bash
cd terraform
terraform init
# You will get errors with the next command, it's fine
# Terraform tries to create machines with non-existent images
terraform plan -out /tmp/tfplan
# If you're happy
terraform apply /tmp/tfplan
terraform output -json | jq "with_entries(.value = .value.value)" > ~/.tsipis/packer.json

# Actually build the images
cd ../packer
packer -var-file ~/.tsipis/packer.json kali/kali.json

cd ../terraform
terraform plan -out /tmp/tfplan
# If you're happy
terraform apply /tmp/tfplan
```
