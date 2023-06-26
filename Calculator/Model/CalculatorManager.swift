//
//  CalculatorManager.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/26.
//

import Foundation

enum OperatorType {
    case divide, multiple, minus, plus
}


final class CalculatorManager {
    private var result = "0" // 연산 결과
    private var operand = "" // 피연산자
    private var defaultOperand = "1" // 피연산자 디폴트값
    private lazy var expression = "" // 계산식
    
    private var operatorType: OperatorType?
    
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
        if !result.contains(".") {
            result += "."
        }
    }
    
    // 초기화
    func ac() {
        result = "0"
        operatorType = nil
    }
    // 부호
    func sign() {
        if result.first == "-" {
            result.removeFirst()
        } else {
            result = "-\(result)"
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
            defaultOperand = result
        case 14: // 곱하기
            operatorType = .multiple
            defaultOperand = result
        case 15: // 빼기
            operatorType = .minus
            defaultOperand = result
        case 16: // 더하기
            operatorType = .plus
            defaultOperand = result
        case 17: // =
            self.calculate()
        default:
            break
        }
    }
    
    private func calculate() {
        var newValue: Decimal?
        
        switch operatorType {
        case .divide:
            if let decimalOperand = Decimal(string: operand) {
                newValue = Decimal(string: result)! / decimalOperand
            } else {
                newValue = Decimal(string: result)! / Decimal(string: defaultOperand)!
            }
        case .multiple:
            if let decimalOperand = Decimal(string: operand) {
                newValue = Decimal(string: result)! * decimalOperand
            } else {
                newValue = Decimal(string: result)! * Decimal(string: defaultOperand)!
            }
        case .minus:
            if let decimalOperand = Decimal(string: operand) {
                newValue = Decimal(string: result)! - decimalOperand
            } else {
                newValue = Decimal(string: result)! - Decimal(string: defaultOperand)!
            }
        case .plus:
            if let decimalOperand = Decimal(string: operand) {
                newValue = Decimal(string: result)! + decimalOperand
            } else {
                newValue = Decimal(string: result)! + Decimal(string: defaultOperand)!
            }
        default:
            break
        }
        if let newValue = newValue {
            result = String(Double(newValue.description)!)
        }
        operatorType = nil
        operand = ""
    }
    
    
}
