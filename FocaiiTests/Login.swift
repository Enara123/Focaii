//
//  Login.swift
//  FocaiiTests
//
//  Created by Siluni on 2025-04-25.
//

import XCTest
@testable import Focaii

final class LoginViewTests: XCTestCase {

    var authModel: MockAuthModel!
    
    override func setUp() {
        super.setUp()
        authModel = MockAuthModel()
    }

    override func tearDown() {
        authModel = nil
        super.tearDown()
    }

    func testEmptyCredentials() {
        let loginView = LoginView(authModel: authModel)
        
        loginView.username = ""
        loginView.password = ""
        
        loginView.checkUserCredentials()
        
        DispatchQueue.main.async {
            if let errorMessage = loginView.errorMessage {
                XCTAssertEqual(errorMessage, "Please enter both username and password.")
            } else {
                XCTFail("Error message should not be nil.")
            }
        }
    }

    func testSuccessfulLogin() {
            let loginView = LoginView(authModel: authModel, username: "Siluni", password: "tancy123")

            authModel.shouldSucceed = true

            let expectation = self.expectation(description: "Successful login")

            authModel.loginCompletion = {
                XCTAssertTrue(self.authModel.loginCalled)
                XCTAssertEqual(self.authModel.lastUsername, "Siluni")
                XCTAssertEqual(self.authModel.lastPassword, "tancy123")
                XCTAssertNil(loginView.errorMessage)
                expectation.fulfill()
            }

            loginView.checkUserCredentials()

            waitForExpectations(timeout: 1)
        }

    func testFailedLogin() {
        let loginView = LoginView(authModel: authModel, username: "Siluni", password: "wrongpassword")
        
        authModel.shouldSucceed = false
        
        let expectation = self.expectation(description: "Failed login")

        authModel.loginCompletion = {
            XCTAssertTrue(self.authModel.loginCalled)
            XCTAssertEqual(self.authModel.lastUsername, "Siluni")
            XCTAssertEqual(self.authModel.lastPassword, "wrongpassword")
            XCTAssertNil(loginView.errorMessage)
            
            DispatchQueue.main.async {
                if let errorMessage = loginView.errorMessage {
                    XCTAssertEqual(errorMessage, "Please enter both username and password.")
                } else {
                    XCTFail("Error message should not be nil.")
                }
            }
            
            expectation.fulfill()
        }
        
        loginView.checkUserCredentials()
        
        waitForExpectations(timeout: 1)
    }
}


class MockAuthModel: AuthModel {
    var loginCalled = false
    var lastUsername = ""
    var lastPassword = ""
    var shouldSucceed = true
    var loginCompletion: (() -> Void)? = nil

    override func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        loginCalled = true
        lastUsername = username
        lastPassword = password

        DispatchQueue.main.async {
            if self.shouldSucceed {
                completion(nil)
            } else {
                let error = NSError(domain: "login", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
                completion(error)
            }
            self.loginCompletion?()
        }
    }
}
