# AccelerateDevOps Repository Instructions

**Always reference these instructions first** and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

This is the companion repository for the book "Accelerate DevOps with GitHub" by Michael Kaufmann. It contains hands-on examples, sample applications, and DevOps workflows demonstrating GitHub features and best practices.

## Working Effectively

### Bootstrap and Setup
- **NEVER CANCEL**: All builds and operations may take longer than expected. Always set timeouts to 60+ minutes for builds and 30+ minutes for tests.
- Check prerequisites:
  - .NET SDK 8.0+ (compatible with .NET 5.0 projects)
  - Node.js (any recent version, tested with 20.x)
  - npm 10.x+
  - Docker (optional, for containerization)

### Core Applications and Build Processes

#### 1. Tailwind Traders Web Application (Primary Demo App)
**Location**: `ch9_release/src/Tailwind.Traders.Web/`
**Technology**: ASP.NET Core 5.0 + React SPA

**Build .NET Backend**:
```bash
cd ch9_release/src/Tailwind.Traders.Web
dotnet build --configuration Release
```
- **NEVER CANCEL**: Build takes 30-60 seconds. ALWAYS wait for completion.
- **Expected**: Security vulnerability warnings in dependencies (this is a demo repo with intentionally outdated packages)
- **Expected**: .NET 5.0 end-of-support warnings (project uses legacy framework for book compatibility)

**Build React Frontend** (Has Known Issues):
```bash
cd ch9_release/src/Tailwind.Traders.Web/ClientApp
npm install --legacy-peer-deps
```
- **NEVER CANCEL**: npm install takes 2-3 minutes. Wait for completion.
- **REQUIRED**: Use `--legacy-peer-deps` flag due to dependency conflicts
- **React Build Issues**: The React build (`npm run build`) has unresolved dependency issues and will fail. This is expected for this demo repository.
- **Workaround**: For validation, only test npm install, not the full React build

**Publish Application** (Backend Only):
```bash
cd ch9_release/src/Tailwind.Traders.Web
dotnet publish -c Release -o /tmp/publish --no-build
```
- **Note**: Full publish with React dependencies will fail due to npm issues in the .csproj build targets

#### 2. NPM Package Demo
**Location**: `ch8_packages/npm/`
**Purpose**: Demonstrates GitHub Packages npm registry

**Commands**:
```bash
cd ch8_packages/npm
npm install  # Takes <10 seconds
npm test     # Takes <5 seconds, always passes (exit 0)
```

#### 3. Docker Container Demo
**Location**: `ch8_packages/docker/`
**Purpose**: Simple Alpine container for GitHub Packages container registry

**Commands**:
```bash
cd ch8_packages/docker
docker build -t test-image .  # Takes 1-2 minutes
```
- **NEVER CANCEL**: Docker build takes 1-3 minutes depending on network

#### 4. Bot Framework Composer Project
**Location**: `ch14/TailwindTradersBotComposer/`
**Purpose**: Microsoft Bot Framework chatbot demo
**Note**: Cannot be easily built/tested in this environment (requires Bot Framework SDK)

### Testing and Validation

**Simple Tests That Work**:
- NPM package test: `cd ch8_packages/npm && npm test` (always passes)
- Docker build validation: `docker build` commands
- .NET compilation: `dotnet build` commands

**Tests That Don't Work** (Expected):
- React unit tests: Fail due to dependency issues
- Full application integration tests: Require external services (SQL Server, MongoDB, Azure services)

### Linting and Code Quality

**GitHub Super Linter** (Comprehensive):
```bash
# This runs in GitHub Actions, not locally
# See .github/workflows/Linter.yml for configuration
```
- **Validates**: Markdown, YAML, JavaScript, C#, Dockerfile, and more
- **NEVER CANCEL**: Linter can take 5-15 minutes on full codebase

**Manual Validation Steps**:
1. Check YAML syntax: `cd .github/workflows && ls *.yml`
2. Validate Markdown: Use any Markdown linter
3. Check Dockerfile syntax: `docker build` commands

## Key Repository Structure

### Chapter Directories (Book Examples)
- `ch3_pull-request/`: Pull request workflow examples
- `ch6_actions/`: GitHub Actions examples  
- `ch8_packages/`: Package management examples (npm, Docker)
- `ch9_release/`: Deployment examples (Azure, AWS, GKE) + main Tailwind Traders app
- `ch14/`: Bot Framework example
- `ch15_sec/`: Security examples

### GitHub Actions Workflows
**Location**: `.github/workflows/`
**Key Workflows**:
- `codeql-analysis.yml`: Security scanning (C# and JavaScript)
- `Deploy-Azure.yml`: Azure App Service deployment
- `Deploy-AWS.yml`: AWS ECS deployment  
- `Deploy-GKE.yml`: Google Kubernetes Engine deployment
- `Linter.yml`: Code quality validation
- `auto-merge.yml`: Dependabot automation

### Documentation
- `README.md`: Comprehensive book chapter index with links
- `docs/`: GitHub Pages site source
- Chapter-specific README files with hands-on instructions

## Troubleshooting and Known Issues

### Expected Issues (Do Not Try to Fix)
1. **React Build Failures**: Missing dependencies and compatibility issues in Tailwind Traders ClientApp
2. **Security Vulnerabilities**: Intentionally outdated packages for book compatibility
3. **.NET 5.0 Warnings**: End-of-support framework used for book examples
4. **Bot Framework Issues**: Requires specific SDK and service connections

### Dependency Management
- **npm**: Always use `--legacy-peer-deps` for React components
- **.NET**: Projects target .NET 5.0 but build successfully with .NET 8.0+ SDK
- **Docker**: All container builds should work without issues

### CI/CD Pipeline Validation
**Before making changes, always run**:
1. .NET build validation: `dotnet build ch9_release/src/Tailwind.Traders.Web --configuration Release`
2. Simple npm test: `cd ch8_packages/npm && npm test`
3. Docker build test: `cd ch8_packages/docker && docker build -t test .`

## Timing Expectations

**NEVER CANCEL these operations**:
- **.NET builds**: 30-60 seconds (set timeout: 5+ minutes)
- **npm install**: 2-3 minutes (set timeout: 10+ minutes)  
- **Docker builds**: 1-3 minutes (set timeout: 10+ minutes)
- **GitHub Super Linter**: 5-15 minutes (set timeout: 30+ minutes)

## Manual Validation Scenarios

**After making changes, always validate**:
1. **Build Validation**: Run .NET build to ensure no compilation errors
2. **Package Validation**: Test npm package to ensure basic npm operations work
3. **Container Validation**: Build Docker image to ensure containerization works
4. **Documentation Validation**: Check that Markdown files render correctly

## Common Commands Reference

**Repository Navigation**:
```bash
ls -la  # Root shows chapter directories (ch3_pull-request, ch8_packages, etc.)
find . -name "*.csproj" -o -name "package.json" -o -name "Dockerfile"  # Find all project files
```

**Quick Health Check**:
```bash
# Verify all core components work
dotnet --version  # Should be 8.0+
node --version    # Should be 18.0+
npm --version     # Should be 9.0+
docker --version  # Should be available
```

**Chapter 9 (Main App) Structure**:
```
ch9_release/src/Tailwind.Traders.Web/
├── Tailwind.Traders.Web.csproj  # Main .NET project
├── ClientApp/                    # React SPA (has issues)
├── Controllers/                  # ASP.NET Core controllers
├── Dockerfile                   # Container definition
└── Startup.cs                  # Application configuration
```

This repository prioritizes demonstrating DevOps practices over having a fully functional production application. Focus on the workflow automation, deployment patterns, and GitHub feature demonstrations rather than application functionality.