# #!/bin/bash
# set -e

# echo "🧹 Cleaning old coverage..."
# rm -f coverage.xml

# echo "🧪 Step 1: Generate Coverage"
# .scripts/generate-coverage.sh

# echo "🔍 Step 2: Run Sonar Scanner"
# sonar-scanner

# echo "🎉 Done! Check results on SonarQube dashboard."

#!/bin/bash
set -e

PROJECT="SonarQube.xcodeproj"
SCHEME="SonarQube"
DEST="platform=iOS Simulator,name=iPhone 17"

# 🧹 Cleanup old result bundle
rm -rf build/TestResults.xcresult
rm -rf build/TestResults

echo "🔨 Running tests..."
xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "$DEST" \
  -enableCodeCoverage YES \
  clean test \
  -resultBundlePath build/TestResults.xcresult \
  | xcpretty -r json-compilation-database -o compile_commands.json

echo "📊 Generating coverage..."
xcrun xccov view --report --json build/TestResults.xcresult > build/coverage.json
xcrun xccov view --report build/TestResults.xcresult > build/coverage.txt

# แปลงเป็น XML (ใช้ community tool)
# xccov-to-sonarqube-generic.sh build/TestResults.xcresult > build/coverage.xml

./xccov-to-sonarqube-generic.sh build/TestResults.xcresult > build/coverage.xml

echo "🚀 Running SonarScanner..."
sonar-scanner


