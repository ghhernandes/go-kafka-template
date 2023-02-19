
tf-docs:
	terraform-docs markdown table terraform/ --output-file ../README.md

tf-init:
	@terraform -chdir=terraform init

tf-validate:
	@terraform -chdir=terraform validate

tf-fmt:
	@terraform -chdir=terraform fmt

tf-fmt-check:
	@terraform -chdir=terraform fmt --check

tf-plan:
	@terraform -chdir=terraform plan

tf-apply:
	@terraform -chdir=terraform apply -auto-approve

tf-destroy:
	@terraform -chdir=terraform destroy -auto-approve
