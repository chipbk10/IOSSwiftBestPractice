//
//  Topic_DesignPatterns.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 16/01/2022.
//

final class Topic_DesignPatterns: TopicProtocol {
    
    static func run() {
        let topic = Topic_DesignPatterns()
        topic.question1()
    }
    
    // Question: Design a NotificationCenter
    // Answer: use Observer & Listener pattern + WeakReference (to avoid memory leak)
    private func question1() {
        let vc = NotifCenterVC()
        vc.viewWillAppear(true)
        vc.viewWillDisappear(true)
    }        
}
