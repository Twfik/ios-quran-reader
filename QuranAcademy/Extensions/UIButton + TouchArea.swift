//
//  UIButton + TouchArea.swift
//  QuranAcademy
//
//  Created by Ayub on 26.06.2018.
//  Copyright © 2018 Ayub. All rights reserved.
//

//#if os(OSX)
//// Skip macOS
//#else
//
//import UIKit
//
//
//private var pTouchAreaEdgeInsets: UIEdgeInsets = .zero
//
//extension UIControl {
//
//    public var touchAreaEdgeInsets: UIEdgeInsets {
//        get {
//            guard let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue else { return .zero }
//            var edgeInsets: UIEdgeInsets = .zero
//            value.getValue(&edgeInsets)
//            return edgeInsets
//        } set {
//            var newValueCopy = newValue
//            let objCType = NSValue(uiEdgeInsets: .zero).objCType
//            let value = NSValue(&newValueCopy, withObjCType: objCType)
//            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        if UIEdgeInsetsEqualToEdgeInsets(self.touchAreaEdgeInsets, .zero) || !self.isEnabled || self.isHidden {
//            return super.point(inside: point, with: event)
//        }
//        
//        let hitFrame = UIEdgeInsetsInsetRect(bounds, self.touchAreaEdgeInsets)
//        return hitFrame.contains(point)
//    }
//    
//}
//
//#endif
