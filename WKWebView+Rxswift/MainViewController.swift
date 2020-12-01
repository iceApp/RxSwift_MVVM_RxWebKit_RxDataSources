//
//  MainViewController.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/11/25.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var kvoViewLink: UIButton!
    @IBOutlet weak var rxSwiftViewLink: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"

        kvoViewLink.addTarget(self, action: #selector(didTapButtonKVO), for: .touchUpInside)
        rxSwiftViewLink.addTarget(self, action: #selector(didTapButtonRxSwift), for: .touchUpInside)
    }

    @IBAction func didTapButtonKVO(_ sender: Any) {

        let viewController = KVOViewController()
        self.navigationController?.pushViewController(viewController, animated: true)

    }

    @IBAction func didTapButtonRxSwift(_ sender: Any) {

        let viewController = RxSwiftViewController()
        self.navigationController?.pushViewController(viewController, animated: true)

    }

}
