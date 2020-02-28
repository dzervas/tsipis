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

- Heroku
  - If you don't want to give full access to your heroku account, create a Team (needs Credit Card)
  - Go to [Manage Account/Applications/Create authorization](https://dashboard.heroku.com/account/applications/authorizations/new), give it a friendly name and some expiry
  - Write on `~/.tsipis/heroku.yml`: `email: "<your_email>"` and `api_key: "<api_key>"` (in 2 lines please)
  - (Optional) Add a credit card to receive 450 more dynos from the basic 550 = total 1000
- Google
  - Create a project
  - Create a [Service Account](https://console.cloud.google.com/apis/credentials/serviceaccountkey) "Project/Owner" and save to `~/.tsipis/google.json`
  - Go to [API Library](https://console.developers.google.com/apis/dashboard) and enable:
    - [Compute Engine API](https://console.developers.google.com/apis/api/compute.googleapis.com)
  - (Optional) Create a budget in Billing/Budgets & alerts

## Using

I guess you have gathered all the credentials, as instructed above.
You will need to install `terraform` (> 0.12).

## Building the images with packer

You will need `jq`, `packer` & `virtualbox`.

VirtualBox also needs 'Oracle VM VirtualBox Extension Pack'.
To install it execute `scripts/virtualbox-ext.sh` (take a look, it's not scary)

Initialize image storage to build images with packer:

```bash
cd terraform
terraform init
# You will get errors with the next command, it's fine
# Terraform tries to create machines with non-existent images
terraform plan -out /tmp/tfplan
# If you're happy
terraform apply /tmp/tfplan
```
