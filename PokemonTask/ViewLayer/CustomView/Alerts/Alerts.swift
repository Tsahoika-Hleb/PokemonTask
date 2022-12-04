//
//  NetworkErrorAlert.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 4.12.22.
//

import UIKit

enum Alerts {
    case networkErrorAlert
}

extension Alerts {
    var rowValue: UIAlertController {
        get {
            switch self {
            case.networkErrorAlert:
                return UIAlertController(title: "Fail", message: "An error occurred, please please check your internet connection.", preferredStyle: .alert)
            }
        }
    }
}

