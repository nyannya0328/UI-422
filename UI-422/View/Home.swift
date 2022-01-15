//
//  Home.swift
//  UI-422
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI

struct Home: View {
    @StateObject var moldel = TaskViewModel()
    @Namespace var animation
    @Environment(\.managedObjectContext) var context
    
    @Environment(\.editMode) var editeButton
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Section {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(alignment:.top,spacing: 20){
                        
                        
                        ForEach(moldel.currentWeek,id:\.self){day in
                            
                            
                            
                            VStack(spacing:15){
                                
                                Text(moldel.exTractDate(date: day, formatt: "dd"))
                                    .font(.system(size: 10, weight: .light))
                                
                                
                                Text(moldel.exTractDate(date: day, formatt: "EEE"))
                                    .font(.system(size: 10, weight: .light))
                                
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 10, height: 10)
                                    .opacity(moldel.isToday(date: day) ? 1 : 0)
                            }
                            .foregroundStyle(moldel.isToday(date: day) ? .primary : .tertiary)
                            .foregroundColor(moldel.isToday(date: day) ? .white : .black)
                            .frame(width: 30, height: 90)
                            .background(
                            
                            
                                ZStack{
                                    
                                    
                                    if moldel.isToday(date: day){
                                        
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "TODAY", in: animation)
                                        
                                        
                                    }
                                }
                            
                            )
                            .onTapGesture {
                                
                                withAnimation{
                                    
                                    
                                    moldel.currentDay = day
                                }
                            }
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    
                }
                
                
                
               TaskView()
                
                
                
            } header: {
                
                
                HeaderView()
                
            }

            
            
        }
        .overlay(
        
            
            Button(action: {
                
                moldel.addNewTask.toggle()
                
            }, label: {
                
                Image(systemName: "plus")
                    .font(.title)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.black,in:Circle())
                
                
                
            })
                .padding(.trailing,10)
        
            ,alignment: .bottomTrailing
        
        )
        .sheet(isPresented:$moldel.addNewTask) {
            
            
            moldel.editTask = nil
            
        } content: {
            
            AddNewView()
                .environmentObject(moldel)
        }

    }
    
    func TaskCardView(task : Task)->some View{
        
        HStack(alignment:editeButton?.wrappedValue == .active ? .center : .top,spacing: 10){
            
            if editeButton?.wrappedValue == .active{
                
                
                
                
                
                
                VStack{
                    
                    
                    if task.taskDate?.compare(Date()) == .orderedAscending || Calendar.current.isDateInToday(task.taskDate ?? Date()){
                        
                        
                        Button {
                            
                            
                            moldel.editTask = task
                            moldel.addNewTask.toggle()
                            
                            
                            
                        } label: {
                            
                            
                            Image(systemName: "pencil.circle.fill")
                                .font(.title.bold())
                                .padding(3)
                                .foregroundColor(.primary)
                        }
                        
                        Button {
                            context.delete(task)
                            try? context.save()
                            
                         
                            
                        } label: {
                            
                            
                            Image(systemName: "minus.circle.fill")
                                .font(.title.bold())
                                .padding(3)
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                    
                  

                }
                
            }
            
            else{
                
                VStack(spacing:10){
                    
                    
                    Circle()
                        .fill(moldel.isCurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
                        .frame(width: 15, height: 15)
                        .background(
                        
                        
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                           
                        
                        
                        )
                        .scaleEffect(moldel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
                    
             
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 3)
                    
                }
                
                
                
            }
            
            
            
          
                
                
                VStack{
                    
                    
                    HStack(alignment: .top, spacing: 10) {
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(task.taskTitle ?? "")
                                .font(.title.bold())
                            
                            Text(task.taskDecription ?? "")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            
                        }
                        .hLleading()
                        
                        
                        Text(task.taskDate?.formatted(date: .abbreviated, time: .omitted) ?? "")
                        
                        
                    }
                    
                    if moldel.isCurrentHour(date: task.taskDate ?? Date()){
                        
                        
                        HStack(spacing:10){
                            
                            
                            if !task.isCompleted{
                                
                                
                                Button {
                                    
                                    task.isCompleted = true
                                    
                                    try? context.save()
                                    
                                } label: {
                                    
                                    
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Color.white,in: RoundedRectangle(cornerRadius: 10))
                                }

                                
                                
                            }
                            
                            
                            Text(task.isCompleted ? "Marked as Completed" : "Mark Task as Completed")
                                .font(.system(size: task.isCompleted ? 14 : 16, weight: .light))
                                .foregroundColor(task.isCompleted ? .gray : .white)
                                .hLleading()
                            
                            
                            
                            
                            
                        }
                        .padding(.top)
                        
                        
                        
                    }
                    
                    
                }
            
            
                
                
                
                
                
                
                
            
            
            
            
        }
        
        
    }
    
    func TaskView()->some View{
        
        LazyVStack(spacing:10){
            
            
            
            DynamiFilterView(dateFilterd: moldel.currentDay) { (object : Task) in
                
                
                TaskCardView(task: object)
                
                
            }
            
            
            
            
        }
        .padding()
        .padding(.top,10)
    }
    
    func HeaderView()->some View{
        
        
        HStack{
            
            
            VStack(spacing:20){
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.title3)
                    .fontWeight(.bold)
                
                
                Text("Today")
                    .font(.title3.weight(.black))
                    .foregroundColor(.black)
                
            }
            .hLleading()
            
            
            
            EditButton()
        }
        .padding()
        .background(Color.white)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
