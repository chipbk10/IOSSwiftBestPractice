//
//  Queues.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

// while DispatchQueue.global() is a quick way to get access to a concurrent queue, it can easily lead to an explosion of threads.
// if you create a lot of background tasks all on the .global() queue,
// it will create a ton of threads which can counter-intuitively slow your app down, so it is not recommended.
let globalQueue = DispatchQueue.global()

// if the attributes are not set, it will default the queue to serial
// a serial queue will not execute its work on more than one thread at a time,
// regardless of how many tasks you dispatch on that queue.
// the order of executions is guaranteed
let serialQueue = DispatchQueue(label: "SerialQueue")

// a concurrent queue can spawn multiple threads at a time to execute its tasks
// tasks always start in FIFO order, but the queue doesn't wait for tasks to finish before starting the next tasks
// therefore tasks on concurrent queue can finish in any order
let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)


// the main queue is a serial queue.
let mainQueue = DispatchQueue.main

// .sync will block the current thread where the task is dispatched to the queue until the task finishes its work
// note: as a performance optimization, GCD executes the task on the current thread

// .async will not block the current thread where the task is dispatched to the queue
