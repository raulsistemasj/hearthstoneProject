//
//  Utils.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 21/09/22.
//

import Foundation
import UIKit

final class Utils {
    static func closeApplication() {
        DispatchQueue.main.async {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(0) }
        }
    }
}
