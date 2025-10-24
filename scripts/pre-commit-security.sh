#!/bin/bash

# ===========================================
# Pre-commit Security Check
# ===========================================
# This script prevents accidental commit of secrets

set -e

echo "🔒 Running security checks..."

# Check for environment files
if git diff --cached --name-only | grep -E '\.env$|\.env\.[^.]*$' | grep -v '\.env\.example$'; then
    echo "❌ ERROR: Environment files detected in commit!"
    echo "   Environment files should never be committed to version control."
    echo "   Use .env.example as a template instead."
    echo ""
    echo "   Files detected:"
    git diff --cached --name-only | grep -E '\.env$|\.env\.[^.]*$' | grep -v '\.env\.example$'
    echo ""
    echo "   To fix:"
    echo "   1. Remove these files from staging: git reset HEAD <file>"
    echo "   2. Add them to .gitignore if not already there"
    echo "   3. Use .env.example as a template for others"
    exit 1
fi

# Check for common secret patterns
SECRET_PATTERNS=(
    "sk_live_"
    "sk_test_"
    "pk_live_"
    "pk_test_"
    "whsec_"
    "sk-"
    "rk-"
    "xoxb-"
    "xoxp-"
    "xoxa-"
    "xoxr-"
    "xoxs-"
    "AIza"
    "ya29\."
    "1//"
    "AKIA"
    "ASIA"
    "arn:aws:"
    "-----BEGIN PRIVATE KEY-----"
    "-----BEGIN RSA PRIVATE KEY-----"
    "-----BEGIN OPENSSH PRIVATE KEY-----"
    "mongodb://"
    "postgresql://"
    "mysql://"
    "redis://"
    "ftp://"
    "sftp://"
    "ssh://"
    "password="
    "secret="
    "api_key="
    "access_token="
    "refresh_token="
    "bearer_token="
    "jwt_secret="
    "encryption_key="
    "private_key="
    "client_secret="
    "webhook_secret="
)

# Check staged files for secret patterns
for pattern in "${SECRET_PATTERNS[@]}"; do
    if git diff --cached | grep -i "$pattern" > /dev/null; then
        echo "❌ ERROR: Potential secret detected in commit!"
        echo "   Pattern found: $pattern"
        echo "   This might be an API key, token, or other sensitive information."
        echo ""
        echo "   Please remove any secrets from your commit and use environment variables instead."
        echo "   See SECURITY.md for guidelines."
        exit 1
    fi
done

# Check for large files that might contain secrets
if git diff --cached --name-only | xargs -I {} sh -c 'if [ -f "{}" ] && [ $(wc -c < "{}") -gt 1048576 ]; then echo "{}"; fi' | grep -v node_modules | grep -v .next | grep -v coverage; then
    echo "⚠️  WARNING: Large files detected in commit."
    echo "   Make sure these don't contain sensitive information."
    echo "   Consider using Git LFS for large files."
fi

echo "✅ Security checks passed!"
echo "   No secrets detected in commit."
