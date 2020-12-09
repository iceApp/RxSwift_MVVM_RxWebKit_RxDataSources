//
//  SettingsSectionModel.swift
//  WKWebView+Rxswift
//
//  Created by sasada.m on 2020/12/05.
//  Copyright © 2020 sasada.m. All rights reserved.
//

import UIKit
import RxDataSources

typealias SettingsSectionModel = SectionModel<SettingsSection, SettingsItem>

enum SettingsSection {
    case account
    case common

    var headerHeight: CGFloat {
        40.0
    }

    var footerHeight: CGFloat {
        1.0
    }
}

enum SettingsItem {
    // account section
    case account
    case security
    case notification
    case contens
    //common section
    case sounds
    case dataUsing
    case accesssibilty
    //other
    case description(text: String)

    var title: String? {
        switch self {
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティー"
        case .notification:
            return "通知"
        case .contens:
            return "コンテンツ設定"
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用時の設定"
        case .accesssibilty:
            return "アクセシビリティ"
        default:
            return nil
        }
    }

    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }

    var accssoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account, .security, .notification, .contens, .sounds, .dataUsing, .accesssibilty:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }
}
