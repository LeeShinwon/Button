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
    
    @State private var selectedDate: Date = Date()
    @State private var showDatePicker = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemGray6))
                    .frame(height: 100)
                
                if let selectedButton = viewModel.getSelectedButton() {
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .overlay(
                                Text(selectedButton.emoji)
                                    .font(.title)
                            )
                            .overlay(
                                Circle()
                                    .stroke(.gray.opacity(0.2), lineWidth: 2)
                            )
                        Text(selectedButton.name ?? "\(selectedButton.identifier)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(selectedButton.connected ? "연결됨" : "연결안됨")
                            .foregroundColor(.gray)
                    
                    }
                    .padding()
                }
                
            }
            .padding(.vertical)
        
            
            LogList(selectedDate: $selectedDate)
           
            
            
            Spacer(minLength: UIScreen.main.bounds.height * 0.1)
            
            
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(action: {
                    showDatePicker = true
                    
                }) {
                    Text(dateFormatter.string(from: selectedDate))
                }
            }

        }
        .sheet(isPresented: $showDatePicker) {
                        if #available(iOS 16.0, *) {
                            DatePicker("날짜 선택", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle()) // iOS 16에서 지원
                                .padding()
                                .presentationDetents([.fraction(0.5)])
                                .onChange(of: selectedDate) { _ in
                                                            showDatePicker = false // 날짜 선택 시 sheet 닫기
                                                        }// iOS 16 이상에서만 사용
                        } else {
                            // iOS 15 이하에서는 대체 UI 제공
                            VStack {
                                DatePicker("날짜 선택", selection: $selectedDate, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                    .onChange(of: selectedDate) { _ in
                                                                showDatePicker = false // 날짜 선택 시 sheet 닫기
                                                            }
                                
                                Button("확인") {
                                    showDatePicker = false
                                }
                                .padding()
                            }
                        }
                    }
        
        
        
    }
}
//
//#Preview {
//    let viewModel = ViewModel(preview: true)
//    return Log()
//        .environmentObject(viewModel)
//}


#Preview {
    let viewModel = ViewModel(preview: true)
    viewModel.buttons = [
        ViewModel.Button(identifier: UUID(), name: "My First Flic"),
        ViewModel.Button(identifier: UUID(), name: "My Second Flic")
    ]
    return Log()
        .environmentObject(viewModel)
}
