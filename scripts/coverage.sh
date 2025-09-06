#!/bin/bash

# Analytics Test Coverage Script

set -e

echo "🧪 Running tests with JaCoCo coverage analysis..."

# Run tests with coverage
mvn clean test jacoco:report

echo ""
echo "✅ Coverage report generated successfully!"
echo ""
echo "📊 Coverage Summary:"
echo "==================="

# Display coverage summary from CSV
if [ -f "target/site/jacoco/jacoco.csv" ]; then
    echo "Coverage metrics:"
    cat target/site/jacoco/jacoco.csv | while IFS=',' read -r group package class instruction_missed instruction_covered branch_missed branch_covered line_missed line_covered complexity_missed complexity_covered method_missed method_covered; do
        if [ "$group" != "GROUP" ]; then
            total_instructions=$((instruction_missed + instruction_covered))
            total_branches=$((branch_missed + branch_covered))
            total_lines=$((line_missed + line_covered))
            total_methods=$((method_missed + method_covered))
            
            if [ $total_instructions -gt 0 ]; then
                instruction_coverage=$((instruction_covered * 100 / total_instructions))
                echo "  📈 Instruction Coverage: $instruction_coverage% ($instruction_covered/$total_instructions)"
            fi
            
            if [ $total_branches -gt 0 ]; then
                branch_coverage=$((branch_covered * 100 / total_branches))
                echo "  🌿 Branch Coverage: $branch_coverage% ($branch_covered/$total_branches)"
            fi
            
            if [ $total_lines -gt 0 ]; then
                line_coverage=$((line_covered * 100 / total_lines))
                echo "  📝 Line Coverage: $line_coverage% ($line_covered/$total_lines)"
            fi
            
            if [ $total_methods -gt 0 ]; then
                method_coverage=$((method_covered * 100 / total_methods))
                echo "  🔧 Method Coverage: $method_coverage% ($method_covered/$total_methods)"
            fi
        fi
    done
fi

echo ""
echo "📁 Coverage reports available at:"
echo "  - HTML Report: target/site/jacoco/index.html"
echo "  - XML Report: target/site/jacoco/jacoco.xml"
echo "  - CSV Report: target/site/jacoco/jacoco.csv"
echo ""
echo "🌐 To view the HTML report:"
echo "  open target/site/jacoco/index.html"
echo ""
echo "🔍 To check coverage thresholds:"
echo "  mvn jacoco:check"
