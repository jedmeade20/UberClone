//
//  Double.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/18/24.
//

import Foundation

extension Double {
    
    private var currencyConverter: NumberFormatter {
        //new instance of object
        let currency =  NumberFormatter()
        //type
        currency.numberStyle = .currency
        //how many decimels
        currency.minimumFractionDigits = 2
        currency.maximumFractionDigits = 2
        
        return currency
        
    }
    //convert num to string
    func toCurrency() -> String{
        return currencyConverter.string(for: self) ?? ""
    }
}
