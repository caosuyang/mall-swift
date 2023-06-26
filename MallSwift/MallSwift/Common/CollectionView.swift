//
//  CollectionView.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

//class CollectionView: UICollectionView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//    init() {
//        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
//        makeUI()
//    }
//    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//        makeUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        makeUI()
//    }
//
//    func makeUI() {
//        self.layer.masksToBounds = true
//        self.backgroundColor = .clear
//        updateUI()
//    }
//    
//    func updateUI() {
//        setNeedsDisplay()
//    }
//    
//    func itemWidth(forItemsPerRow itemsPerRow: Int, withInset inset: CGFloat = 0) -> CGFloat {
//        let collectionWidth = Int(frame.size.width)
//        if collectionWidth == 0 {
//            return 0
//        }
//        return CGFloat(Int((collectionWidth - (itemsPerRow + 1) * Int(inset)) / itemsPerRow))
//    }
//    
//    func setItemSize(_ size: CGSize) {
//        if size.width == 0 || size.height == 0 {
//            return
//        }
//        let layout = (self.collectionViewLayout as? UICollectionViewFlowLayout)!
//        layout.itemSize = size
//    }
//}
