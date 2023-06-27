//
//  CollectionViewCell.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
}
