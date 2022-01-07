//
//  Topic_Architecture.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

final class Topic_Architecture: TopicProtocol {
    
    static func run() {
        let topic = Topic_Architecture()
        topic.question1()
    }
    
    // Question: All questions related to MVVM-C
    // Answer: use Topic_MVVMC
    private func question1() {
        Topic_MVVMC.run()
    }        
}
