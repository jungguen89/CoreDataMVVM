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
    
    init()
    {
        container = NSPersistentContainer(name: "FruitsContainer")
        // coredata 호출
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
             
        }
    }
}

struct ContentView: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("This is for the github")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
