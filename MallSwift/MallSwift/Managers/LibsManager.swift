//
//  LibsManager.swift
//  MallSwift
//
//  Created by 曹素洋 on 2023/6/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher
import RxOptional
import RxGesture

/// The manager class for configuring all libraries used in app.
class LibsManager: NSObject {
    
    /// The default singleton instance.
    static let shared = LibsManager()
    
    override init() {
        super.init()
    }
    
    func setupLibs() {
        let libsManager = LibsManager.shared
        libsManager.setupTheme()
    }
    
    func setupTheme() {
//        UIApplication.shared.theme.statusBarStyle = themeService.attribute { $0.statusBarStyle }
    }
    
    
    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB

        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
}

extension LibsManager {

    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }

    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}

