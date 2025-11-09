#!/bin/bash
# get-token-from-cntb-config.sh

set -e

echo "🔑 Reading Contabo credentials from cntb config and getting token..."

# Путь к конфиг файлу
#CONFIG_FILE="$HOME/.config/cntb/.cntb.yaml"
CONFIG_FILE=".config/cntb/.cntb.yaml"

# Проверяем что файл существует
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Config file not found: $CONFIG_FILE"
    exit 1
fi

# Функция для извлечения значений из YAML
get_yaml_value() {
    local key="$1"
    grep "^$key:" "$CONFIG_FILE" | awk '{print $2}'
}

# Извлекаем credentials из YAML
CLIENT_ID=$(get_yaml_value "oauth2-clientid")
CLIENT_SECRET=$(get_yaml_value "oauth2-client-secret") 
API_USER=$(get_yaml_value "oauth2-user")
API_PASSWORD=$(get_yaml_value "oauth2-password")

# Проверяем что все значения извлечены
if [[ -z "$CLIENT_ID" || -z "$CLIENT_SECRET" || -z "$API_USER" || -z "$API_PASSWORD" ]]; then
    echo "❌ Failed to extract credentials from config file"
    echo "Found:"
    echo "  Client ID: ${CLIENT_ID:0:5}..."
    echo "  Client Secret: ${CLIENT_SECRET:0:5}..." 
    echo "  API User: ${API_USER:0:5}..."
    echo "  API Password: ${API_PASSWORD:0:5}..."
    exit 1
fi

echo "✅ Credentials extracted from config"

# Получаем токен
echo "🔄 Getting token from Contabo API..."
TOKEN_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  "https://auth.contabo.com/auth/realms/contabo/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "client_id=$CLIENT_ID" \
  --data-urlencode "client_secret=$CLIENT_SECRET" \
  --data-urlencode "username=$API_USER" \
  --data-urlencode "password=$API_PASSWORD" \
  --data-urlencode "grant_type=password")

# Извлекаем HTTP статус и тело ответа
HTTP_CODE=$(echo "$TOKEN_RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$TOKEN_RESPONSE" | head -n -1)

if [ "$HTTP_CODE" != "200" ]; then
    echo "❌ API Error: HTTP $HTTP_CODE"
    echo "Response: $RESPONSE_BODY"
    exit 1
fi

TOKEN=$(echo "$RESPONSE_BODY" | jq -r '.access_token')

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
    echo "❌ Failed to extract token from response"
    echo "Response: $RESPONSE_BODY"
    exit 1
fi

echo "✅ Token obtained successfully!"
echo "🔐 Token: ${TOKEN:0:50}..."

# Экспортируем токен как переменную окружения
export CONTABO_TOKEN="$TOKEN"
echo "📋 Token exported as CONTABO_TOKEN"

# Также экспортируем credentials для Terraform
export CONTABO_CLIENT_ID="$CLIENT_ID"
export CONTABO_CLIENT_SECRET="$CLIENT_SECRET" 
export CONTABO_API_USER="$API_USER"
export CONTABO_API_PASSWORD="$API_PASSWORD"

echo "🎯 All credentials exported to environment variables"