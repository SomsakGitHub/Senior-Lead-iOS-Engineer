//
//  GCDExamples.swift
//  GCD
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import SwiftUI

// MARK: - 1. DispatchQueue พื้นฐาน
@MainActor
final class DispatchQueueExamples {
    
    // ส่ง work ไป main queue (ใช้กับ UI)
    nonisolated func mainQueueExample() {
        print("Main Queue Example - เริ่มทำงาน")
        DispatchQueue.main.async {
            @MainActor in
            print("Main Queue Example - กำลังทำงานบน Main Thread")
        }
        print("Main Queue Example - ทำงานต่อ")
    }
    
    // สร้าง custom queue
    nonisolated func customQueueExample() {
        let customQueue = DispatchQueue(label: "com.example.customQueue", qos: .userInitiated)
        customQueue.async {
            print("Custom Queue - กำลังทำงานบน Background Thread: \(Thread.current)")
        }
        print("Custom Queue - ทำงานต่อบน Main Thread")
    }
    
    // ใช้ asyncAfter เพื่อหน่วงเวลา
    nonisolated func delayedExample() {
        print("Delayed Example - เริ่มทำงาน")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            @MainActor in
            print("Delayed Example - ทำงานหลังจาก 2 วินาที")
        }
        print("Delayed Example - ทำงานต่อ")
    }
    
    // ใช้ sync เพื่อรอ work เสร็จ
    nonisolated func syncExample() {
        print("Sync Example - เริ่มทำงาน")
        let customQueue = DispatchQueue(label: "com.example.syncQueue")
        customQueue.sync {
            print("Sync Example - กำลังทำงานบน Background Thread")
        }
        print("Sync Example - ทำงานต่อ (รอ work เสร็จแล้ว)")
    }
}

// MARK: - 2. DispatchGroup
@MainActor
final class DispatchGroupExamples {
    
    func groupExample(completion: @escaping @MainActor (String) -> Void) {
        let group = DispatchGroup()
        
        // Task 1
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            print("Group Example - Task 1 เสร็จ")
            group.leave()
        }
        
        // Task 2
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            print("Group Example - Task 2 เสร็จ")
            group.leave()
        }
        
        // Task 3
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            print("Group Example - Task 3 เสร็จ")
            group.leave()
        }
        
        // รอทุก task เสร็จ
        group.notify(queue: .main) {
            print("Group Example - ทุก task เสร็จแล้ว!")
            completion("Group Example - ทุก task เสร็จแล้ว!")
        }
    }
}

// MARK: - 3. DispatchSemaphore
@MainActor
final class DispatchSemaphoreExamples {
    
    func semaphoreExample(completion: @escaping @MainActor (String) -> Void) {
        let semaphore = DispatchSemaphore(value: 2) // อนุญาต 2 concurrent
        let queue = DispatchQueue.global()
        
        for i in 1...5 {
            queue.async {
                semaphore.wait()
                print("Semaphore Example - Task \(i) เริ่มทำงาน")
                Thread.sleep(forTimeInterval: Double.random(in: 0.5...2.0))
                print("Semaphore Example - Task \(i) เสร็จ")
                semaphore.signal()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
            completion("Semaphore Example - ทุก task เสร็จแล้ว!")
        }
    }
}

// MARK: - 4. DispatchWorkItem
@MainActor
final class DispatchWorkItemExamples {
    
    func workItemExample(completion: @escaping @MainActor (String) -> Void) {
        var isCancelled = false
        
        let workItem = DispatchWorkItem {
            print("WorkItem Example - เริ่มทำงาน")
            for i in 1...10 {
                if isCancelled {
                    print("WorkItem Example - ถูกยกเลิกที่ step \(i)")
                    return
                }
                print("WorkItem Example - Step \(i)")
                Thread.sleep(forTimeInterval: 0.5)
            }
            print("WorkItem Example - เสร็จ!")
        }
        
        // เริ่ม work
        DispatchQueue.global().async(execute: workItem)
        
        // ยกเลิกหลังจาก 3 วินาที
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            print("WorkItem Example - กำลังยกเลิก...")
            isCancelled = true
            workItem.cancel()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                completion("WorkItem Example - ถูกยกเลิกแล้ว!")
            }
        }
    }
}

// MARK: - 5. DispatchBarrier
@MainActor
final class DispatchBarrierExamples {
    
    func barrierExample(completion: @escaping @MainActor (String) -> Void) {
        let queue = DispatchQueue(label: "com.example.barrierQueue", attributes: .concurrent)
        
        // อ่านข้อมูลพร้อมกัน
        for i in 1...3 {
            queue.async {
                print("Barrier Example - Reading task \(i)")
                Thread.sleep(forTimeInterval: 0.3)
            }
        }
        
        // เขียนข้อมูลด้วย barrier
        queue.async(flags: .barrier) {
            print("Barrier Example - Writing (barrier)")
            Thread.sleep(forTimeInterval: 0.5)
            print("Barrier Example - Writing เสร็จ")
        }
        
        // อ่านข้อมูลหลังเขียนเสร็จ
        for i in 4...6 {
            queue.async {
                print("Barrier Example - Reading task \(i)")
                Thread.sleep(forTimeInterval: 0.3)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            completion("Barrier Example - ทุก task เสร็จแล้ว!")
        }
    }
}

// MARK: - 6. DispatchTimer
@MainActor
final class DispatchTimerExamples {
    
    func timerExample(completion: @escaping @MainActor (String) -> Void) {
        var count = 0
        let timer = DispatchSource.makeTimerSource(queue: .global())
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            count += 1
            print("Timer Example - Tick \(count)")
            if count >= 5 {
                timer.cancel()
                DispatchQueue.main.async {
                    completion("Timer Example - Timer เสร็จ!")
                }
            }
        }
        timer.resume()
    }
}
