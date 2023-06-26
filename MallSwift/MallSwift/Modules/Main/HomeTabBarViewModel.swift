//
//  HomeTabBarViewModel.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import Foundation
import RxCocoa
import RxSwift

class HomeTabBarViewModel: ViewModel, ViewModelType {

    struct Input {
        
    }
    
    struct Output {
        let tabBarItems: Driver<[HomeTabBarItem]>
    }
    
    let authorized: Bool
    
    init(authorized: Bool) {
        self.authorized = authorized
        super.init()
    }
    
    func transform(input: Input) -> Output {

        let tabBarItems = Observable.just(authorized).map { (authorized) -> [HomeTabBarItem] in
            if authorized {
                return [.homePage, .category, .cart, .user]
            } else {
                return [.homePage, .category, .user]
            }
        }.asDriver(onErrorJustReturn: [])
        
        return Output(tabBarItems: tabBarItems)
    }
    
    func viewModel(for tabBarItem: HomeTabBarItem) -> ViewModel {
        switch tabBarItem {
        case .homePage:
            let viewModel = HomePageViewModel()
            return viewModel
        case .category:
            let viewModel = CategoryViewModel()
            return viewModel
        case .cart:
            let viewModel = CartViewModel()
            return viewModel
        case .user:
            let viewModel = UserViewModel()
            return viewModel
        }
    }
}
