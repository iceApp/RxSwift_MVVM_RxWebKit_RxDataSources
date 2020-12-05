//
//  KVOViewController.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/11/28.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit
import WebKit

// KVOパターン
class KVOViewController: UIViewController {

    @IBOutlet private weak var wkWebView: WKWebView!
    @IBOutlet private weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupwebView()
    }
    
    deinit {
        // 監視を解除
        wkWebView?.removeObserver(self, forKeyPath: "loading")
        wkWebView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    func setupwebView() {
        // webView.isLladingの値の変化を監視
        wkWebView?.addObserver(self, forKeyPath: "loading", options: .new, context: nil)

        // webView.estimateProgressの値の変化を監視
        wkWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        guard let url = URL(string: "https:www.google.com/") else { return }
        let urlRequest = URLRequest(url: url)
        wkWebView?.load(urlRequest)
        progressView?.setProgress(0.1, animated: true)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if !wkWebView.isLoading {
                // ロード完了時にProgressViewの進捗を0.0（非表示）にする
                //progressView.setProgress(0.0, animated: false)

                //　ロード完了時にNavigationTitleに読み込んだページのタイトルをセット
                navigationItem.title = wkWebView.title
            }
        }
        if keyPath == "estimatedProgress" {
            // ProgressViewの進捗状態を更新
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)

            // estimatedProgressが1.0になったらアニメーションを使って非表示
            if self.wkWebView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3,
                               delay: 0.6,
                               options: [.curveEaseOut],
                               animations: { [weak self] in
                                self?.progressView.alpha = 0.0
                    }, completion: { _ in
                        self.progressView.setProgress(1.0, animated: false)
                })
            }
        }
    }
}
