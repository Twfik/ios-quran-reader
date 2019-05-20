//
//  Theme.swift
//  QuranAcademy
//
//  Created by Ayub on 02/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

enum Theme: Int {
    case `default`, green, dark
    
    private enum Keys {
        static let selectedTheme = "SelectedTheme"
    }
    
    static var current: Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: Keys.selectedTheme)
        return Theme(rawValue: storedTheme) ?? .default
    }
    
    static var themeRawValue: Int {
        return Theme.current.rawValue
    }
    
    var mainColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.4470588235, green: 0.7058823529, blue: 0.8078431373, alpha: 1)
        case .dark: return #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
        case .green: return #colorLiteral(red: 0.4549019608, green: 0.7058823529, blue: 0.6078431373, alpha: 1)
        }
    }
    
    var navigationBarColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.4470588235, green: 0.7058823529, blue: 0.8078431373, alpha: 1)
        case .dark: return #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        case .green: return #colorLiteral(red: 0.4549019608, green: 0.7058823529, blue: 0.6039215686, alpha: 1)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .default: return UIColor.white
        case .dark: return #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
        case .green: return .white
        }
    }
    
    var tableViewBackgroundColor: UIColor {
        switch self {
        case .default, .green: return #colorLiteral(red: 0.9411764706, green: 0.937254902, blue: 0.9607843137, alpha: 1)
        case .dark: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    var collectionViewBackgroundColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .dark: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .green: return #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.8666666667, alpha: 0.3013125)
        }
    }
    
    var collectionCellBackgroundColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 0.5)
        case .dark: return #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
        case .green: return #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.8666666667, alpha: 0)
        }
    }
    
    var collectionCellBorderColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        case .dark: return #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 0.154578125)
        case .green: return #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.8666666667, alpha: 1)
        }
    }
    
    var collectionViewCellSelectingColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        case .dark: return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        case .green: return #colorLiteral(red: 0.9647058824, green: 0.9215686275, blue: 0.8431372549, alpha: 0.502640625)
        }
    }
    
    var tableViewSeparatorColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.8666666667, alpha: 1)
        case .dark: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .green: return #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.8666666667, alpha: 1)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .default, .green: return UIColor.black
        case .dark: return UIColor.white
        }
    }
    
    var translationTextColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .green: return #colorLiteral(red: 0.431372549, green: 0.3725490196, blue: 0.3254901961, alpha: 1)
        case .dark: return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    var arabicCellBackgroundColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .green: return #colorLiteral(red: 0.9960784314, green: 0.9921568627, blue: 0.9764705882, alpha: 1)
        case .dark: return #colorLiteral(red: 0.05490196078, green: 0.05882352941, blue: 0.07450980392, alpha: 1)
        }
    }
    
    var translationCellBackgroundColor: UIColor {
        switch self {
        case .default: return #colorLiteral(red: 0.4470588235, green: 0.7058823529, blue: 0.8078431373, alpha: 0.10109375)
        case .green: return #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.9176470588, alpha: 1)
        case .dark: return #colorLiteral(red: 0.1254901961, green: 0.137254902, blue: 0.1647058824, alpha: 1)
        }
    }
    
    var highlight: UIColor {
        switch self {
        case .default, .green: return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case .dark: return UIColor.white
        }
    }
    
    static var themeWasChanged = PublishSubject<Void>()
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.selectedTheme)
        UserDefaults.standard.synchronize()
        
        UIApplication.shared.delegate?.window??.tintColor = mainColor
        UINavigationBar.appearance().tintColor = navigationBarColor
        UITabBar.appearance().barTintColor = backgroundColor
        UISwitch.appearance().onTintColor = mainColor
        Theme.themeWasChanged.onNext(())
    }
}
