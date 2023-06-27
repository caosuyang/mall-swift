//
//  Switch.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class Switch: UISwitch {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
//        self.theme.tintColor = themeService.attribute { $0.secondary }
//        self.theme.onTintColor = themeService.attribute { $0.secondary }
    }
}
