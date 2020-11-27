//
//  MainViewController.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/11/25.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var rxSwiftViewLink: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        rxSwiftViewLink.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    

    @IBAction func didTapButton(_ sender: Any) {

        let viewController = RxSwiftViewController()
        self.navigationController?.pushViewController(viewController, animated: true)

    }

}
