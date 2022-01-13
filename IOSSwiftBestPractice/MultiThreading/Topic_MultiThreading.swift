//
//  Topic_MultiThreading.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

final class Topic_MultiThreading: TopicProtocol {
    
    static func run() {
        let multiThreading = Topic_MultiThreading()
        multiThreading.question_5()
    }
                
    // Question: how to make an asynchronous block become synchronous? Or how to flaten a completion block?
    // Answer 1: use Semaphore
    // Answer 2: use DispatchGroup
    private func question_1() {
        
        let job = Job(name: "dummy job", delay: 2, queue: concurrentQueue)
        
        // use Semaphore
        let semaphore = DispatchSemaphore(value: 0)
        job.perform {
            semaphore.signal()
        }
        print("Current Thread is running ...")
        semaphore.wait()
        print("Current Thread continues ...")
        
        // use DispatchGroup
        let group = DispatchGroup()
        group.enter()
        job.perform {
            group.leave()
        }
        print("Current Thread is running ...")
        // use group.notify if you don't want to block the current thread
        // another advantage is group.notify can be called on the main thread
        group.wait()
        print("Current Thread continues ...")
    }
    
    // Question: how to perform a bunch of asynchronous blocks serially? block1 -> block2 -> .... -> block N
    // Answer 1: recursive approach
    // Answer 2: use Semaphore (like question1)
    private func question_2() {
        let jobs = [1,2,3,4].map { Job(name: "dummy job \($0)", delay: UInt32($0), queue: concurrentQueue) }
        // recursive approach
        let recursiveSerialJobs = RecursiveSerialJobs()
        recursiveSerialJobs.perform(array: jobs) {
            print("All jobs are done")
        }
        // serial queue + semaphore approach
        let asyncSeriaQueue = AsyncSerialQueue()
        asyncSeriaQueue.enqueue(jobs: jobs) {
            print("All jobs are done")
        }
        print("Current Thread is running ...")
    }
    
    // Question: how to limit the number of concurrent blocks?
    // Answer 1: use Semaphore
    // Answer 2: use OperationQueue.maxConcurrentOperationCount
    private func question_3() {
        let jobs = [1,2,3,4,5,6].map { Job(name: "dummy job \($0)", delay: UInt32($0)) }
        let maxConcurrentJobs = 2
        
        // use Semaphore
        let limitedConcurrentJobs = LimitedConcurrentJobs(limit: maxConcurrentJobs)
        limitedConcurrentJobs.enqueue(jobs: jobs)
        
        // use OperationQueue
        // todo ...
    }
    
    // Question: how to wait for many concurrent blocks to finish?
    // Answer: use DispatchGroup
    private func question_4() {
        let jobs = [1,2,3,4].map { Job(name: "dummy job \($0)", delay: UInt32($0), queue: concurrentQueue) }
        let group = DispatchGroup()
        jobs.forEach {
            group.enter()
            $0.perform {
                group.leave()
            }
        }
        
        // the current thread will be blocked untill all jobs are done
        // group.wait()
        
        // the current thread will not be blocked.
        group.notify(queue: mainQueue) {
            print("All jobs are done")
        }
        print("Current Thread is running ...")
    }
    
    // Question: how to solve readers-writers problem?
    // In particular, we want to prevent more than one thread modifying the shared resource simultaneously
    // but allow for two or more readers to access the shared resource at the same time
    // Answer: use .barrier
    private func question_5() {
        
        let map = IdentityMap<ObjectIdentifier>()
                        
        // readers
        for i in 1...6 {
            let delay = Int.random(in: 0...6)
            concurrentQueue.asyncAfter(deadline: .now() + TimeInterval(delay)) {
                print("reader \(i):")
                _ = map.object(forID: 1)
            }
        }
        
        // writers
        concurrentQueue.asyncAfter(deadline:.now() + 1.0) {
            map.add(object: ObjectIdentifier(id: 1))
        }
    }
        
    
    // Question: explain why synchronous dispatch the task to the same serial queue will lead to the app crash?
    // Answer: because the task will be added at the end of the serial queue.
    //         Mean while the current thread will be blocked forever, as the task is never executed.
    private func question_6() {        
        serialQueue.async {
            
            // a new thread will be created to do the following task
            // this thread will be blocked until the following task is done
            serialQueue.sync {
                
                // this task is added at the end of the serial queue
                // consequently, the task is never executed.
                print("App crashes")
            }
        }
    }
    
    // Question: how to avoid race conditions?
    // Answer 1: use NSLock. However, it can lead to a `deadlock`, when 2 threads might wait for each other to release their locks
    // Answer 2: use Semaphore(1)
    // Answer 3: use SerialQueue
    // Answer 4: use .barrier flags with ConcurrentQueue
    // Answer 5: use Actor
    private func question_7() {
    }
    
    private func question_8() {
        // how to use mutex: https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html        
    }
}
