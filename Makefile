.PHONY: clean init plan apply destroy fmt validate

clean:
	@echo "🧹 Cleaning temporary files..."
	./cleanup.sh

init:
	@echo "🚀 Initializing Terraform..."
	terraform init

validate:
	@echo "✅ Validating configuration..."
	terraform validate

plan: validate
	@echo "📋 Generating plan..."
	terraform plan

apply:
	@echo "🛠 Applying configuration..."
	terraform apply

destroy: init
	@echo "🗑 Destroying infrastructure..."
	terraform destroy

fmt:
	@echo "🎨 Formatting code..."
	terraform fmt -recursive

output:
	@echo "📤 Printing outputs..."
	terraform output

show:
	@echo "📤 Showing outputs..."
	terraform output

state-list:
	@echo "📝 Listing state..."
	terraform state list

# Отдельная цель для полной переинициализации
reinit: clean init
	@echo "🔄 Complete reinitialization done!"

# Быстрое применение без лишних вопросов
auto-apply: validate
	@echo "🛠 Applying configuration (approve yes) ..."
	terraform apply -auto-approve

console:
	@echo  "💻 Open Terraform CLI... and then press 'exit' to quit"
	terraform console

setup-env:
	@echo "⚙️  Setup env..."
	bash -c "source ./set-contabo-env.sh"

auto-apply-with-setup: validate
	@echo "⚙️ Setup env and apply..."
	bash -c "source ./set-contabo-env.sh && terraform apply -auto-approve"

contabo-token:
	./get-contabo-token.sh

apply-with-token: contabo-token
	terraform apply