//
//  WeakReference.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 15/04/2022.
//

class WeakReference<T:AnyObject> {
                
    private(set) weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
}
