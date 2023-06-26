//
//  ViewController.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/26.
//

import UIKit

final class ViewController: UIViewController {
    //MARK: - IBOulet
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    
    @IBOutlet weak var dot: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private lazy var buttons = [acButton, signButton, percentButton, dot, zero, one, two, three, four, five, six, seven, eight, nine, divideButton, multiButton, minusButton, plusButton, equalButton]
    
    let calculatorManager = CalculatorManager.shared
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    //MARK: - IBAction
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case -1:
            calculatorManager.dot()
        case 0...9: // 0 ~ 9
            calculatorManager.numberTapped(number: sender.tag)
            resetButtonColor()
        case 10: // AC
            calculatorManager.ac()
            resetButtonColor()
        case 11: // +/-
            calculatorManager.sign()
        case 12: // %
            calculatorManager.percentage()
        default: // 연산자 (/,*,-,+,=)
            calculatorManager.operation(sender.tag)
            
            resetButtonColor()
            switch calculatorManager.getActivatedOperatorType() {
            case .divide:
                divideButton.setTitleColor(UIColor(named: "orange"), for: .normal)
                divideButton.backgroundColor = .white
            case .multiple:
                multiButton.setTitleColor(UIColor(named: "orange"), for: .normal)
                multiButton.backgroundColor = .white
            case .minus:
                minusButton.setTitleColor(UIColor(named: "orange"), for: .normal)
                minusButton.backgroundColor = .white
            case .plus:
                plusButton.setTitleColor(UIColor(named: "orange"), for: .normal)
                plusButton.backgroundColor = .white
            default:
                break
            }
        }
        resultLabel.text = calculatorManager.getResult()
    }
 
}

//MARK: - Custom Functions
extension ViewController {
    private func configureUI() {
        let r = one.frame.width / 2
        buttons.forEach { button in
            guard let button = button else { return }
            button.clipsToBounds = true
            button.layer.cornerRadius = r
        }
    }
    
    private func resetButtonColor() {
        divideButton.setTitleColor(.white, for: .normal)
        divideButton.backgroundColor = UIColor(named: "orange")
        multiButton.setTitleColor(.white, for: .normal)
        multiButton.backgroundColor = UIColor(named: "orange")
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = UIColor(named: "orange")
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = UIColor(named: "orange")
    }
    
}
