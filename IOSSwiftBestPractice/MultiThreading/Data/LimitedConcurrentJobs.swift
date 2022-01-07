//
//  LimitedConcurrentJobs.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

// simulate how to limit the number of concurrent blocks
final class LimitedConcurrentJobs {
    
    private let serialQueue = DispatchQueue(label: "LimitedConcurrentJobsSerialQueue")
    private let concurrentQueue = DispatchQueue(label: "LimitedConcurrentJobsConcurrentQueue", attributes: .concurrent)
    private let semaphore: DispatchSemaphore
    
    init(limit: Int) {
        semaphore = DispatchSemaphore(value: limit)
    }
    
    private func enqueue(job: Job) {
        serialQueue.async {
                        
            // create a thread to execute the block that contains the execution of the job. This thread will be blocked as long as the value of semaphore is negative
            // note that still no thread is created to execute this job until this moment
            self.semaphore.wait()
                
            self.concurrentQueue.async {
                
                // create a new thread to perform the job
                job.perform {
                    
                    // increase the value of semaphore by 1
                    self.semaphore.signal()
                }
            }
        }
    }
    
    func enqueue(jobs: [Job]) {
        jobs.forEach { enqueue(job: $0) }
    }
}
