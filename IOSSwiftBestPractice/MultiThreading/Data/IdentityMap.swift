//
//  IdentityMap.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 05/01/2022.
//

import Foundation

// an identity map is a dictionary that maps items from their ID property to the model object
// https://martinfowler.com/eaaCatalog/identityMap.html
class IdentityMap<V: Identifiable> {
    
    private var dict: [V.ID:V] = [:]
    
    // we can use a serial queue to solve readers-writers problem (even without using .barrier)
    // but it will decrease the performance of readers
    // readers only read data, do not modify data, so can be executed concurrently
    // private let accessQueue = DispatchQueue(label: "IdentityMapAccessQueue"
    
    // using a concurrent queue can maximize the readers' performance
    private let accessQueue = DispatchQueue(label: "IdentityMapAccessQueue", attributes: .concurrent)
    
    func object(forID id: V.ID) -> V? {
        
        print("start read: object \(id)")
        var obj: V? = nil
        
        // readers expect to receive the value, so we have use `.sync` in this case
        accessQueue.sync {
            obj = dict[id]
        }
        
        if obj != nil {
            print("finish read: found object \(id)")
        } else {
            print("finish read: not found object \(id)")
        }
        
        return obj
    }
    
    func add(object: V) {
        // if we use .sync (instead of using .barrier), it will not work
        // .add(object:) can be called from multiple threads at a time
        // multiple threads still can modify the data simultaneously
        /*
        accessQueue.sync {
            self.dict[object.id] = object
        }
        */
        
        print("start write: barrier will be set to add object \(object.id)")
        
        // .barrier will wait until the queue is totally empty before executing the block.
        // once the task with flag .barrier finishes, the queue turns back to the concurrent queue
        // all other tasks that queue up behind will be executed as normal
        accessQueue.async(flags: .barrier) {                                    
            self.dict[object.id] = object            
            print("finish write: barrier is released after adding object \(object.id)")
        }
    }
}

struct ObjectIdentifier: Identifiable {
    let id: Int
    var name: String {
        "object \(id)"
    }
}
