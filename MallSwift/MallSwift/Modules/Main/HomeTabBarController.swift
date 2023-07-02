//
//  HomeTabBarController.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import Foundation

enum HomeTabBarItem: Int {
    case homePage, category, cart, user
    
// 

//    var image: UIImage? {
//        switch self {
//        case .accountDetails: return R.image.icon_tabbar_account_details()
//        case .charts: return R.image.icon_tabbar_charts()
//        case .account: return R.image.icon_tabbar_account()
//        case .settings: return R.image.icon_tabbar_settings()
//        }
//    }
//
//    var title: String {
//        switch self {
//        case .homePage: return R.string.localizable.homeTabBarAccountDetailsTitle.key.localized()
//        case .category: return R.string.localizable.homeTabBarChartsTitle.key.localized()
//        case .cart: return R.string.localizable.homeTabBarAccountTitle.key.localized()
//        case .user: return R.string.localizable.homeTabBarSettingsTitle.key.localized()
//        }
//    }
//
//    var animation: RAMItemAnimation {
//        var animation: RAMItemAnimation
//        switch self {
//        case .homePage: animation = RAMFlipLeftTransitionItemAnimations()
//        case .category: animation = RAMBounceAnimation()
//        case .cart: animation = RAMBounceAnimation()
//        case .user: animation = RAMRightRotationAnimation()
//        }
//        animation.theme.iconSelectedColor = themeService.attribute { $0.secondary }
//        animation.theme.textSelectedColor = themeService.attribute { $0.secondary }
//        return animation
//    }

//    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
//        let vc = controller(with: viewModel, navigator: navigator)
//        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
//        item.animation = animation
//        item.theme.iconColor = themeService.attribute { $0.text }
//        item.theme.textColor = themeService.attribute { $0.text }
//        vc.tabBarItem = item
//        return vc
//    }
}

//enum HomeTabBarItem: Int {
//    case homePage, category, cart, user
//
//    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
//        switch self {
//        case .homePage:
//            let vc = HomePageViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        case .category:
//            let vc = CategoryViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        case .cart:
//            let vc = CartViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        case .user:
//            let vc = UserViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        }
//    }
//
//    var image: UIImage? {
//        switch self {
//        case .accountDetails: return R.image.icon_tabbar_account_details()
//        case .charts: return R.image.icon_tabbar_charts()
//        case .account: return R.image.icon_tabbar_account()
//        case .settings: return R.image.icon_tabbar_settings()
//        }
//    }
//
//    var title: String {
//        switch self {
//        case .homePage: return R.string.localizable.homeTabBarAccountDetailsTitle.key.localized()
//        case .category: return R.string.localizable.homeTabBarChartsTitle.key.localized()
//        case .cart: return R.string.localizable.homeTabBarAccountTitle.key.localized()
//        case .user: return R.string.localizable.homeTabBarSettingsTitle.key.localized()
//        }
//    }
//
//    var animation: RAMItemAnimation {
//        var animation: RAMItemAnimation
//        switch self {
//        case .homePage: animation = RAMFlipLeftTransitionItemAnimations()
//        case .category: animation = RAMBounceAnimation()
//        case .cart: animation = RAMBounceAnimation()
//        case .user: animation = RAMRightRotationAnimation()
//        }
//        animation.theme.iconSelectedColor = themeService.attribute { $0.secondary }
//        animation.theme.textSelectedColor = themeService.attribute { $0.secondary }
//        return animation
//    }
//
//    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
//        let vc = controller(with: viewModel, navigator: navigator)
//        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
//        item.animation = animation
//        item.theme.iconColor = themeService.attribute { $0.text }
//        item.theme.textColor = themeService.attribute { $0.text }
//        vc.tabBarItem = item
//        return vc
//    }
//}

//class HomeTabBarController: RAMAnimatedTabBarController, Navigatable {
//
//    var viewModel: HomeTabBarViewModel?
//    var navigator: Navigator!
//
//    init(viewModel: ViewModel?, navigator: Navigator) {
//        self.viewModel = viewModel as? HomeTabBarViewModel
//        self.navigator = navigator
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        makeUI()
//        bindViewModel()
//    }
//
//    func makeUI() {
//        NotificationCenter.default
//            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
//            .subscribe { [weak self] (event) in
//                self?.animatedItems.forEach({ (item) in
//                    item.title = HomeTabBarItem(rawValue: item.tag)?.title
//                })
//                self?.setViewControllers(self?.viewControllers, animated: false)
//                self?.setSelectIndex(from: 0, to: self?.selectedIndex ?? 0)
//            }.disposed(by: rx.disposeBag)
//
//        tabBar.theme.barTintColor = themeService.attribute { $0.primaryDark }
//
//        themeService.typeStream.delay(DispatchTimeInterval.milliseconds(200), scheduler: MainScheduler.instance)
//            .subscribe(onNext: { (theme) in
//                switch theme {
//                case .light(let color), .dark(let color):
//                    self.changeSelectedColor(color.color, iconSelectedColor: color.color)
//                }
//            }).disposed(by: rx.disposeBag)
//    }
//
//    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        let input = HomeTabBarViewModel.Input(whatsNewTrigger: rx.viewDidAppear.mapToVoid())
//        let output = viewModel.transform(input: input)
//
//        output.tabBarItems.delay(.milliseconds(50)).drive(onNext: { [weak self] (tabBarItems) in
//            if let strongSelf = self {
//                let controllers = tabBarItems.map { $0.getController(with: viewModel.viewModel(for: $0), navigator: strongSelf.navigator) }
//                strongSelf.setViewControllers(controllers, animated: false)
//            }
//        }).disposed(by: rx.disposeBag)
//
//        output.openWhatsNew.drive(onNext: { [weak self] (block) in
//            if Configs.Network.useStaging == false {
//                self?.navigator.show(segue: .whatsNew(block: block), sender: self, transition: .modal)
//            }
//        }).disposed(by: rx.disposeBag)
//    }
//}
