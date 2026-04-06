#!/bin/bash
echo "This is a placeholder script for coverage generation."

set -e

SCHEME="SonarQube"
DESTINATION="platform=iOS Simulator,name=iPhone 17"

OUTPUT_DIR="reports"
mkdir -p $OUTPUT_DIR

echo "🧪 Running tests and generating coverage..."

xcodebuild test \
  -scheme "$SCHEME" \
  -destination "$DESTINATION" \
  -enableCodeCoverage YES \
  -resultBundlePath result

echo "📦 Converting coverage..."
./scripts/xccov-to-sonarqube \
  --input result/Logs/Test/*.xcresult \
  --output reports/coverage.xml

echo "✅ coverage.xml generated"

