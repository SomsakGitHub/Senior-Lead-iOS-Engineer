import Foundation

class BadCalculator {

    // Code Smell: unused variable
    func add(_ a: Int, _ b: Int) -> Int {
        let temp = 999   // unused variable → Code Smell
        return a + b
    }

    // Bug: division by zero risk
    func divide(_ a: Int, _ b: Int) -> Int {
        return a / b      // potential crash if b = 0 → Bug
    }

    // Vulnerability: hardcoded secret
    let apiKey = "123456-SECRET"   // Vulnerability → Hardcoded secret

    // Long method → Code Smell
    func longMethod() {
        for i in 0...100 {
            print("Spam line \(i)")
        }
    }
}
