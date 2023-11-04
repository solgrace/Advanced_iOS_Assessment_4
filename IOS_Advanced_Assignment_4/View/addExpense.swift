//
//  addExpense.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 31/10/23.
//

import SwiftUI

struct addExpense: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var expenseName: String = ""
    @State private var expenseAmount: String = ""
    @State private var category: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let model = Inexpensify()
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Expense Name")
                    .font(.headline)
                TextField("E.g. Dinner at Joe's", text: $expenseName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Expense Amount")
                    .font(.headline)
                TextField("E.g. 50", text: $expenseAmount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            Button(action: {
                
                if let amount = Int(expenseAmount) {
                    
                    classifyText()
                    
                    let transaction = Transaction(name: expenseName, amount: amount, category: category)
                    
                    modelData.addExpense(transaction: transaction)
                    
                    alertMessage = "Expense added successfully!"
                    showAlert = true
                }
                else {
                    
                    alertMessage = "Please enter a valid amount."
                    showAlert = true
                }
            }) {
                Text("Add Expense")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
        }
        .padding(.horizontal, 25)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func classifyText() {
        do {
            let prediction = try model.prediction(text: expenseName)
            category = prediction.label
            sendNotification(text: expenseName)
        } catch {
            print("Error classifying text: \(error)")
            category = "Error"
        }
    }
    
    func sendNotification(text: String) {
            let content = UNMutableNotificationContent()
            content.title = "Classified"
            content.body = "Classified " + text

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Trigger the notification after 5 seconds

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
}

struct addExpense_Previews: PreviewProvider {
    static var previews: some View {
        addExpense()
            .environmentObject(ModelData())
    }
}
