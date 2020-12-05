//
//  ViewController.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/11/17.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxOptional
import RxWebKit

class RxSwiftViewController: UIViewController {

    @IBOutlet private weak var rxSwiftProgressView: UIProgressView!
    @IBOutlet private weak var rxSwiftWKWebView: WKWebView!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }

    @IBAction private func didTapButtonForward(_ sender: Any) {
        rxSwiftWKWebView.goForward()
    }

    @IBAction private func didTapButtonBack(_ sender: Any) {
        rxSwiftWKWebView.goBack()
    }

    private func setupWebView() {
        rxSwiftWKWebView.allowsBackForwardNavigationGestures = true
        forwardButton.addTarget(self, action: #selector(didTapButtonForward), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapButtonBack), for: .touchUpInside)

        let lodingObservable = rxSwiftWKWebView.rx.loading
            .share() //ColdなObservableを以下3回subcribe(bind)しているので、3個のストリームが生成するのを防ぐために、share()でHotなObservableに変換してストリームが1回で済むようにしている

        // プログレスバーの表示・非表示
        lodingObservable
            .map { return !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: rxSwiftProgressView.rx.isHidden)
            .disposed(by: disposeBag)

        // iPhoneの上部の時計のところのバーの(名称不明)アクティビティーインジゲーター表示制御
        lodingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)

        // NavigationControllerのタイトル表示
        rxSwiftWKWebView.rx.title
            .filterNil()
            .observeOn(MainScheduler.instance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        // プログレスバーの進捗アニメーション
        rxSwiftWKWebView.rx.estimatedProgress
            .map { return Float($0) }
            .observeOn(MainScheduler.instance)
            .bind(to: rxSwiftProgressView.rx.setProgress)
            .disposed(by: disposeBag)

        rxSwiftWKWebView.rx.canGoForward
            .asDriver(onErrorJustReturn: false)
            .drive(forwardButton.rx.isEnabled)
            .disposed(by: disposeBag)

        rxSwiftWKWebView.rx.canGoBack
            .asDriver(onErrorJustReturn: false)
            .drive(backButton.rx.isEnabled)
            .disposed(by: disposeBag)

        guard let url = URL(string: "https://www.google.com/") else { return }
        let urlRequest = URLRequest(url: url)
        rxSwiftWKWebView.load(urlRequest)

    }
}

// RxSwiftでbutton.isEnabledのBindTo可能な独自プロパティ追加
extension Reactive where Base: UIBarButtonItem {
    var isEnabled: Binder<Bool> {
        return Binder(base) { button, isEnable in
            button.isEnabled = isEnable
        }
    }
}

// RxSwiftのsetProgressプロパティを追加
extension Reactive where Base: UIProgressView {
    var setProgress: Binder<Float> {
        return Binder(base) { progressView, int in
            if int > 0.1 {
                progressView.setProgress(int, animated: true )
            } else {
                progressView.setProgress(0.1, animated: false )
            }
        }
    }
}
