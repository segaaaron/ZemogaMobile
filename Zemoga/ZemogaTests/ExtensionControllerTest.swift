//
//  ExtensionControllerTest.swift
//  ZemogaTests
//
//  Created by Miguel Angel Saravia Belmonte on 5/10/22.
//

import XCTest
@testable import Zemoga

class ExtensionControllerTest: XCTestCase {
    func test_alert_controller() {
        let vc = UIViewController()
        
        vc.showAlertView(message: "shows alert")

        XCTAssert(vc.isViewLoaded)
    }
    
    func test_alert_with_title() {
        let vc = UIViewController()
        
        vc.showAlertView(title: "test", message: "show alert")

        XCTAssert(vc.isViewLoaded)
    }
}
