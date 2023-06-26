//
//  ViewController.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/26.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOulet 연결
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
    
    //MARK: - 라이프 사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
 
}

extension ViewController {
    func configureUI() {
        let r = one.frame.width / 2
        buttons.forEach { button in
            guard let button = button else { return }
            button.clipsToBounds = true
            button.layer.cornerRadius = r
        }
    }
}
