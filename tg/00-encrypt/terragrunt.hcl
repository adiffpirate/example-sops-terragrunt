locals {
	# Generate keys
	keygen = run_cmd("--terragrunt-quiet", "age-keygen")
	# keygen content:
	#   # created: 2021-11-13T04:29:06-03:00
	#   # public key: age123456789
	#   AGE-SECRET-KEY-ASDFGHJKLQWERTYUIOZXCVBNM

	# Get fourth word on the second line
	public_key = element(split(" ", element(split("\n", local.keygen), 1)), 3)
	# Get third line
	private_key = element(split("\n", local.keygen), 2)
}

terraform {
  after_hook "after_hook" {
    commands     = ["apply"]
    execute      = ["${find_in_parent_folders("scripts")}/get_keys.sh"]
    run_on_error = true
  }
}

inputs = {
	public_key  = local.public_key
	private_key = local.private_key
}
