//
//  AsyncSerialQueue.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

// simulate how to perform a bunch of asynchronous blocks serially using SerialQueue + Semaphore
final class AsyncSerialQueue {
    
    private let asyncSerialQueue = DispatchQueue(label: "AsyncSerialQueue")
    
    func enqueue(job: Job, completion: @escaping () -> Void) {
        asyncSerialQueue.async {
            let semaphore = DispatchSemaphore(value: 0)
            
            // job might be executed on another thread
            job.perform {
                semaphore.signal()
            }
            
            semaphore.wait()
            completion()
        }
    }
    
    func enqueue(jobs: [Job], completion: @escaping () -> Void) {
        for (index, job) in jobs.enumerated() {
            enqueue(job: job) {
                if index+1 == jobs.endIndex { completion() }
            }
        }
    }
}
