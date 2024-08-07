//
//  CellConfigurationModel.swift
//  UIKitDynamics
//
//  Created by Andy on 2024-08-07.
//

import Combine
import UIKit

enum CellConfigurationModel {
    case button(Button)
    case `switch`(Switch)
    case text(Text)

    struct Switch {
        let title: String
        var isOn: Bool
        var onUpdate: (Bool) -> Void
    }

    struct Button {
        let title: String
        var image: UIImage? = nil
//        let isEnabled: CurrentValueSubject<Bool, Never>?
        let onTap: () -> Void
    }

    struct Text {
        let title: String
        let subtitle: String?
    }
}
