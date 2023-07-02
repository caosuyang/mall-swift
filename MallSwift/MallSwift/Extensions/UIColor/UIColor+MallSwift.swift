//
//  UIColor+MallSwift.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import Foundation
import UIKit

// MARK: Colors

extension UIColor {

//    static func primary() -> UIColor {
//        return themeService.type.associatedObject.primary
//    }
//
//    static func primaryDark() -> UIColor {
//        return themeService.type.associatedObject.primaryDark
//    }
//
//    static func secondary() -> UIColor {
//        return themeService.type.associatedObject.secondary
//    }
//
//    static func secondaryDark() -> UIColor {
//        return themeService.type.associatedObject.secondaryDark
//    }
//
//    static func separator() -> UIColor {
//        return themeService.type.associatedObject.separator
//    }
//
//    static func text() -> UIColor {
//        return themeService.type.associatedObject.text
//    }
}

extension UIColor {

    var brightnessAdjustedColor: UIColor {
        var components = self.cgColor.components
        let alpha = components?.last
        components?.removeLast()
        let color = CGFloat(1-(components?.max())! >= 0.5 ? 1.0 : 0.0)
        return UIColor(red: color, green: color, blue: color, alpha: alpha!)
    }
}
