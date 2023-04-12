//
//  AddFoodView.swift
//  UIExample
//
//  Created by İbrahim Aktaş on 12.04.2023.
//

import SwiftUI

struct AddFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    // var olan sayfayı kapatıp main sayfaya döndürür :?
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var calories: Double = 0
    var body: some View {
        Form{
            Section{
                TextField("Food Name", text: $name)
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }.padding()
                
                HStack{
                    Button("Submit"){
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
