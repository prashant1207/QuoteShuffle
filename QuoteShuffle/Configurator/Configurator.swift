//
//  Configurator.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 29/10/20.
//

import Foundation
import SwiftUI

class Configurator {
    var settings: [IConfigOptionBase] = []
    func populateSettings() {
        guard settings.isEmpty else {
            print("settings already loaded")
            return
        }

        let startupText = Settings(value: "Hello", name: Setting.Key.quoteStartup, isCached: true, valididty: 300)
        let isLoadingView = Settings(value: true, name: Setting.Key.isLoadingView, isCached: true, valididty: 300)

        settings.append(startupText)
        settings.append(isLoadingView)

        print(settings.count)
    }

    func useSetting<T>(_ key: String, defaultValue: T, completion: ((T) -> Void)) {
        let found = settings.first { item -> Bool in
            guard let item = item as? Settings<T> else {
                return false
            }

            return item.name == key
        }

        guard let item = found as? Settings<T> else {
            completion(defaultValue)
            return
        }

        completion(item.value)
    }

    func useSettingSync<T>(_ key: String, defaultValue: T) -> T {
        if settings.isEmpty {
            populateSettings()
        }

        let found = settings.first { item -> Bool in
            guard let item = item as? Settings<T> else {
                return false
            }

            return item.name == key
        }

        guard let item = found as? Settings<T> else {
            return defaultValue
        }

        return item.value
    }
}

enum Setting {
    enum Key {
        static let quoteStartup = "quote_startup"
        static let isLoadingView = "is_loading_view"
    }
}

struct Settings<T>: IConfigOption {
    var value: T
    var name: String
    var isCached: Bool
    var valididty: Int
}

protocol IConfigOptionBase {}

protocol IConfigOption: IConfigOptionBase {
    associatedtype ItemType

    var name: String {get set}

    var value: ItemType {get set}

    var isCached: Bool {get set}

    var valididty: Int {get set}
}
