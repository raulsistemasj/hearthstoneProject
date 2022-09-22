//
//  UIcolor+Extensions.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Home Colors
    
    public static var ramdomColor: UIColor {
        UIColor(red: .random(in: 0...0.58), green: .random(in: 0...0.58), blue: .random(in: 0...0.58), alpha: 1)
    }
    
    public static var WindowBackgroundColor: UIColor {
        UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    public static var homeTitleLabelColor: UIColor {
        UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
    }
    
    public static var homeLineViewColor: UIColor {
        UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    // MARK: - Card Options Colors
    
    public static var cardOptionTitleLabelColor: UIColor {
        UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
    }
}
