//
//  StockChartViewController.swift
//  Stock Charts
//
//  Created by Sourabh Ghosh on 15/12/21.
//

import UIKit


class StockChartViewController: UIViewController {

    @IBOutlet weak var stockSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var stockListViewModel = StockListViewModel()
   // var stockType : StockType = .percent
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stockListViewModel.populateStocks { [weak self] in
            self?.tableView.reloadData()
        }
        
        
    }
    
    @IBAction func indexChangedOfSegment(_ sender: UISegmentedControl) {
        
        switch stockSegmentControl.selectedSegmentIndex {
        // use Swift type inference & stop repeating code. 
        case 0:
            stockListViewModel.stockType = .percent
            
        case 1:
            stockListViewModel.stockType = .value
            
        default:
            print("Defult")
        }
        self.tableView.reloadData()
    }
   
    
}

// MARK: - Table view data source

extension StockChartViewController: UITableViewDelegate, UITableViewDataSource {
    
   

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.stockListViewModel.stocksViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = stockListViewModel.stockViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockTableViewCell", for: indexPath) as! StockTableViewCell
        if stockListViewModel.stockType == .percent {
            
            cell.configurePercentCell(vm)
        } else {
            
            cell.configureValueCell(vm)
        }
        
        
        return cell
    }
    

}
