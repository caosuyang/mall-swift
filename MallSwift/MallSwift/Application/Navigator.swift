//
//  Navigator.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    static var `default` = Navigator()
    
    // MARK: - segues list, all app scenes
    enum Scene {
        case tabs(viewModel: HomeTabBarViewModel)
        case homePage(viewModel: HomePageViewModel)
        case category(viewModel: CategoryViewModel)
        case cart(viewModel: CartViewModel)
        case user(viewModel: UserViewModel)
        case safari(URL)
    }
    
    enum Transition {
        case root(in: UIWindow)
//        case navigation(type: HeroDefaultAnimationType)
//        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
    
    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .tabs(let viewModel):
//            let rootVC = HomeTabBarController(viewModel: viewModel, navigator: self)
//            let detailVC = InitialSplitViewController(viewModel: nil, navigator: self)
//            let detailNavVC = NavigationController(rootViewController: detailVC)
//            let splitVC = SplitViewController()
//            splitVC.viewControllers = [rootVC, detailNavVC]
//            return splitVC
//            return rootVC
            return nil
//        case .accountDetails(viewModel: let viewModel): return AccountDetailsViewController(viewModel: viewModel, navigator: self)
//        case .charts(viewModel: let viewModel): return ChartsViewController(viewModel: viewModel, navigator: self)
//        case .account(viewModel: let viewModel): return AccountViewController(viewModel: viewModel, navigator: self)
//        case .settings(viewModel: let viewModel): return SettingsViewController(viewModel: viewModel, navigator: self)
            
        case .safari(let url):
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil
        case .homePage(viewModel: let viewModel):
            return nil
        case .category(viewModel: let viewModel):
            return nil
        case .cart(viewModel: let viewModel):
            return nil
        case .user(viewModel: let viewModel):
            return nil
        }
    }
    
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
//            sender?.navigationController?.popViewController()
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - invoke a single segue
//    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
//        if let target = get(segue: segue) {
//            show(target: target, sender: sender, transition: transition)
//        }
//    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        case .custom: return
        default: break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        if let nav = sender as? UINavigationController {
            // push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        switch transition {
//        case .navigation(let type):
//            if let nav = sender.navigationController {
//                // push controller to navigation stack
//                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
//                nav.pushViewController(target, animated: true)
//            }
//        case .customModal(let type):
//            // present modally with custom animation
//            DispatchQueue.main.async {
//                let nav = NavigationController(rootViewController: target)
//                nav.hero.modalAnimationType = .autoReverse(presenting: type)
//                sender.present(nav, animated: true, completion: nil)
//            }
        case .modal:
            // present modally
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }
}
