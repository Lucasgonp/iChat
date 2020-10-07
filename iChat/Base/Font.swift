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
    let fontTextBold: UIFont = UIFont(name:"Montserrat-Bold", size: size)!
    return fontTextBold
    }
    
    static func fontTextRegular(size: CGFloat) -> UIFont {
    let fontTextRegular: UIFont = UIFont(name:"Montserrat-Regular", size: size)!
    return fontTextRegular
    }
}
