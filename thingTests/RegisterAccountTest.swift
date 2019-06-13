//
//  RegisterAccountTest.swift
//  thingTests
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import XCTest
@testable import thing

class RegisterAccountTest: XCTestCase {
    var registerAccountViewController: thing.RegisterAccountViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        registerAccountViewController = (storyboard.instantiateViewController(withIdentifier: "RegisterAccountViewController") as! thing.RegisterAccountViewController)
    }

    func testValidEmail() {
        let value = registerAccountViewController.isValidEmail(enteredEmail: "wotjdzz1@naver.com")
        return XCTAssert(value)
    }

    func testValidEmail2() {
        let value = registerAccountViewController.isValidEmail(enteredEmail: "wotjdzz1@navercom")
        return XCTAssertFalse(value)
    }

    func testValidEmail3() {
        let value = registerAccountViewController.isValidEmail(enteredEmail: "wotjdzz1naver.com")
        return XCTAssertFalse(value)
    }

    func testValidEmail4() {
        let value = registerAccountViewController.isValidEmail(enteredEmail: "a.b@")
        return XCTAssertFalse(value)
    }

    func testValidEmail5() {
        let value = registerAccountViewController.isValidEmail(enteredEmail: "lee.js@naver.co.kr")
        return XCTAssert(value)
    }

    func testIsEqual() {
        let value = registerAccountViewController.isEqaul(password: "abc", confirm: "abc")
        return XCTAssert(value)
    }

    func testIsEqual2() {
        let value = registerAccountViewController.isEqaul(password: "abc", confirm: "abcd")
        return XCTAssertFalse(value)
    }

    func testIsEqual3() {
        let value = registerAccountViewController.isEqaul(password: "", confirm: "abcd")
        return XCTAssertFalse(value)
    }
}
