//
//  CollectionViewController.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class CollectionViewController: ViewController {
    
    lazy var collectionView: CollectionView = {
        let view = CollectionView()
        view.emptyDataSetSource = self
        view.emptyDataSetDelegate = self
        return view
    }()
    
    var clearsSelectionOnViewWillAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if clearsSelectionOnViewWillAppear == true {
            deselectSelectedItems()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func makeUI() {
        super.makeUI()
        
        stackView.spacing = 0
        stackView.insertArrangedSubview(collectionView, at: 0)
    }
    
    override func updateUI() {
        super.updateUI()
    }
}

extension CollectionViewController {

    func deselectSelectedItems() {
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems {
            selectedIndexPaths.forEach({ (indexPath) in
                collectionView.deselectItem(at: indexPath, animated: false)
            })
        }
    }
}
