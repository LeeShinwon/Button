//
//  AddButton.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/15/24.
//

import SwiftUI
import flic2lib

struct AddButton: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            if (viewModel.buttons.count == 0) {
                HStack {
                    Spacer()
                    Text("연결된 버튼이 없습니다.").foregroundColor(.gray)
                    Spacer()
                }
            } else {
                let button = viewModel.buttons.last!

                HStack{
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                        .overlay(
                            Text("🏀")
                                .font(.title)
                        )
                        .overlay(
                            Circle()
                                .stroke(.gray.opacity(0.2), lineWidth: 2)
                        )
                    
                    Text(button.name ?? "My Flic")
                    
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.buttonToBeRemoved = button
                            viewModel.promptToRemoveButton = true
                        }
                }
                
                .alert(isPresented: $viewModel.promptToRemoveButton) {
                    Alert(title: Text("Remove"), message: Text("Do you want to remove this button?"), primaryButton: .destructive(Text("Remove")) {
                        if let buttonToBeRemoved = viewModel.buttonToBeRemoved {
                            viewModel.removeButton(buttonToBeRemoved)
                        }
                    }, secondaryButton: .default(Text("Cancel")))
                }
            }
            
            Spacer()
            
            VStack {
                if viewModel.isScanning {
                    HStack {
                        Text([
                            FLICButtonScannerStatusEvent.discovered: "Discovered",
                            FLICButtonScannerStatusEvent.connected: "Connected",
                            FLICButtonScannerStatusEvent.verified: "Verified",
                            FLICButtonScannerStatusEvent.verificationFailed: "Verification failed",
                        ][viewModel.scanState] ?? "Looking for buttons")
                        Spacer().frame(width: 5)
                        ProgressView()
                    }
                } else {
                    Button(action: {
                        print("start scan");
                        viewModel.scan()
                    }) {
                        Text("Add Flic")
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.blue)
                            .frame(width: 20)
                    }
                }
            }.padding(20)
        }
    }
}

//#Preview {
//    return AddButton()
//        .environmentObject(ViewModel())
//}


#Preview {
    let viewModel = ViewModel(preview: true)
    viewModel.buttons = [
        ViewModel.Button(identifier: UUID(), name: "My First Flic"),
        ViewModel.Button(identifier: UUID(), name: "My Second Flic")
    ]
    return AddButton()
        .environmentObject(viewModel)
}
