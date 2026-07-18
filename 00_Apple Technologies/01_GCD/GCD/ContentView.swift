//
//  ContentView.swift
//  GCD
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var outputText = "กดปุ่มเพื่อดูตัวอย่าง GCD"
    
    private let queueExamples = DispatchQueueExamples()
    private let groupExamples = DispatchGroupExamples()
    private let semaphoreExamples = DispatchSemaphoreExamples()
    private let workItemExamples = DispatchWorkItemExamples()
    private let barrierExamples = DispatchBarrierExamples()
    private let timerExamples = DispatchTimerExamples()
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("DispatchQueue") {
                    Button("1. Main Queue") {
                        queueExamples.mainQueueExample()
                        outputText = "ดูผลลัพธ์ใน Console"
                    }
                    Button("2. Custom Queue") {
                        queueExamples.customQueueExample()
                        outputText = "ดูผลลัพธ์ใน Console"
                    }
                    Button("3. Delayed (asyncAfter)") {
                        queueExamples.delayedExample()
                        outputText = "รอ 2 วินาที..."
                    }
                    Button("4. Sync") {
                        queueExamples.syncExample()
                        outputText = "ดูผลลัพธ์ใน Console"
                    }
                }
                
                Section("DispatchGroup") {
                    Button("5. Group Example") {
                        outputText = "กำลังทำงาน..."
                        groupExamples.groupExample { result in
                            outputText = result
                        }
                    }
                }
                
                Section("DispatchSemaphore") {
                    Button("6. Semaphore Example") {
                        outputText = "กำลังทำงาน..."
                        semaphoreExamples.semaphoreExample { result in
                            outputText = result
                        }
                    }
                }
                
                Section("DispatchWorkItem") {
                    Button("7. WorkItem Example") {
                        outputText = "กำลังทำงาน..."
                        workItemExamples.workItemExample { result in
                            outputText = result
                        }
                    }
                }
                
                Section("DispatchBarrier") {
                    Button("8. Barrier Example") {
                        outputText = "กำลังทำงาน..."
                        barrierExamples.barrierExample { result in
                            outputText = result
                        }
                    }
                }
                
                Section("DispatchTimer") {
                    Button("9. Timer Example") {
                        outputText = "กำลังทำงาน..."
                        timerExamples.timerExample { result in
                            outputText = result
                        }
                    }
                }
            }
            .navigationTitle("GCD Examples")
        } detail: {
            VStack(spacing: 20) {
                Text(outputText)
                    .font(.title2)
                    .padding()
                
                Text("เปิด Console เพื่อดูผลลัพธ์")
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
