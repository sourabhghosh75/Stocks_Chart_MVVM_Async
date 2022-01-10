//
//  StockViewModel.swift
//  Stock Charts
//
//  Created by Sourabh Ghosh on 18/12/21.
//

import Foundation

class StockListViewModel {
    var stocksViewModel : [StockViewModel]
    var stockType : StockType = .percent
    init (){
        self.stocksViewModel = [StockViewModel]()
    }
}
extension StockListViewModel {
    
    func stockViewModel(at index:Int) -> StockViewModel {
        
       return  self.stocksViewModel[index]
    }
    
    func populateStocks(completion:@escaping()->()) {
        
        
        Webservice().load(resouce: Stock.all) {  result  in
            
            switch result {
                
            case .success(let stocks):
                self.stocksViewModel = stocks.map(StockViewModel.init)
                completion()
                
            case .failure(let error):
                print(error)
            }
            
        }
      
    }
}

struct StockViewModel {
    let stock : Stock
    
}

extension StockViewModel {
    
    var symbol : String {
        
        return self.stock.symbol
    }
    
    var shortName : String {
        return self.stock.shortName
    }
    
    var regularMarketPrice : Double {
        return self.stock.regularMarketPrice
    }
    
    var regularMarketChangePercent : Double {
        return self.stock.regularMarketChangePercent
    }
    
    var regularMarketChangeValue : Double {
        return self.stock.regularMarketChange
    }
    
    
    
    
}
