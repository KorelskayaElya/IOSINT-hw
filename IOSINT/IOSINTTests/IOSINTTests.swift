//
//  IOSINTTests.swift
//  IOSINTTests
//
//  Created by Эля Корельская on 03.06.2023.
//

import XCTest
@testable import IOSINT
import FirebaseAuth

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
    
    func testCheckCredentials() {
        let expectation = self.expectation(description: "Check credentials")
        let login = "ku@mail.ru"
        let password = "12345678"

        checkerService.checkCredentials(login: login, password: password) { workingDone in
            XCTAssert(workingDone, "Credentials check failed")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSuccesFeedModel() {
        XCTAssertTrue(feedModel.check(secretWord: feedModel.secret))
    }
    
}
