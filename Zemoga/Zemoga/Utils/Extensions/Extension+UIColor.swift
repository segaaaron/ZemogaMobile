//
//  Extension+UIColor.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation
import UIKit

extension UIColor {
    
    static var greenColor: UIColor {
        return .getGreenColor()
    }
    
    static var whiteColor: UIColor {
        return .getWhiteColor()
    }
    
    static var LightGrayColor: UIColor {
        return .getLightGrayColor()
    }
    
    static var MediumYellowColor: UIColor {
        return .getMediumYellowColor()
    }

    //MARK: Custom with Hex Color
    static func hexColor(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexint = Int(self.intFromHexString(hexStr: hex))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
    
    //MARK: Principal background
    private static func getGreenColor() -> UIColor {
        return .hexColor(hex: "#08B00F")
    }
    
    private static func getWhiteColor() -> UIColor {
        return .hexColor(hex: "#FFFFFF")
    }
    
    private static func getLightGrayColor() -> UIColor {
        return .hexColor(hex: "#DBDADA")
    }
    
    private static func getMediumYellowColor() -> UIColor {
        return .hexColor(hex: "#F8E71C")
    }
}
