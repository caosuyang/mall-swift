//
//  ViewModelType.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
}

class ViewModel: NSObject {
    
    var page = 1
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    override init() {
        super.init()
    }
    
    deinit {
        
    }
}
