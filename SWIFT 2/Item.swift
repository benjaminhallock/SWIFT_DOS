//
//  TableItem.swift
//  SWIFT 2
//
//  Created by benjaminhallock@gmail.com on 11/5/14.
//  Copyright (c) 2014 BEN. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    var text : String = ""
    var isChecked : Bool = false


    func encodeWithCoder(aCoder: NSCoder) {
         aCoder.encodeObject(text, forKey: "text")
        aCoder.encodeObject(isChecked, forKey: "isChecked")
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
    }

     init(name: String, Checked: Bool) {
        text = name
        isChecked = Checked
        super.init()
    }
}