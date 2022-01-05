//
//  Data.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation


// simulate a dummy work
struct Job {
    let name: String
    let delay: UInt32
    let queue: DispatchQueue
    
    func perform(completion: @escaping () -> Void) {
        queue.async {
            print("Start Job \(name)")
            sleep(UInt32(delay))
            print("Finish Job \(name)")
            completion()
        }
    }
}

let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
let serialQueue = DispatchQueue(label: "SerialQueue")
