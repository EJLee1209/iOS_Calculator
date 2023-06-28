//
//  CalculateHistoryData+CoreDataProperties.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/28.
//
//

import Foundation
import CoreData


extension CalculateHistoryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalculateHistoryData> {
        return NSFetchRequest<CalculateHistoryData>(entityName: "CalculateHistoryData")
    }

    @NSManaged public var expression: String?
    @NSManaged public var date: Date?
    
    var formatedDateString : String {
        if let dateTime = date?.description.split(separator: " ").map({ String($0) }) {
            return dateTime[..<2].joined(separator: " ")
        } else {
            return ""
        }
    }
}

extension CalculateHistoryData : Identifiable {

}
