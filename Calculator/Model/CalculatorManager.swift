//
//  CalculatorManager.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/26.
//

import Foundation

enum OperatorType: String {
    case divide = " / "
    case multiple = " * "
    case minus = " - "
    case plus = " + "
}

final class CalculatorManager {
    private var result = "0" // 연산 결과
    private var operand = "" // 피연산자
    private var expression = "0"
    private var operatorType: OperatorType?
    
    //MARK: - 싱글톤 패턴으로 공유 인스턴스 생성
    static let shared = CalculatorManager()
    private init() {}

    func getResult() -> String {
        return result
    }
    func getActivatedOperatorType() -> OperatorType? {
        return operatorType
    }
    
    // 숫자 눌렸을 때
    func numberTapped(number: Int) {
        if let _ = operatorType {
            operand += "\(number)"
        } else {
            if result.count < 11 {
                if result == "0" {
                    result = ""
                }
                result = "\(result)\(number)"
            }
        }
        
    }
    // 점
    func dot() {
        if !result.contains("."), operatorType == nil {
            result += "."
        }
        if operatorType != nil {
            operand += "."
        }
    }
    
    // 초기화
    func ac() {
        result = "0"
        operand = ""
        operatorType = nil
    }
    // 부호
    func sign() {
        if operatorType == nil {
            if result.first == "-"{
                result.removeFirst()
            } else {
                result = "-\(result)"
            }
        } else {
            if operand.first == "-"{
                operand.removeFirst()
            } else {
                operand = "-\(operand)"
            }
        }
    }
    // %
    func percentage() {
        if let decimalResult = Decimal(string: result) {
            let newValue = decimalResult/Decimal(100)
            if !newValue.isNaN {
                result = String(Double(newValue.description)!)
            }
        }
    }
    
    func operation(_ tag: Int) {
        switch tag {
        case 13: // 나누기
            operatorType = .divide
        case 14: // 곱하기
            operatorType = .multiple
        case 15: // 빼기
            operatorType = .minus
        case 16: // 더하기
            operatorType = .plus
        case 17: // =
            self.calculate()
        default:
            break
        }
    }
    
    private func calculate() {
        guard let decimalOperand = Decimal(string: operand) else { return }
        
        var newValue: Decimal?
        
        switch operatorType {
        case .divide:
            newValue = Decimal(string: result)! / decimalOperand
        case .multiple:
            newValue = Decimal(string: result)! * decimalOperand
        case .minus:
            newValue = Decimal(string: result)! - decimalOperand
        case .plus:
            newValue = Decimal(string: result)! + decimalOperand
        default:
            break
        }
        
        if let newValue = newValue {
            if let operatorType = operatorType {
                let expression = "\(result)\(operatorType.rawValue)\(operand) = \(newValue)" // 저장할 수식
                CoreDataManager.shared.saveExpression(expression: expression)
            }
            result = String(Double(newValue.description)!)
        }
        operatorType = nil
        operand = ""
    }
}
