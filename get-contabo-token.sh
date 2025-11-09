#!/bin/bash
# get-contabo-token.sh

set -e

echo "🔑 Getting Contabo API token..."

# Проверяем что переменные установлены
if [[ -z "$CONTABO_CLIENT_ID" || -z "$CONTABO_CLIENT_SECRET" || -z "$CONTABO_API_USER" || -z "$CONTABO_API_PASSWORD" ]]; then
    echo "❌ ERROR: Contabo environment variables are not set"
    echo "Please set: CONTABO_CLIENT_ID, CONTABO_CLIENT_SECRET, CONTABO_API_USER, CONTABO_API_PASSWORD"
    exit 1
fi

# Получаем токен
TOKEN_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  "https://auth.contabo.com/auth/realms/contabo/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "client_id=$CONTABO_CLIENT_ID" \
  --data-urlencode "client_secret=$CONTABO_CLIENT_SECRET" \
  --data-urlencode "username=$CONTABO_API_USER" \
  --data-urlencode "password=$CONTABO_API_PASSWORD" \
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
echo "🔐 Token: $TOKEN"

# Опционально: экспортируем токен как переменную окружения
export CONTABO_TOKEN="$TOKEN"
echo "📋 Token exported as CONTABO_TOKEN"