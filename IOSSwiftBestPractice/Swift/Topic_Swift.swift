//
//  Topic_Swift.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 06/01/2022.
//

import Foundation

final class Topic_Swift: TopicProtocol {
    
    static func run() {
        let topic = Topic_Swift()
        topic.question1()
    }
    
    // Question: pros/cons closure vs protocol/delegate
    // Answer: https://bit.ly/3Gxwjj4
    private func question1() {
        // todo
    }
    
    // Question: what are all access control? What are the default access object?
    // Answer: open/public, internal, private, fileprivate
    private func question2() {
        
        // public: can be accessed from inside & outside of the module, but cannot subclass & override
        // open: can be accessed from inside & outside of the module, and can subclass & override
        // internal (by default): can be access within the module
        // private: can be accessed within class & extension
        // fileprivate: can be accessed within a file
    }
    
    // Question: difference between convenience init & designated init
    // Answer: convenience init will call designated init with the same level class.
    // Answer: designated init will call super init of the parent class
    private func question3() {
        
    }
    
    // Question: explain `assert()`
    // Answer: `assert()` is useful to in debug mode. Calling `assert()` is ignored in release builds (in production)
    private func question4() {
        
    }
}
