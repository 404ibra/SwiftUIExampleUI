//
//  ContentView.swift
//  UIExample
//
//  Created by İbrahim Aktaş on 12.04.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)])
    var food: FetchedResults<Food>
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) Kcal (Today)").foregroundColor(.gray).padding(.horizontal)
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: Text("\(food.calories)")) {
                            HStack{
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!).bold()
                                    Text("\(Int(food.calories))") + Text("calories").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcTimeSince(date: food.date!)).foregroundColor(.gray).italic()
                            }
                        }
                        
                    }.onDelete(perform: deleteFood)
                }.listStyle(.plain)
            }.navigationTitle("iCalories")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddView.toggle()
                        }label: {
                            Label("Add Food", systemImage:  "plus.circle")
                        }
                    }; ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddFoodView()
                }
            
        }.navigationViewStyle(.stack)
    }
    
    private func deleteFood(offSets: IndexSet) {
        withAnimation {
            offSets.map {
                food[$0]
            }.forEach(managedObjectContext.delete)
            DataController().save(context: managedObjectContext)
        }
    }
    
    private func totalCaloriesToday() -> Double{
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday +=  item.calories
            }
        }
        
        return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


/*
 
 @Environment(\.managedObjectContext) private var viewContext

 @FetchRequest(
     sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
     animation: .default)
 private var items: FetchedResults<Item>
 
 
 */
