//🧭 2. UI Testing
//💬 คืออะไร?
//ทดสอบ “การโต้ตอบของผู้ใช้กับหน้าจอ” เช่น
//กดปุ่ม, พิมพ์ข้อความ, scroll, เปลี่ยนหน้า แล้วตรวจผลลัพธ์บน UI
//
//⚙️ สร้าง UI Test Target
//ใน Xcode:
//File → New → Target → iOS UI Testing Bundle → ตั้งชื่อ MyAppUITests
//Xcode จะสร้างไฟล์ MyAppUITests.swift

//✅ ตัวอย่าง: ทดสอบการกดปุ่ม
//สมมติในแอปมีปุ่มที่เปลี่ยนข้อความใน Label

import XCTest

final class UnitTestingUITestingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
//    🔹 ปุ่มและ Label ควรตั้ง “Accessibility Identifier” เพื่อให้ UI Test หาเจอง่าย
    @MainActor
    func testChangeTextButton() {
        let app = XCUIApplication()
        app.launch()

        let button = app.buttons["ChangeTextButton"]
        button.tap()

        let label = app.staticTexts["Hello iOS!"]
        XCTAssertTrue(label.exists)
    }
    
//    ⚡ ตัวอย่าง UI Test แบบกรอกข้อมูล
    func testLoginFlow() {
        let app = XCUIApplication()
        app.launch()

        let usernameField = app.textFields["UsernameTextField"]
        usernameField.tap()
        usernameField.typeText("admin")

        let passwordField = app.secureTextFields["PasswordTextField"]
        passwordField.tap()
        passwordField.typeText("1234")

        app.buttons["LoginButton"].tap()

        XCTAssertTrue(app.staticTexts["Welcome"].exists)
    }
}
