//
//  CoreDataManager.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/28.
//

import UIKit
import CoreData
//MARK: - 계산 기록 저장(코어 데이터 - 내부 저장소)
final class CoreDataManager {
    // 싱글톤으로 인스턴스 생성
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    // context(임시저장소)
    lazy var context = appDelegate?.persistentContainer.viewContext
    // entity 이름
    let entityName = "CalculateHistoryData"
    
    //MARK: - [CREATE] 코어 데이터에 데이터 생성
    func saveExpression(expression: String) {
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악
            if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) {
                // 임시 저장소에 올라가게 할 객체 만들기
                if let calcData = NSManagedObject(entity: entity, insertInto: context) as? CalculateHistoryData {
                    calcData.expression = expression
                    calcData.date = Date()
                    appDelegate?.saveContext()
                    print("계산식 저장완료, \(calcData)")
                }
            }
        }
    }
    
    //MARK: - [READ] 코어데이터에 저장된 데이터 모두 읽기
    func getExpressions() -> [CalculateHistoryData] {
        var expressions = [CalculateHistoryData]()
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            // 정렬 순서
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                if let fetchedExpressions = try context.fetch(request) as? [CalculateHistoryData] {
                    expressions = fetchedExpressions
                }
            } catch {
                print("getExpressions() : fetch 에러")
            }
        }
        return expressions
    }

}
