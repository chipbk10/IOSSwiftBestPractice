//
//  URLOpener.swift
//  IOSSwiftBestPractice
//
//  Created by Hieu Luong on 07/01/2022.
//

import UIKit

protocol URLOpening {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpening {}

class OurApp_ToTestURLOpener {
    var hasOpened: Bool?
    private let urlOpener: URLOpening
    private let url: URL
    
    init(urlOpener: URLOpening = UIApplication.shared, url: URL) {
        self.urlOpener = urlOpener
        self.url = url
    }
    
    func tapOnOpenButton() {
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: { success in
                self.hasOpened = success
            })
        } else {
            self.hasOpened = false
        }
    }
}
