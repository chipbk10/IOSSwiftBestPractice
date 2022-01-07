//
//  URLOpenerTests.swift
//  IOSSwiftBestPracticeTests
//
//  Created by Hieu Luong on 07/01/2022.
//

import XCTest
@testable import IOSSwiftBestPractice

class URLOpenerTests: XCTestCase {

    func test_tapOnOpenButton_givenInvalidURL_hasOpenedShouldBeFalse() {
        // assign
        let mockUrlOpener = MockUrlOpener(validURL: false)
        let mockURL = URL(string: "InvalidURL")!
        let app = OurApp_ToTestURLOpener(urlOpener: mockUrlOpener, url: mockURL)
                
        // act
        app.tapOnOpenButton()
        
        // assert
        XCTAssertEqual(app.hasOpened, false)        
    }
    
    func test_tapOnOpenButton_givenValidUrl_andFailedToOpenURL_hasOpenedShouldBeFalse() {
        // assign
        let mockUrlOpener = MockUrlOpener(validURL: true, openSuccess: false)
        let mockURL = URL(string: "ValidURL")!
        let app = OurApp_ToTestURLOpener(urlOpener: mockUrlOpener, url: mockURL)
                
        // act
        app.tapOnOpenButton()
        
        // assert        
        XCTAssertEqual(app.hasOpened, false)
    }
    
    func test_tapOnOpenButton_givenValidUrl_andSucceededToOpenURL_hasOpenedShouldBeTrue() {
        // assign
        let mockUrlOpener = MockUrlOpener(validURL: true, openSuccess: true)
        let mockURL = URL(string: "ValidURL")!
        let app = OurApp_ToTestURLOpener(urlOpener: mockUrlOpener, url: mockURL)
                
        // act
        app.tapOnOpenButton()
        
        // assert
        XCTAssertEqual(app.hasOpened, true)
    }
    
}

private final class MockUrlOpener: URLOpening {
    
    private let validURL: Bool
    private let openSuccess: Bool
    
    init(validURL: Bool = true, openSuccess: Bool = true) {
        self.validURL = validURL
        self.openSuccess = openSuccess
    }
        
    func canOpenURL(_ url: URL) -> Bool {
        return validURL
    }
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?) {
        completion?(openSuccess)
    }
}
