//1️⃣ SonarQube คืออะไร
//
//SonarQube เป็น เครื่องมือวิเคราะห์คุณภาพโค้ด (Static Code Analysis) ใช้ตรวจสอบ:
//
//Bugs / Defects
//
//Code Smells
//
//Security Vulnerabilities
//
//Duplicated Code
//
//Code Coverage (ถ้ามี Integration กับ Unit Test)
//
//มันรองรับหลายภาษา รวมทั้ง Swift ผ่าน SonarScanner หรือ SonarSwift Plugin

//2️⃣ การใช้ SonarQube กับ Swift
//Step 1: ติดตั้ง SonarQube
//
//มีหลายวิธี:
//
//ใช้ Docker
//
//docker run -d --name sonarqube -p 9000:9000 sonarqube
//
//หรือดาวน์โหลดตรงจาก SonarQube Official

//Step 2: ติดตั้ง SonarScanner
//
//SonarScanner เป็นเครื่องมือ command line ที่ใช้ส่งโค้ดไปวิเคราะห์
//
//บน Mac:
//
//brew install sonar-scanner

//Step 3: ตั้งค่าโครงการ Swift
//
//สร้างไฟล์ sonar-project.properties ใน root project
//
//sonar.projectKey=MaraudersIOS
//sonar.projectName=Marauders iOS
//sonar.projectVersion=1.0
//sonar.language=swift
//sonar.sources=.
//sonar.exclusions=**/Pods/**,**/*.xcodeproj/**
//sonar.swift.coverage.reportPaths=reports/coverage.xml

//ถ้าใช้ Xcode Coverage, export เป็น .xccovreport แล้วแปลงเป็น coverage.xml ด้วย xccov-to-sonarqube
//
//xccov-to-sonarqube --input ./DerivedData/Marauders/Logs/Test/*.xccovreport --output reports/coverage.xml

//Step 4: รัน SonarScanner
//sonar-scanner

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Calculator {
    func add(_ a: Int, _ b: Int) -> Int {
        let temp = 999
        return a + b
    }
}
