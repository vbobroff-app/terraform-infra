# **Terraform Infra**

Infrastructure as Code for cloud resources and networking

## Overview
Terraform configurations for managing Yandex Cloud infrastructure including:
- VPC networks and subnets
- VPN gateways and connectivity
- Security groups and access rules
- Compute instances and storage

## Quick Start
It's concept 

```bash
terraform init
terraform plan
terraform apply
```

In this case

```bash
# Применяем только Yandex  модуль, игнорируя Contabo 
terraform apply -target="module.network"
# Применяем только Contabo модуль, игнорируя Yandex
terraform apply -target="module.vps_contabo_simple" -auto-approve
```


```bash
terraform-vpn-infra/
├── .config
│       ├──ya/.ya.tfvars
│       ├──cnttb/.cntb.tfvars           
├── contabo/
│   ├── main.tf
│   └── variables.tf
└── yandex/
    ├── main.tf
    └── variables.tf
```
Запускаем отдельно
```bash
cd ./terraform-infra/yandex
terraform plan -var-file="../.config/ya/.ya.tfvars"
cd ./terraform-infra/contabo
terraform plan -var-file="../.config/cntb/.cntb.tfvars"
```
