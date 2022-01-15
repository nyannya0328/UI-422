//
//  ContentView.swift
//  UI-422
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View{
        
        
        Home()
        
    }
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func hLleading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    
    func hLTrailing()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    
    
    func hCenter()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .center)
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            
            return .zero
        }
        
          return safeArea
    }
}
