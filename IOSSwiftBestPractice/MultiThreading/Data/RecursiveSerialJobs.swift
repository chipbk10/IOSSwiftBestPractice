//
//  RecursiveSerialJobs.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

// simulate how to perform a bunch of asynchronous blocks serially using recursion approach
final class RecursiveSerialJobs {
    
    func perform(array: [Job], completion: @escaping () -> Void) {
        
        func perform(arraySlice: ArraySlice<Job>, completion: @escaping () -> Void) {
            guard let job = arraySlice.first else {
                completion()
                return
            }
            job.perform {
                perform(arraySlice: arraySlice.dropFirst(), completion: completion)
            }
        }
        
        perform(arraySlice: array[...], completion: completion)
    }
}
