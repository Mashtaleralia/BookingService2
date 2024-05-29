//
//  Style.swift
//  YetAnotherBookingService
//
//  Created by Admin on 29.05.2024.
//

import Foundation
import UIKit

public protocol StyleProvider {
    var backgroundColor: UIColor { get }
    
    var textColor: UIColor { get }
    
    var secondaryTextColor: UIColor { get }
    
    var title1: UIFont { get }
    var title2: UIFont { get }
    var title3: UIFont { get }
    
}

public struct Style: StyleProvider {
    
    public var backgroundColor: UIColor = Style.black
    
    public var textColor: UIColor = Style.white
    
    public var secondaryTextColor: UIColor = Style.lightGray
    
    public var title1: UIFont = .systemFont(ofSize: 22, weight: .semibold)
    
    public var title2: UIFont = .systemFont(ofSize: 16, weight: .semibold)
    
    public var title3: UIFont = .systemFont(ofSize: 14, weight: .regular)
    
    private static let black = UIColor(red: 67/255, green: 70/255, blue: 75/255, alpha: 1)
    private static let gray = UIColor(red: 168/255, green: 174/255, blue: 186/255, alpha: 1)
    private static let lightGray = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1)
    private static let white = UIColor(white: 1, alpha: 1)
    
}
