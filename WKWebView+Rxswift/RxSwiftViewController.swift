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

class RxSwiftViewController: UIViewController {

    @IBOutlet weak var RxSwiftProgressView: UIProgressView!
    @IBOutlet weak var RxSwiftWKWebView: WKWebView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        let lodingObservable = RxSwiftWKWebView.rx.observe(Bool.self, "loading")
            .filterNil()
            .share() //ColdなObservableを以下3回subcribe(bind)しているので、3個のストリームが生成するのを防ぐために、share()でHotなObservableに変換してストリームが1回で済むようにしている

        // プログレスバーの表示・非表示
        lodingObservable
            .map { return !$0 }
            .bind(to: RxSwiftProgressView.rx.isHidden)
            .disposed(by: disposeBag)

        // iPhoneの上部の時計のところのバーの(名称不明)アクティビティーインジゲーター表示制御
        lodingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)

        // NavigationControllerのタイトル表示
        lodingObservable
            .map { [weak self] _ in self?.RxSwiftWKWebView.title }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        // プログレスバーの進捗アニメーション
        RxSwiftWKWebView.rx.observe(Double.self, "estimatedProgress")
            .filterNil()
            .map { Float($0) }
            .bind(to: RxSwiftProgressView.rx.progress)
            .disposed(by: disposeBag)

        guard let url = URL(string: "https://www.google.com/") else { return }
        let urlRequest = URLRequest(url: url)
        RxSwiftWKWebView.load(urlRequest)
    }
}
