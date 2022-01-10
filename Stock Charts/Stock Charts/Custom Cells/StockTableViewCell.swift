//
//  StockTableViewCell.swift
//  Stock Charts
//
//  Created by Sourabh Ghosh on 17/12/21.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!{
        didSet {
            
            symbolLabel.textColor = Constant.blackText
        }
    }
    @IBOutlet weak var shortNameLabel: UILabel!{
        didSet {
            
            shortNameLabel.textColor = Constant.lightBlackText
        }
    }
    @IBOutlet weak var regularMarketPriceLabel: UILabel!{
        
        didSet{
            regularMarketPriceLabel.textColor = Constant.blackText
        }
    }
    @IBOutlet weak var regularMarketChangePercertButton: UIButton! {
        
        didSet{
            
            regularMarketChangePercertButton.backgroundColor = Constant.lightGreen
        }
    }
    @IBOutlet weak var regularMarketPostLabel: UILabel!
    var stockListViewModel = StockListViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configurePercentCell (_ vm: StockViewModel){
        
        symbolLabel.text = vm.symbol
        shortNameLabel.text = vm.shortName
        regularMarketPriceLabel.text = vm.regularMarketPrice.formatAsString()
        
        
        if vm.regularMarketChangePercent.sign == .minus {
            
            regularMarketChangePercertButton.backgroundColor = Constant.lightRed
            
        }
        regularMarketChangePercertButton.titleLabel?.text = vm.regularMarketChangePercent.formatAsPercent()
 
    }
    
    func configureValueCell (_ vm: StockViewModel){
        
        symbolLabel.text = vm.symbol
        shortNameLabel.text = vm.shortName
        regularMarketPriceLabel.text = vm.regularMarketPrice.formatAsString()
        
        
        if vm.regularMarketChangeValue.sign == .minus {
            
            regularMarketChangePercertButton.backgroundColor = Constant.lightRed
            
        }
        
        regularMarketChangePercertButton.titleLabel?.text = vm.regularMarketChangeValue.formatAsString()
        
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
