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
    let fontTextBold: UIFont = UIFont(name:"Didot_LT_Std-Bold", size: size) ?? .systemFont(ofSize: size)
    return fontTextBold
    }
    
    static func fontTextRegular(size: CGFloat) -> UIFont {
        let fontTextRegular: UIFont = UIFont(name:"Didot-Regular", size: size) ?? .systemFont(ofSize: size)
    return fontTextRegular
    }
}
