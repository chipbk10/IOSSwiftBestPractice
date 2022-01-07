//
//  Semaphore.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

// simulate how a semaphore works
struct MySemaphore {
    
    // the number of available resources
    // negative: no resource
    // positive: available resources
    var value: Int
    
    // never call .wait() on main thread as it will freeze your app
    // .wait() allows us to specify a timeout. Once timeout is reached, the wait will finish regardless of semaphore's value
    mutating func wait() {
                
        value -= 1
        
        // as long as the value is negative, the current thread will be entirely blocked
        // the current thread will be unblocked until there is an available resource (value >= 0)
        while value < 0 {
            // no operation
        }
    }
    
    // .signal is called on other threads to release a resouce
    mutating func signal() {
        value += 1
    }
}
