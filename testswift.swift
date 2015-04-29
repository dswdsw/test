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

                let item : UIView = UIView(frame : CGRectMake(0, 0, 0, 0))

                    var dic : Dictionary = Dictionary<String, Int> ()
                        dic["one"] = 10
                            dic["two"] = 20
    }

    func testView()->UIView {
        let view : UIView = DStackView(width : 320)

            return view;
        
      //  let view : DStackView = DStackView(width: 240)
    }
}
