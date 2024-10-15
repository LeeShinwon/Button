//
//  Log.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/14/24.
//

import SwiftUI
import flic2lib


struct Log: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var bottomSheetOffset: CGFloat = UIScreen.main.bounds.height*0.8
    
    var body: some View {
        
        ZStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.05))
                        .frame(height: 100)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 5, y: 5)
                    
                    
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .overlay(
                                Text("🏀")
                                    .font(.title)
                            )
                            .overlay(
                                Circle()
                                    .stroke(.gray.opacity(0.2), lineWidth: 2)
                            )
                        Text("농구")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("연결됨")
                            .foregroundColor(.gray)
                    
                        
                    }
                    .padding()
                }
                .padding()
                
                Spacer()
                
                
                
            }
            
                        
        }
        
    }
}

#Preview {
    let viewModel = ViewModel(preview: true)
    return Log()
        .environmentObject(viewModel)
}


#Preview {
    let viewModel = ViewModel(preview: true)
    viewModel.buttons = [
        ViewModel.Button(identifier: UUID(), name: "My First Flic"),
        ViewModel.Button(identifier: UUID(), name: "My Second Flic")
    ]
    return Log()
        .environmentObject(viewModel)
}
