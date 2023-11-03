//
//  HomeView.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var userInput: String = ""
    @State private var category: String = ""
    
    @EnvironmentObject var modelData: ModelData

    @FetchRequest(entity: Expense.entity(), sortDescriptors: []) var expenses: FetchedResults<Expense>
    
    let model = Inexpensify()
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 20) {
                // Budget Overview Section
                Text("Budget Overview")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.bottom, 10)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.blue), alignment: .bottom
                    )
                
                HStack {
                    VStack {
                        Text("Fashion")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(String(modelData.sumOfCategory(category: "Fashion")))
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    
                    VStack {
                        Text("Food")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(String(modelData.sumOfCategory(category: "Food")))
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    
                    VStack {
                        Text("Travel")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(String(modelData.sumOfCategory(category: "Travel")))
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    
                }
                
                // We can display the three boxes of information here
                        
                // Recent Expenses Section
                Text("Recent Expenses")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom, 10)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.blue), alignment: .bottom
                    )
                
                List(expenses, id: \.self) { expense in
                    
                    HStack {
                        Text(expense.name ?? "")
                            .font(.headline)
                        Spacer()
                        Text("\(expense.amount)")
                            .font(.subheadline)
                        Spacer()
                        Text("\(expense.category ?? "Generic")")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        
                        Button(action: {
                            
                            let transaction = Transaction(id: expense.id, name: expense.name!, amount: expense.amount, category: expense.category!, addTime: expense.addTime!)
                            // Here you call your delete function
                            modelData.deleteExpense(transaction: transaction)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                // Add Expense Button
                NavigationLink(destination: addExpense()) {
                    Text("Add Expense")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                        
                Spacer()
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
