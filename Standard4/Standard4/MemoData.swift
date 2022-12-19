//
//  MemoData.swift
//  Standard4
//
//  Created by 윤채영 on 2022/10/20.
//

import Foundation

class MemoData {
    var title : String?
    var date : String?
    var text : String?
    
    init(_ title : String, _ date : String, _ text : String){
        self.title = title
        self.date = date
        self.text = text
    }
}
