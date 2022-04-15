//
//  Topic_MemoryManagement.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 18/01/2022.
//

final class Topic_MemoryManagement: TopicProtocol {
    
    static func run() {
        let topic = Topic_MemoryManagement()
        topic.question1()
    }
    
    // Question: delegate should be weak or strong reference?
    // Answer: if the delegate makes a retain cycle, then it should be a weak reference
    private func question1() {
        // todo
        //
    }
    
    
    // Question: How would you steer away from retain cycles when using closures?
    // Answer: The closures capture and store the reference of an object, that can make a retain cycle, ... todo
    private func question2() {
        
    }
    
    // Question: class A has a strong reference on an array of objects, and each object is owned (also a strong reference) by other classes. How can you steer away from retain cycles?
    // Answer: use WeakReference class to wrap up the value of each object. Class A will have a strong reference on an array of WeakReference objects
    private func question3() {
        class WeakReference<T: AnyObject> {
            weak var value: T?
        }
    }
    
    // Question: `weak` reference vs `unowned` reference
    // Answer: Like a weak reference, an unowned reference does not increment or decrement the reference count of an object.
    // Answer: However, unlike a weak reference, the program guarantees to the Swift compiler that an unowned reference will not be nil when it is accessed.
    private func question4() {
        // todo
        // example
    }
    
}
