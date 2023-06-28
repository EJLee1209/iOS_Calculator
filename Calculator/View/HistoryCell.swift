//
//  HistoryCell.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/28.
//

import UIKit

class HistoryCell: UITableViewCell {
    static let identifier = "HistoryCell"
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expressionLabel: UILabel!

    var data : CalculateHistoryData? {
        didSet {
            configureUI()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureUI() {
        dateLabel.text = data?.formatedDateString
        expressionLabel.text = data?.expression
    }
}
