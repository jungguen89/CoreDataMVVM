//
//  ContentView.swift
//  CoreDataMVVM
//
//  Created by 권정근 on 2023/03/25.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntites: [FruitEntity] = []
    
    init()
    {
        container = NSPersistentContainer(name: "FruitsContainer")
        // coredata 호출
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
             
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntites = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            // 뷰 관찰을 위해 가져오기 설정
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
}

struct ContentView: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here....", text:$textFieldText )
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.red.opacity(0.33))
                    .cornerRadius(10)
                
                Button( action: {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                }, label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.33))
                        .cornerRadius(10)
                        
                })
                
                List {
                    ForEach(vm.savedEntites) { entity in
                        Text(entity.name ?? "No Name")
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Fruits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
