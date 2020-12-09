//
//  SettingsViewController.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/12/07.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SettingsViewCountller: UIViewController, UIScrollViewDelegate {

    @IBOutlet private weak var tableView: UITableView!

    private var disposeBag = DisposeBag()

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(configureCell: configureCell)

    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell =
    { [weak self] (dataSourece, tableView, indexPath, _) in
        let item = dataSourece[indexPath]
        switch item {
        case .account, .security, .notification, .contens, .sounds, .dataUsing, .accesssibilty:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accssoryType
            return cell
        case .description(text: let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = text
            cell.isUserInteractionEnabled = false
            return cell
        }
    }

    private var viewModel: SettingsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupViewModel()
    }

    private func setupViewController() {
        navigationItem.title = "設定"
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account:
                    //　遷移する処理
                    break
                case .security:
                    //　遷移する処理
                    break
                case .notification:
                    //　遷移する処理
                    break
                case .contens:
                    //　遷移する処理
                    break
                case .sounds:
                    //　遷移する処理
                    break
                case .dataUsing:
                    //　遷移する処理
                    break
                case .accesssibilty:
                    //　遷移する処理
                    break
                case .description:
                    //　遷移する処理
                    break
                }
            }
            )
        .disposed(by: disposeBag)
    }

    private func setupViewModel() {
        viewModel = SettingsViewModel()

        viewModel.itemsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.setup()
    }
}

extension SettingsViewCountller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
