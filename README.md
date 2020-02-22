# Tsipis

Loosely translated to "cheap fuck" from Greek, Tsipis is there to aid you
have a pentest cloud infrastructure for free. It uses the free resources that
cloud providers give you. The cost is the amount of time you need to spend
to sign up on each one of them and create a terraform account with proper
rights. Everything is thoroughly documented.

You WILL need:
 - Valid Credit Card (won't be charged though)
 - Phone number (I'd say don't spend your time with "online free" numbers)
 - E-Mail

Using a VPN to register on various provider might cause problems (additional
verification steps/bans/global warming).

I try to use the "free forever" resources first, not the "12-month free" or
"trial", but that's not always feasible (you cheap fuck...).

Idea came from https://free-for.dev

## Gathering Credentials

Pick a project name. Stick with it across all providers.

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
