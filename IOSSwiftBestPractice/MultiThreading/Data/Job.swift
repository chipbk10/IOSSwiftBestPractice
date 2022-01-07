//
//  Job.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

// simulate a dummy work
struct Job {
    var name: String = "dummy job"
    var delay: UInt32 = 1
    var queue: DispatchQueue? = nil
    
    func perform(completion: @escaping () -> Void = {} ) {
        guard let queue = queue else {
            // will execute task on the same thread of the caller
            performActualWork(completion: completion)
            return
        }
        queue.async {
            performActualWork(completion: completion)
        }
    }
    
    func performActualWork(completion: @escaping () -> Void) {
        print("Start \(name)")
        sleep(UInt32(delay))
        print("Finish \(name)")
        completion()
    }
}
