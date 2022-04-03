//
//  Topic_Network.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 16/01/2022.
//

final class Topic_Network: TopicProtocol {
    
    static func run() {
        let topic = Topic_Network()
        topic.question1()
    }
    
    // Question: describe some specific HTTP response codes?
    // Answer: 401 (Unauthorized), 422 (Unprocessable Entity), 429 (Too many requests), 500 (Internal Server Error)
    private func question1() {
        // 401 Unauthorized - the client authorization token is missing or expired: the login request must be sent before continuing.
        // 422 Unprocessable Entity - the client request data is malformed and should not be retried.
        // 429 Too Many Requests - the client reached the rate-limiting threshold.
        // 500 Internal Server Error - the client should use exponential back-off to retry a failed request.
    }
    
    // Question: you use a short polling mechanism to get the latest content from the server for a short time (like few minutes). During that time, if the app is backgrounded, the OS will close all Http requests from your app. When the app returns to the foreground, what will happen? The polling will continue or not? Any issue?
    private func question2() {
        // background mode task: https://www.raywenderlich.com/5817-background-modes-tutorial-getting-started
        
    }
}
