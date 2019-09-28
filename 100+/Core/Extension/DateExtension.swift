//
//  DateExtension.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

extension Date {
    
    func date(days:Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }
    
    func ddMM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d\nMMM"
        return dateFormatter.string(from: self)
    }
    
}
