.PHONY: clean init plan apply destroy fmt validate

clean:
	@echo "🧹 Cleaning temporary files..."
	./cleanup.sh

init:
	@echo "🚀 Initializing Terraform..."
	terraform init

plan:
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

validate: init
	@echo "✅ Validating configuration..."
	terraform validate

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
auto-apply:
	@echo "🛠 Applying configuration (approve yes) ..."
	terraform apply -auto-approve