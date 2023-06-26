//
//  ImageView.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class ImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        makeUI()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    func makeUI() {
        tintColor = .primary()
        layer.masksToBounds = true
        contentMode = .center

        hero.modifiers = [.arc]

        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
