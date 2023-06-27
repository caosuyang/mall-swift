//
//  SearchBar.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBar: UISearchBar {

    var barDisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
//        placeholder = R.string.localizable.commonSearch.key.localized()
        isTranslucent = false
        searchBarStyle = .minimal

//        theme.tintColor = themeService.attribute { $0.secondary }
//        theme.barTintColor = themeService.attribute { $0.primaryDark }

//        if let textField = textField {
//            textField.theme.textColor = themeService.attribute { $0.text }
//            textField.theme.keyboardAppearance = themeService.attribute { $0.keyboardAppearance }
//        }

        rx.textDidBeginEditing.asObservable().subscribe(onNext: { [weak self] () in
            self?.setShowsCancelButton(true, animated: true)
        }).disposed(by: barDisposeBag)

        rx.textDidEndEditing.asObservable().subscribe(onNext: { [weak self] () in
            self?.setShowsCancelButton(false, animated: true)
        }).disposed(by: barDisposeBag)

        rx.cancelButtonClicked.asObservable().subscribe(onNext: { [weak self] () in
            self?.resignFirstResponder()
        }).disposed(by: barDisposeBag)

        rx.searchButtonClicked.asObservable().subscribe(onNext: { [weak self] () in
            self?.resignFirstResponder()
        }).disposed(by: barDisposeBag)

        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
}
