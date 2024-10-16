//
//  ButtonList.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/14/24.
//

import SwiftUI

struct ButtonList: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if (viewModel.buttons.count == 0) {
            VStack {
                Spacer()
                Text("연결된 버튼이 없습니다.").foregroundColor(.gray)
                Spacer()
                Spacer()
            }
        } else {
            
            List(viewModel.buttons, id:\.identifier) { button in
                let color: Color = button.pushed ? .blue : button.connected ? .green : .yellow
                
                let connection = button.pushed ? "눌림" : button.connected ? "연결됨" : "연결 안됨"
                HStack{
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .overlay(
                            Text("🏀")
//                                .font(.title3)
                        )
                        .overlay(
                            Circle()
                                .stroke(.gray.opacity(0.2), lineWidth: 2)
                        )
                    
                    Text(button.name ?? "My Flic")
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(color)
                    Text(connection)
                        .foregroundColor(.gray)
                }
                .listRowBackground(Color.clear)
                .padding(5)
                
                .onTapGesture {
                    viewModel.buttonToBeRemoved = button
                    viewModel.promptToRemoveButton = true
                }
                
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            .alert(isPresented: $viewModel.promptToRemoveButton) {
                Alert(title: Text("Remove"), message: Text("Do you want to remove this button?"), primaryButton: .destructive(Text("Remove")) {
                    if let buttonToBeRemoved = viewModel.buttonToBeRemoved {
                        viewModel.removeButton(buttonToBeRemoved)
                    }
                }, secondaryButton: .default(Text("Cancel")))
            }
        }
    }
}
//
//#Preview {
//    let viewModel = ViewModel(preview: true)
//    return ButtonList()
//        .environmentObject(viewModel)
//    
//}

#Preview {
    let viewModel = ViewModel(preview: true)
    viewModel.buttons = [
        ViewModel.Button(identifier: UUID(), name: "My First Flic"),
        ViewModel.Button(identifier: UUID(), name: "My Second Flic")
    ]
    return ButtonList()
        .environmentObject(viewModel)
}
