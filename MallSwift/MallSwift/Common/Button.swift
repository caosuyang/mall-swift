//
//  Button.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    func makeUI() {
//        theme.backgroundImage(from: themeService.attribute{ $0.secondary }, for: .normal)
//        theme.backgroundImage(from: themeService.attribute{ $0.secondary.withAlphaComponent(0.9) }, for: .selected)
//        theme.backgroundImage(from: themeService.attribute{ $0.secondary.withAlphaComponent(0.6) }, for: .disabled)
        
        layer.masksToBounds = true
        titleLabel?.lineBreakMode = .byWordWrapping
        layer.cornerRadius = Configs.BaseDimensions.cornerRadius
        
        snp.makeConstraints { make in
            make.height.equalTo(Configs.BaseDimensions.buttonHeight)
        }
        
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}

