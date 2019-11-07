//
//  String+Extension.swift
//  Sudoku
//
//  Created by Mac on 19/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(withComment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
    func localized(tableName: String) -> String{
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
    }
    
}
