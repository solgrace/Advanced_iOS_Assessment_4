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
    
    @Environment(\.managedObjectContext) private var viewContext

    
    
    let model = Inexpensify()
    
    var body: some View {
        
        VStack {
            Text("Testing the Classifier App")
                .font(.largeTitle)
                .padding()

            TextField("Enter a word", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Classify") {
                classifyText()
                modelData.addExpense(category: category)
            }
            .font(.headline)
            .padding()

            Text("Category: \(category)")
                .font(.headline)
                .padding()
            
            ForEach(Array(modelData.Expenses), id: \.self) { expense in
                Text(expense.category!)
            }
            
            
        }
    }

    func classifyText() {
        do {
            let prediction = try model.prediction(text: userInput)
            category = prediction.label
        } catch {
            print("Error classifying text: \(error)")
            category = "Error"
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
