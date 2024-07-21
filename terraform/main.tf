terraform {
}

# You can hard-code your credentials here but it is STRONGLY
# recommended that you don't. Export them to the environment you
# run the 'terraform' command from instead, at the bare minimum!
provider "aws" {
#   access_key = var.AWS_ACCESS_KEY_ID
#   secret_key = var.AWS_SECRET_ACCESS_KEY
#   region = var.AWS_DEFAULT_REGION
}