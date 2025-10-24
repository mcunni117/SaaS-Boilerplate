# 🔒 Security Guidelines

## Environment Variables & Secrets Management

### ⚠️ CRITICAL: Never commit secrets to version control

### Required Environment Files
- `env.template` - Template with placeholder values (safe to commit)
- `.env.local` - Local development secrets (NEVER commit)
- `.env.production` - Production secrets (NEVER commit)

### Quick Setup
```bash
# Automated setup (recommended)
npm run setup:env

# Manual setup
cp env.template .env.local
# Then edit .env.local with your actual keys
```

### Security Checklist
- [ ] All API keys are in environment variables
- [ ] No hardcoded secrets in code
- [ ] `.env*` files are in `.gitignore`
- [ ] Use `env.template` as template
- [ ] Rotate keys after any exposure
- [ ] Use different keys for dev/staging/production
- [ ] Run security checks before committing

### Automated Security Protection

#### 1. Pre-commit Security Checks
This project includes automated security checks that run before every commit:
- Environment file detection
- Secret pattern scanning
- Large file warnings
- API key format validation

#### 2. Gitignore Protection
Comprehensive `.gitignore` rules prevent accidental commits:
```
# Environment files - CRITICAL SECURITY
.env
.env.*
!.env.example
.env.local
.env.development.local
.env.test.local
.env.production.local
```

#### 3. Manual Security Checks
```bash
# Run security check manually
npm run security:check

# Check for exposed secrets in git history
git log --all --full-history -- .env*
```

### Emergency Response Protocol
If secrets are accidentally committed:

1. **IMMEDIATELY** revoke all exposed keys
2. Remove from git history:
   ```bash
   git filter-branch --force --index-filter \
   'git rm --cached --ignore-unmatch .env*' \
   --prune-empty --tag-name-filter cat -- --all
   ```
3. Force push to remove from remote history:
   ```bash
   git push origin --force --all
   ```
4. Regenerate all affected keys
5. Audit access logs for unauthorized usage
6. Update security measures

### Best Practices
- Use environment-specific configurations
- Implement secret rotation policies
- Monitor for exposed secrets in CI/CD
- Use secret management services (AWS Secrets Manager, Azure Key Vault, etc.)
- Regular security audits
- Never share environment files via email/chat
- Use different keys for each environment

### Security Tools Integration
- **Pre-commit hooks**: Automatic secret scanning
- **Gitignore rules**: Prevent accidental commits
- **Environment validation**: Type-safe env vars with `@t3-oss/env-nextjs`
- **Template system**: Safe environment file templates
- **Documentation**: Clear setup and security guidelines
