//
//  ContentView.swift
//  CoreDataBootcamp
//
//  Created by Rabie on 07/02/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: FruiteEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FruiteEntity.name, ascending: true)]) var fruits:FetchedResults<FruiteEntity>
    @State var texiFieldText : String = ""
    

    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                TextField("Add Text Here ...", text: $texiFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .cornerRadius(10)

                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                updateItem(fruite: fruit)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Froots")
            
        
            
        }
    }

    private func addItem() {
        withAnimation {
            let newFruite = FruiteEntity(context: viewContext)
            newFruite.name = texiFieldText
            saveItems()
            texiFieldText = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            
            guard    let index = offsets.first else {return}
            let fruiteEntity = fruits[index]
            viewContext.delete(fruiteEntity)
            

            saveItems()
        }
    }
    
    
    private func updateItem(fruite : FruiteEntity){
        withAnimation {
            
            let currentNAme = fruite.name ?? ""
            let newName = currentNAme + "!"
            fruite.name = newName
            
            saveItems()
        }
    }
    
    
    private func saveItems(){
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
