//
//  Topic_Test.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

final class Topic_Test: TopicProtocol {
    
    static func run() {
        let topic = Topic_Test()
        topic.question1()
    }
    
    // Question: All questions related to Unit-Test
    // Answer: use Topic_UnitTest
    private func question1() {
        Topic_UnitTest.run()
    }
    
    // Question: All questions related to UI-Test
    // Answer: use Topic_UITest
    private func question2() {
        Topic_UITest.run()
    }
}
