# 🚀 Quick Setup Guide

## Environment Variables Setup

### Option 1: Automated Setup (Recommended)
```bash
# Run the setup script
./scripts/setup-env.sh

# Then edit .env.local with your actual keys
code .env.local
```

### Option 2: Manual Setup
```bash
# Copy the template
cp env.template .env.local

# Edit with your keys
code .env.local
```

## Required Services Setup

### 1. Clerk Authentication
1. Go to [Clerk Dashboard](https://dashboard.clerk.com/)
2. Create a new application
3. Copy your API keys to `.env.local`
4. **Enable Organization**: Go to `Organization management` > `Settings` > `Enable organization`

### 2. Database (Choose one)

#### Option A: Local Development (PGlite - Default)
```bash
# No setup needed! PGlite works out of the box
DATABASE_URL="file:./local.db"
```

#### Option B: PostgreSQL (Production)
- **Supabase**: [supabase.com](https://supabase.com) (Free tier available)
- **Neon**: [neon.tech](https://neon.tech) (Free tier available)
- **PlanetScale**: [planetscale.com](https://planetscale.com) (Free tier available)

### 3. Stripe Billing (Optional)
1. Go to [Stripe Dashboard](https://dashboard.stripe.com/)
2. Get your API keys from `Developers` > `API Keys`
3. Set up webhooks for payment processing

### 4. Monitoring (Optional)
- **Sentry**: Error monitoring - [sentry.io](https://sentry.io)
- **Logtail**: Structured logging - [logtail.com](https://logtail.com)

## Security Checklist ✅

- [ ] `.env.local` is created and contains your keys
- [ ] `.env.local` is NOT committed to git (check `.gitignore`)
- [ ] Using different keys for dev/staging/production
- [ ] API keys are rotated after any exposure
- [ ] No hardcoded secrets in code
- [ ] Environment variables are validated with `@t3-oss/env-nextjs`

## Development Commands

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Run database migrations
npm run db:migrate

# Open database studio
npm run db:studio
```

## Troubleshooting

### Common Issues
1. **Database connection fails**: Check `DATABASE_URL` in `.env.local`
2. **Authentication not working**: Verify Clerk keys are correct
3. **Build errors**: Run `npm run check-types` to see TypeScript errors

### Getting Help
- Check `SECURITY.md` for security guidelines
- See `.cursorrules-troubleshooting.md` for detailed troubleshooting
- Review the main `README.md` for complete documentation
