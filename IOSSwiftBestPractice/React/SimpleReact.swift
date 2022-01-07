//
//  SimpleReact.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

import Foundation

// simulate a simple react using getter & setter method like `Observer/Listener` pattern
// whenever the value of an object is changed, the listener will be notified

class Box<T>{
    
    typealias Listener = (T) -> Void
    
    // An array of listeners is also possible
    private var listener: Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?){
        self.listener = listener
        listener?(value)
    }
    
    func unbind() {
        self.listener = nil
    }
}
