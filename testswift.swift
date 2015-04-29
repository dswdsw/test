//
//  testswift.swift
//  test
//
//  Created by stephen on 15/4/16.
//  Copyright (c) 2015 dsw. All rights reserved.
//

import UIKit

class testswift : NSObject {
    func load() {
        var s = "dd"

        s = s.add("d")

        print(s)
        
        
        
    }
    
    func testView() -> UIView
    {
        let view:UIView = DStackView(width: 320)
        
        
        
        return view;
    }
}
