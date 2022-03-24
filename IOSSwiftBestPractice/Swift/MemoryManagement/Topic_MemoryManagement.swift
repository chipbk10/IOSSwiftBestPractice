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
    
}
