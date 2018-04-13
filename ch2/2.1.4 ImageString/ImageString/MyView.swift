//
//  MyView.swift
//  ImageString
//
//  Created by 关东升 on 15/1/24.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class MyView: UIView {

    override func draw(_ rect: CGRect) {
        
        let imagePath = Bundle.main.path(forResource: "dog", ofType: "png")
        
        let myImageObj = UIImage(contentsOfFile : imagePath!)
        myImageObj?.draw(in: CGRect(x: 0, y: 40, width: 320, height: 400))
        //myImageObj?.drawAsPatternInRect(CGRectMake(0, 0, 320, 400))

        let title:NSString = "我的小狗"
        let font = UIFont.systemFont(ofSize: 34)
    
        let attr = [NSAttributedStringKey.font: font]
        title.draw(at: CGPoint(x: 100, y: 20), withAttributes:attr)
    }

}
