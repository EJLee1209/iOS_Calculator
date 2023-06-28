//
//  HistoryViewController.swift
//  Calculator
//
//  Created by 이은재 on 2023/06/28.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let coreDataManager = CoreDataManager.shared
    var calculateHistoryDatas = [CalculateHistoryData]()
    
    //MARK: - 라이프 사이클
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // tableView 갱신
    private func reloadTableView() {
        calculateHistoryDatas = coreDataManager.getExpressions()
        tableView.reloadData()
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .black
    }
}


//MARK: - UITableViewDataSource
extension HistoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculateHistoryDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else { return UITableViewCell() }
        cell.data = calculateHistoryDatas[indexPath.row]
        return cell
    }
}
