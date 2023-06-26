//
//  Application.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

class Application: NSObject {

    static let shared = Application()
    
    var window: UIWindow?
    
//    let navigator: Navigator
    
    private override init() {
//        navigator = Navigator.default
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        
        guard let window = window else { return }
        self.window = window
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//            let authorized = true
//            let viewModel = HomeTabBarViewModel(authorized: authorized)
//            self?.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window))
//        }
    }
}
