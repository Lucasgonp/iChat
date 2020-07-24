//
//  Font.swift
//  iChat
//
//  Created by Lucas Pereira on 22/07/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//

import UIKit

struct Font {
    static func systemRegular(size: CGFloat) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size)
        return systemFont
    }
    static func systemBold(size: CGFloat) -> UIFont {
        let systemFontBold = UIFont.boldSystemFont(ofSize: size)
        return systemFontBold
    }
}

extension Font {
    
    static func fontTextBold(size: CGFloat) -> UIFont {
    let fontTextBold: UIFont = UIFont(name:"HelveticaNowText-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    return fontTextBold
    }
    static func fontTextMedium(size: CGFloat) -> UIFont {
    let fontTextMedium: UIFont = UIFont(name:"HelveticaNowText-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    return fontTextMedium
    }
    static func fontTextRegular(size: CGFloat) -> UIFont {
    let fontTextRegular: UIFont = UIFont(name:"HelveticaNowText-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    return fontTextRegular
    }
    static func fontTextLight(size: CGFloat) -> UIFont {
    let fontTextLight: UIFont = UIFont(name:"HelveticaNowText-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    return fontTextLight
    }
    
    
}
