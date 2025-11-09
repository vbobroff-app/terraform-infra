#!/bin/bash
# print-cntb-config.sh - Просто выводит значения из cntb.yaml

#CONFIG_FILE="$HOME/.config/cntb/.cntb.yaml"
CONFIG_FILE=".config/cntb/.cntb.yaml"


# Проверяем существует ли файл
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Файл конфигурации не найден: $CONFIG_FILE"
    exit 1
fi

echo "📁 Чтение конфигурации из: $CONFIG_FILE"
echo "=========================================="

# Функция для извлечения значения из YAML
get_yaml_value() {
    local key="$1"
    grep "^$key:" "$CONFIG_FILE" | awk -F': ' '{print $2}' | sed "s/^'//;s/'$//"
}

# Извлекаем и выводим значения
echo "oauth2-clientid: $(get_yaml_value 'oauth2-clientid')"
echo "oauth2-client-secret: $(get_yaml_value 'oauth2-client-secret')"
echo "oauth2-user: $(get_yaml_value 'oauth2-user')"
echo "oauth2-password: $(get_yaml_value 'oauth2-password')"
echo "oauth2-tokenurl: $(get_yaml_value 'oauth2-tokenurl')"
echo "api: $(get_yaml_value 'api')"

echo "=========================================="
echo "✅ Конфигурация прочитана успешно"