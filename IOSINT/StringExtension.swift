//
//  StringExtension.swift
//  IOSINT
//
//  Created by Эля Корельская on 24.05.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
