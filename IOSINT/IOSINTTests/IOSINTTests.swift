//
//  IOSINTTests.swift
//  IOSINTTests
//
//  Created by Эля Корельская on 03.06.2023.
//

import XCTest
@testable import IOSINT

final class IOSINTTests: XCTestCase {

    let checkerService = CheckerService()
    let feedModel = FeedModel()
    
    func testSuccessCheckerService() {
        let login = "kov@mail.ru"
        let password = "1234567"
        var result = false
        let expect = self.expectation(description: "Waiting Firebase")
        checkerService.checkCredentials(login: login, password: password) { doneWorking in
            if doneWorking {
               result = true
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertEqual(result, true)
    }
    // этот тест не получается
    func testFailedCheckerService() {
        let login = "kroeur@.ru"
        let password = "12345678"
        var result = false
        let expect = self.expectation(description: "Waiting firebase")
        checkerService.checkCredentials(login: login, password: password) { workingDone in
            if workingDone {
               result = true
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertEqual(result, false)
    }
    
    func testSuccesFeedModel() {
        XCTAssertTrue(feedModel.check(secretWord: feedModel.secret))
    }
    
}
