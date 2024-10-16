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
    
    @State private var sortingOption: SortingOption = .newest

        enum SortingOption: String, CaseIterable {
            case newest = "최신순"
            case oldest = "오래된순"
        }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemGray6))
                    .frame(height: 100)
                
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(UIColor.systemBackground))
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
            .padding(.bottom)
            
//            HStack {
//                Button(action: {
//                    showDatePicker = true
//                    
//                }) {
//                    Text(dateFormatter.string(from: selectedDate))
//                }
//                
//                Spacer()
//                
//                
//                Button(action: {
//                    
//                    
//                }) {
//                    Text("최신순")
//                        .foregroundColor(.gray)
//                    
//                }
//                
//                Text("|")
//                Button(action: {
//                    
//                    
//                }) {
//                    Text("최신순")
//                        .foregroundColor(.black)
//                    
//                }
//
                
                
//                Picker("정렬 기준", selection: $sortingOption) {
//                    ForEach(SortingOption.allCases, id: \.self) { option in
//                        Text(option.rawValue)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle()) // 세그먼트 컨트롤 스타일
//                .frame(width: 200)
//                .padding(.vertical)
     
//            }
            
            LogList()
           
            
            
            Spacer()
            
            
            
        }
        .padding()
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
