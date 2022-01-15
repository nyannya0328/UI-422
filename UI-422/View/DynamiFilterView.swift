//
//  DynamiFilterView.swift
//  UI-422
//
//  Created by nyannyan0328 on 2022/01/15.
//

import SwiftUI
import CoreData

struct DynamiFilterView<Content : View,T>: View  where T : NSManagedObject{
    
    
    @FetchRequest var request : FetchedResults<T>
    
    let content : (T) -> Content
    
    
    
    
    
    init(dateFilterd : Date,@ViewBuilder content : @escaping(T) -> Content) {
        
        
        let calender = Calendar.current
        let today = calender.startOfDay(for: dateFilterd)
        
        let tommorrow = calender.date(byAdding: .day, value: 1, to: today)!
        
        let filterKey = "taskDate"
        
        
        let predicate = NSPredicate(format: "\(filterKey) >= %@ And \(filterKey) < %@",argumentArray: [today,tommorrow])
        
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        
        self.content = content
    }
    
    
    
    var body: some View {
        Group{
            
            
            if request.isEmpty{
                
                
                Text("Not Found")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.black)
            }
            else{
                
                
                ForEach(request,id:\.objectID){object in
                    
                    
                    content(object)
                }
                
                
            }
            
            
        }
    }
}

