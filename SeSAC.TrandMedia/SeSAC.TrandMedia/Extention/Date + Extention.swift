//
//  Date + Extention.swift
//  SeSAC.TrandMedia
//
//  Created by Joonhwan Jeon on 2022/03/17.
//

import Foundation

func getDateToString(date: Date, format: String) -> String {
    var yesterDate = date
    yesterDate = Date(timeIntervalSinceNow: -3600*24*1)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
    
    return dateFormatter.string(from: yesterDate)
}
