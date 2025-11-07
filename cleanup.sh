#!/bin/bash

# Script to clean Terraform temporary files safely
set -e

echo "🧹 Starting Terraform cleanup..."

# Check if we're in a git repository (safety check)
if [ ! -d .git ]; then
    echo "⚠️  Warning: Not in a git repository. Are you in the right directory?"
    read -p "Continue anyway? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Files and directories to remove
items=(
    ".terraform"
    "*.tfstate"
    "*.tfstate.backup" 
    ".terraform.lock.hcl"
    "*.tfplan"
    "crash.log"
    "crash.*.log"
)

# Remove each item
for item in "${items[@]}"; do
    if [ -e $item ] || [ -d $item ] 2>/dev/null; then
        echo "Removing: $item"
        rm -rf $item
    else
        echo "Not found: $item"
    fi
done

echo "✅ Terraform cleanup completed!"
# echo "📁 Remaining files:"
# ls -la | grep -E "(\.tf|\.json|\.sh|\.md)$"