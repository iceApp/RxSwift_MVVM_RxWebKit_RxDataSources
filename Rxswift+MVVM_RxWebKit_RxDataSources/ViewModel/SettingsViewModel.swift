//
//  SettingsViewModel.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/12/07.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewModel {
    private let items = BehaviorRelay<[SettingsSectionModel]>(value: [])

    var itemsObservable: Observable<[SettingsSectionModel]> {
        return items.asObservable()
    }

    func setup() {
        updateItems()
    }

    private func updateItems() {
        let sections: [SettingsSectionModel] = [
            accountSection(),
            commonSection()
        ]
        items.accept(sections)
    }

    private func accountSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
        .account,
        .security,
        .notification,
        .contens
        ]
        return SettingsSectionModel(model: .account, items: items)
    }

    private func commonSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
        .sounds,
        .dataUsing,
        .accesssibilty,
        .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }
}
