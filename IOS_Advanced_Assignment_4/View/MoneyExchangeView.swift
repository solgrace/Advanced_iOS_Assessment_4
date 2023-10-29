//
//  MoneyExchangeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by Grace Rufina Solibun on 27/10/2023.
//

import SwiftUI

struct MoneyExchangeView: View {
    let currencyCode: String
    let exchangeRate: Double
    @ObservedObject var currencyConverterViewModel: CurrencyConverter

    @State private var inputAmount: String = ""
    @State private var convertedAmount: Double = 0.0
    
    init(currencyCode: String, exchangeRate: Double) {
//        print("MoneyExchangeView init called with currencyCode: \(currencyCode) and exchangeRate: \(exchangeRate)")
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
        self.currencyConverterViewModel = CurrencyConverter(currencyCode: currencyCode, exchangeRate: exchangeRate)
    }

    var body: some View {
        VStack {
            Text("\(currencyCode) with exchange rate \(exchangeRate)")

            TextField("Enter Amount", text: $inputAmount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Convert") {
                print("Button Pressed")
                print("Input Amount (Before Binding): \(inputAmount)")
                currencyConverterViewModel.convertAmount(inputAmount: inputAmount) // Pass inputAmount as a parameter
                print("Input Amount (After Binding): \(inputAmount)")
                print("Converted Amount: \(currencyConverterViewModel.convertedAmount)")
            }
            
//            Text("Converted \(currencyCode) Amount: \(convertedAmount, specifier: "%.2f")")
            Text("Converted \(currencyCode) Amount: \(currencyConverterViewModel.convertedAmount, specifier: "%.2f")")
        }
    }
}

//struct MoneyExchangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyExchangeView()
//    }
//}
