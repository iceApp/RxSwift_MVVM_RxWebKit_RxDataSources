//
//  MainViewController.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/11/25.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var kvoViewLink: UIButton!
    @IBOutlet private weak var rxSwiftViewLink: UIButton!
    @IBOutlet private weak var rxTableViewLink: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"

        kvoViewLink.addTarget(self, action: #selector(didTapButtonKVO), for: .touchUpInside)
        rxSwiftViewLink.addTarget(self, action: #selector(didTapButtonRxSwift), for: .touchUpInside)
        rxTableViewLink.addTarget(self, action: #selector(didTapButtonRxTable), for: .touchUpInside)

    }

    @IBAction private func didTapButtonKVO(_ sender: Any) {
        let viewController = KVOViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction private func didTapButtonRxSwift(_ sender: Any) {
        let viewController = RxSwiftViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction private func didTapButtonRxTable(_ sender: Any) {
        let viewController = SettingsViewCountller()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
