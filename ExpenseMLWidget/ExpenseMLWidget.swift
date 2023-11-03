//
//  ExpenseMLWidget.swift
//  ExpenseMLWidget
//
//  Created by Grace Rufina Solibun on 2/11/2023.
//

import WidgetKit
import SwiftUI
import Foundation

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ExpenseMLWidgetEntry {
        // Add a print statement before calling loadHardcodedData()
        print("Before calling loadHardcodedData() in placeholder(in:)")

        // Create a placeholder entry with placeholder data
        let placeholderData = loadHardcodedData()
        let placeholderEntry = ExpenseMLWidgetEntry(date: Date(), data: placeholderData)

        // Add a print statement to check the count of placeholderData
        print("Count of placeholderData: \(placeholderData.count)")

        print("After calling loadHardcodedData() in placeholder(in:)")

        for expense in placeholderData {
            print("Category: \(expense.category), Amount: \(expense.amount)")
        }

        return placeholderEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (ExpenseMLWidgetEntry) -> ()) {
        // Load hardcoded data for the snapshot
        let data = loadHardcodedData()
        let entry = ExpenseMLWidgetEntry(date: Date(), data: data)
        print("Snapshot Data for Widget:")
        for expense in data {
            print("Category: \(expense.category), Amount: \(expense.amount)")
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ExpenseMLWidgetEntry>) -> ()) {
        // Load hardcoded data for the timeline
        let data = loadHardcodedData()
        let entry = ExpenseMLWidgetEntry(date: Date(), data: data)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    // Load the hardcoded data from the .plist file
    func loadHardcodedData() -> [Expense] {
        if let path = Bundle.main.path(forResource: "WidgetData", ofType: "plist") {
            print("Plist file found at path: \(path)")
            if let data = FileManager.default.contents(atPath: path) {
                print("Plist data loaded successfully.")
                if let plistData = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                    if let array = plistData["Expenses"] as? [[String: String]] {
                        let expenses = array.map { dict -> Expense in
                            let category = dict["category"] ?? "Unknown"
                            let amount = dict["amount"] ?? "$0"
                            let expense = Expense(category: category, amount: amount)
                            print("Parsed Expense: Category - \(expense.category), Amount - \(expense.amount)")
                            return expense
                        }

                        print("Expenses created from the plist data.")
                        return expenses
                    }
                } else {
                    print("Error: Unable to cast plist data to the expected format.")
                }
            } else {
                print("Error: Unable to read data from the plist file.")
            }
        } else {
            print("Error: Plist file not found in the main bundle.")
        }

        return []
    }

}

struct Expense {
    let category: String
    let amount: String
}

struct ExpenseMLWidgetEntry: TimelineEntry {
    let date: Date
    let data: [Expense]
}

//struct ExpenseMLWidgetEntryView: View {
//    let data: [Expense]
//
//    var body: some View {
//        VStack {
//            Text("Total Spent")
//                .font(.title)
//
//            List(data, id: \.category) { expense in
//                HStack {
//                    Text(expense.category)
//                    Spacer()
//                    Text(expense.amount)
//                }
//            }
//        }
//        .padding()
//    }
//}



//struct ExpenseMLWidgetEntryView: View {
//    let data: [Expense]
//
//    var body: some View {
//        VStack {
//            Text("Total Spent")
//                .font(.title)
//
//            // Use ForEach to iterate over the data and construct the list
//            ForEach(data, id: \.category) { expense in
//                HStack {
//                    Text(expense.category)
//                    Spacer()
//                    Text(expense.amount)
//                }
//            }
//        }
//        .padding()
//        .onAppear {
//            // Add a print statement here to check the content of entry.data
//            print("Entry data contains \(data.count) items:")
//            for expense in data {
//                print("Category: \(expense.category), Amount: \(expense.amount)")
//            }
//        }
//    }
//}



//struct ExpenseMLWidgetEntryView: View {
//    let data: [Expense]
//
//    var body: some View {
//        VStack {
//            Text("Total Spent")
//                .font(.headline)
//                .italic()
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal, 11)
//
//            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
//                ForEach(data, id: \.category) { expense in
//                    VStack {
//                        Text(expense.category)
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Text(expense.amount)
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    .padding(1) // Add padding to individual cells
//                }
//            }
//            .padding(.horizontal, 11) // Add horizontal padding around the LazyVGrid
//        }
//    }
//}



struct ExpenseMLWidgetEntryView: View {
    let data: [Expense]

    var body: some View {
        ZStack {
            Color(red: 1, green: 0.9843, blue: 0.9569)
              .ignoresSafeArea()
            
            VStack {
                Text("Total Spent")
                    .font(.headline)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 11)
                    .foregroundColor(Color.black) // Set the text color to black
                
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                    ForEach(data, id: \.category) { expense in
                        VStack {
                            Text(expense.category)
                                .font(.headline)
                                .foregroundColor(Color(red: 0.9765, green: 0.7176, blue: 0.1059))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(expense.amount)
                                .font(.headline)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(1) // Add padding to individual cells
                    }
                }
                .padding(.horizontal, 11) // Add horizontal padding around the LazyVGrid
            }
        }
    }
}



struct ExpenseMLWidget: Widget {
    let kind: String = "ExpenseMLWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExpenseMLWidgetEntryView(data: entry.data)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
