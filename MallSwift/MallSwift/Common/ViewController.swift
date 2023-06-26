//
//  ViewController.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/16.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ViewModel?
    var navigator: Navigator!
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    let isLoading = BehaviorRelay(value: false)
    
    var automaticallyAdjustsLeftBarButtonItem = true
    var canOpenFlex = true
    
    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    let spaceBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
    let emptyDataSetButtonTap = PublishSubject<Void>()
    var emptyDataSetTitle = R.string.localizable.commonNoResults.key.localized()
    var emptyDataSetDescription = ""
    var emptyDataSetImage = R.image.image_no_result()
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    let languageChanged = BehaviorRelay<Void>(value: ())
    
    let orientationEvent = PublishSubject<Void>()
    let motionShakeEvent = PublishSubject<Void>()
    
    lazy var searchBar: SearchBar = {
        let view = SearchBar()
        return view
    }()
    
    lazy var backBarButton: BarButtonItem = {
        let view = BarButtonItem()
        view.title = ""
        return view
    }()
    
    lazy var closeBarButton: BarButtonItem = {
        let view = BarButtonItem(image: R.image.icon_navigation_close(),
                                 style: .plain,
                                 target: self,
                                 action: nil)
        return view
    }()
    
    lazy var contentView: View = {
        let view = View()
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        return view
    }()
    
    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        view.spacing = 0
        self.contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeUI()
        bindViewModel()
        
        closeBarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] () in
            self?.navigator.dismiss(sender: self)
        }).disposed(by: rx.disposeBag)
        
        // Observe device orientation change
        NotificationCenter.default
            .rx.notification(UIDevice.orientationDidChangeNotification).mapToVoid()
            .bind(to: orientationEvent).disposed(by: rx.disposeBag)
        
        orientationEvent.subscribe { [weak self] (event) in
            self?.orientationChanged()
        }.disposed(by: rx.disposeBag)
        
        // Observe application did become active notification
        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (event) in
                self?.didBecomeActive()
            }.disposed(by: rx.disposeBag)
        
        NotificationCenter.default
            .rx.notification(UIAccessibility.reduceMotionStatusDidChangeNotification)
            .subscribe(onNext: { (event) in
                print("Motion Status changed")
            }).disposed(by: rx.disposeBag)
        
        // Observe application did change language notification
        NotificationCenter.default
            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
            .subscribe { [weak self] (event) in
                self?.languageChanged.accept(())
            }.disposed(by: rx.disposeBag)
        
        // One finger swipe gesture for opening Flex
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleOneFingerSwipe(swipeRecognizer:)))
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)
        
        // Two finger swipe gesture for opening Flex and Hero debug
        let twoSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleTwoFingerSwipe(swipeRecognizer:)))
        twoSwipeGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoSwipeGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateUI()
    }
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(type(of: self)): Received Memory Warning")
    }
    
    func makeUI() {
        hero.isEnabled = true
        navigationItem.backBarButtonItem = backBarButton
        
        motionShakeEvent.subscribe(onNext: { () in
            let theme = themeService.type.toggled()
            themeService.switch(theme)
        }).disposed(by: rx.disposeBag)
        
        view.theme.backgroundColor = themeService.attribute { $0.primaryDark }
        backBarButton.theme.tintColor = themeService.attribute { $0.secondary }
        closeBarButton.theme.tintColor = themeService.attribute { $0.secondary }
        theme.emptyDataSetImageTintColorBinder = themeService.attribute { $0.text }
        
        updateUI()
    }
    
    func bindViewModel() {
        viewModel?.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.emptyDataSetTitle = R.string.localizable.commonNoResults.key.localized()
        }).disposed(by: rx.disposeBag)
        
        isLoading.subscribe(onNext: { isLoading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }).disposed(by: rx.disposeBag)
    }
    
    func updateUI() {
        
    }
    
    func startAnimating() {
        SVProgressHUD.show()
    }
    
    func stopAnimating() {
        SVProgressHUD.dismiss()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
    
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateUI()
        }
    }
    
    func didBecomeActive() {
        self.updateUI()
    }
    
    // MARK: Adjusting Navigation Item
    
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // presented
            self.navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
    @objc func closeAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    
    var inset: CGFloat {
        return Configs.BaseDimensions.inset
    }
    
    func emptyView(withHeight height: CGFloat) -> View {
        let view = View()
        view.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        return view
    }
    
    @objc func handleOneFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized, canOpenFlex {
            LibsManager.shared.showFlex()
        }
    }
    
    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized {
            LibsManager.shared.showFlex()
            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
        }
    }
}

extension ViewController: DZNEmptyDataSetSource {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetDescription)
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension ViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        emptyDataSetButtonTap.onNext(())
    }
}
