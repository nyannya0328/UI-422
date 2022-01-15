//
//  AddNewView.swift
//  UI-422
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI
import CoreData

struct AddNewView: View {
    
    @State var taskTitle : String = ""
    
    @State var taskDescription : String = ""
    
    
    @State var taskDate : Date = Date()
    
    
    @Environment(\.dismiss) var dissmiss
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var model : TaskViewModel
    var body: some View {
        NavigationView{
            
            
            
            List{
                
                Section {
                    
                    TextField("Enter Task", text: $taskTitle)
                    
                } header: {
                    
                    Text("Go to  Work")
                        .font(.callout)
                }
                
                Section {
                    
                    TextField("Nothing", text: $taskDescription)
                    
                } header: {
                    
                    Text("Description")
                        .font(.callout)
                }
                
                
                if model.editTask == nil{
                    
                    
                    Section {
                        
                        
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                        
                        
                
                        
                        
                    } header: {
                        
                        Text("Date")
                            .font(.callout)
                    }
                    
                    
                    
                    
                }
                
                
                

                
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Add New Task")
            .interactiveDismissDisabled()
            .toolbar {
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        
                        if let task = model.editTask{
                            
                            
                            task.taskTitle = taskTitle
                            task.taskDecription = taskDescription
                        }
                        
                        else{
                            
                            
                            let task = Task(context: context)
                            task.taskTitle = taskTitle
                            task.taskDecription = taskDescription
                            task.taskDate = taskDate
                            
                            
                            
                            
                            
                        
                            
                        }
                        
                        
                        try? context.save()
                        dissmiss()
                        
                        
                    } label: {
                        
                        
                        Text("Save")
                            .font(.callout.bold())
                            .foregroundColor(.black)
                    }
                    .disabled(taskTitle == "" || taskDescription == "")

                    
                    
                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        
                        withAnimation{
                            
                            dissmiss()
                        }
                        
                    } label: {
                        
                        
                        Text("Cancel")
                            .font(.callout.bold())
                            .foregroundColor(.black)
                    }

                    
                    
                }
            
                
                
              
                
             
            }
            .onAppear {
                
                if let task = model.editTask{
                    
                    
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDecription ?? ""
                    
                }
                
            }
            
            
        }
    }
}

struct AddNewView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewView()
    }
}
