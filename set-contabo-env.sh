#!/bin/bash
# set-contabo-env.sh - Установка переменных Contabo из cntb.yaml

#CONFIG_FILE="$HOME/.config/cntb/.cntb.yaml"
CONFIG_FILE=".config/cntb/.cntb.yaml"

# Проверяем существует ли файл
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Файл конфигурации не найден: $CONFIG_FILE"
    exit 1
fi

# Функция для извлечения значения из YAML
get_yaml_value() {
    local key="$1"
    grep "^$key:" "$CONFIG_FILE" | awk '{print $2}' | tr -d '"'"'"
}

# Извлекаем значения из YAML
CLIENT_ID=$(get_yaml_value "oauth2-clientid")
CLIENT_SECRET=$(get_yaml_value "oauth2-client-secret") 
API_USER=$(get_yaml_value "oauth2-user")
API_PASSWORD=$(get_yaml_value "oauth2-password")

# Проверяем что все значения получены
if [ -z "$CLIENT_ID" ] || [ -z "$CLIENT_SECRET" ] || [ -z "$API_USER" ] || [ -z "$API_PASSWORD" ]; then
    echo "❌ Не удалось извлечь все credentials из конфигурации"
    exit 1
fi

# Устанавливаем переменные окружения
export CONTABO_CLIENT_ID="$CLIENT_ID"
export CONTABO_CLIENT_SECRET="$CLIENT_SECRET"
export CONTABO_API_USER="$API_USER"
export CONTABO_API_PASSWORD="$API_PASSWORD"

# Выводим информацию (без паролей)
echo "✅ Переменные окружения установлены:"
echo "   CONTABO_CLIENT_ID: $CLIENT_ID"
echo "   CONTABO_CLIENT_SECRET: ${CLIENT_SECRET:0:4}..."  # Показываем только первые 4 символа
echo "   CONTABO_API_USER: $API_USER"
echo "   CONTABO_API_PASSWORD: ${API_PASSWORD:0:4}..."    # Показываем только первые 4 символа

# Проверяем что переменные установились
echo ""
echo "🔍 Проверка переменных окружения:"
env | grep CONTABO | while read line; do
    key=$(echo "$line" | cut -d= -f1)
    value=$(echo "$line" | cut -d= -f2)
    if [ "$key" = "CONTABO_CLIENT_SECRET" ] || [ "$key" = "CONTABO_API_PASSWORD" ]; then
        echo "   $key: ${value:0:4}..."  # Скрываем чувствительные данные
    else
        echo "   $key: $value"
    fi
done

echo ""
echo "🚀 Теперь можно запускать: terraform apply"