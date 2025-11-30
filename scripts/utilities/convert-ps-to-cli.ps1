# Get all Key Vaults in the subscription
vaults=$(az keyvault list --query "[].name" -o tsv)

# Loop through each Key Vault
for vault in $vaults; do
  # Get all secrets in the Key Vault
  secrets=$(az keyvault secret list --vault-name $vault --query "[].name" -o tsv)

  # Loop through each secret
  for secret in $secrets; do
    # Check if the secret name includes "vm"
    if [[ $secret == *"vm"* ]]; then
      # Get the secret's last accessed time
      lastAccessed=$(az keyvault secret show --vault-name $vault --name $secret --query "attributes.updated" -o tsv)

      # Create a custom object and output it
      output="{\"Vault\":\"$vault\",\"Secret\":\"$secret\",\"Last_accessed\":\"$lastAccessed\"}"

      # Output the custom object
      echo $output
    fi
  done
done
