//
//  extensionColorTest.swift
//  ZemogaTests
//
//  Created by Miguel Angel Saravia Belmonte on 5/10/22.
//

import XCTest
@testable import Zemoga

class extensionColorTest: XCTestCase {

    func test_applying_colors() {
        let button = UIButton()
        
        button.tintColor = UIColor.hexColor(hex: "#F8E71C")
        button.backgroundColor = UIColor.hexColor(hex: "#DBDADA")
        
        XCTAssertEqual(button.tintColor, UIColor.MediumYellowColor)
        XCTAssertEqual(button.backgroundColor, UIColor.LightGrayColor)
    }
}
