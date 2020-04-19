# Tsipis

Loosely translated to "cheap fuck" from Greek, Tsipis is there to provide you
a pentest cloud infrastructure for free. It uses the free resources that
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
  - If you don't want to give full access to your heroku account,
  create a Team (needs Credit Card)
  - Go to [Manage Account/Applications/Create authorization](https://dashboard.heroku.com/account/applications/authorizations/new), give it a friendly name and some expiry
  - Write on `~/.tsipis/heroku.yml`: `email: "<your_email>"` and `api_key: "<api_key>"`
  - (Optional) Add a credit card to receive 450 more dynos from the basic 550
- Google Cloud
  - Create a project
  - Create a [Service Account](https://console.cloud.google.com/apis/credentials/serviceaccountkey) "Project/Owner" and save to `~/.tsipis/google.json`
  - Go to [API Library](https://console.developers.google.com/apis/dashboard) and enable:
    - [Compute Engine API](https://console.developers.google.com/apis/api/compute.googleapis.com)
  - (Optional) Create a budget in Billing/Budgets & alerts (0 is ok)

## Deploying

I guess you have gathered all the credentials, as instructed above.
You will need to install:
- `terraform` (> 0.12)
- `jq`
- `gopass`
- `ansible` (> 2.0)

The terraform plugin for [gopass integration](https://github.com/camptocamp/terraform-provider-pass) is also required.

Provided services:
- Metasploit REST API - for msf on multiplayer
- [Pupy](https://github.com/n1nj4sec/pupy)
- [Koadic](https://github.com/zerosum0x0/koadic)
- [Faraday IDE](https://github.com/infobyte/faraday)
- [KingPhisher](https://github.com/rsmusllp/king-phisher)

Meta services:
- Logging & monitoring on logz.io
- Scheduler to automate recurring jobs (DNS enumeration etc.)
- Reverse proxy to hide each listener behind weird URLs/cookies/headers/etc.
- Usage of gopass for easy credential distribution across the team

## Setup

This section describes how to set up the various services.

Account API tokens and account-specific secrets are stored
in `ansible/vault.yml`. This is a very sensitive file and can be used
to overcharge the cloud accounts. DON'T lose it and probably DON'T share it.
You can store the vault password in gopass, as described below.

Admin credentials for each service are held in gopass - set it up.

If you want to give very limited access, I guess good luck, this isn't a
production environment of a big corp! I'll try though to create a process
for such cases at some point...

### Metasploit

This guy (as you may now) is a bit tricky.

First of all you need a working LOCAL database. That means a local postgres DB.
If you're on Kali you're probably good. If you're not on Kali, install
the postgresql server (find the package in your distro), start it, connect
to it (maybe this will work as root: `su - postgres psql`) and execute
the following:

```pgsql
create database msf;
create user msf with password 'mypassword';
grant all privileges on database msf to msf;
```

Now in your users home folder edit `~/.msf4/database.yml` to reflect the correct
credentials (also the port that postgres is listening is probably 5432).

After that, run `msfconsole`.

`db_status` should return something like
`[*] Connected to msf. Connection type: postgresql.`

Perfect! :)

TODO: How to find Metasploit instance ip/domain? Give url
TODO: How to find admin credentials
TODO: How to add more users?

Now visit the Metasploit instance over http on port 5443 and path
`/api/v1/auth/login`, log in with your credentials and generate/view your
API token.

Back to the `msfconsole`:

`db_connect -t <api_token> --name tsipis http://<metasploit-host>:5443`

From now on every time you fire up msfconsole you can just
`db_connect tsipis` (or add it to your `~/.msf4/msfconsole.rc`)

## Building the images with packer

You will need `jq`, `packer` & `virtualbox`.

VirtualBox also needs 'Oracle VM VirtualBox Extension Pack'.
To install it, execute `scripts/virtualbox-ext.sh` (take a look, it's not scary)

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

## Using gopass with ansible-vault

Create the following files in the root directory (they are git ignored):

`ansible.cfg`
```ini
[defaults]
vault_identity_list = ansible@vault.sh
```

`vault.sh`
```shell script
#!/bin/sh
# Of course any other command that spits the password will work
gopass show "my/vault/password/path"
```

Now to copy the default `vault.example.yml`:

```shell script
ansible-vault encrypt --output vault.yml vault.example.yml
```

Edit it with `ansible-vault edit vault.yml`
