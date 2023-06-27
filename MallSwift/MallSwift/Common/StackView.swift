//
//  StackView.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class StackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
//        spacing = inset
        spacing = Configs.BaseDimensions.inset
        axis = .vertical
        // self.distribution = .fill

        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
}
