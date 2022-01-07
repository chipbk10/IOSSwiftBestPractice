//
//  Topic_UnitTest.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

import UIKit

final class Topic_UnitTest: TopicProtocol {
    
    static func run() {
        let topic = Topic_UnitTest()
        topic.question1()
    }
        
    // Question: how to test if our app can open a specific URL?
    // Answer: to open a URL, we have to use `UIApplication.shared`. We have to find away to stub 2 methods `.canOpen()` & `.open(...)`
    //         make a protocol that contains these method
    //         extend UIApplication to conform to that protocol
    //         now, we can mock / stub easily
    private func question1() {
        let urlOpener: URLOpening = UIApplication.shared
        let url: URL! = URL(string: "DummyURL")
        let app = OurApp_ToTestURLOpener(urlOpener: urlOpener, url: url)
        app.tapOnOpenButton()
    }
}
