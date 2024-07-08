# Needs to be further parameterized
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_$1 -q -N ""
ssh-copy-id -i ~/.ssh/id_ed25519_$1 mcp@dev.ournetwork.ca

# Setup ssh key in config
# Host dev.ournetwork.ca
#   HostName dev.ournetwork.ca 
#   IdentityFile ~/.ssh/id_ed25519_dev