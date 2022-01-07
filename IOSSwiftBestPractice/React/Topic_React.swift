//
//  Topic_React.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

final class Topic_React: TopicProtocol {
    
    static func run() {
        let topic = Topic_React()
        topic.question1()
    }
        
    // Question: design a simple react using getter & setter methods, like `Observer/Listener` pattern
    // Answer: make a generic class, whenever the value of an object is changed, the listener will be notified
    private func question1() {
        
        let object: Box<Int> = Box(0)
        
        // listen to the change of the object's value
        object.bind { newValue in
            print(newValue)
        }
        
        // whenever the value of the object is changed, the listener will be notified
        for i in 1...10 {
            object.value = i
        }
    }
}
