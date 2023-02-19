
tf-docs:
	terraform-docs markdown table terraform/ --output-file ../README.md

tf-validate:
	@terraform -chdir=terraform validate

tf-fmt-check:
	@terraform -chdir=terraform fmt --check

tf-fmt:
	@terraform -chdir=terraform fmt
