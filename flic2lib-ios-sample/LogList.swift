//
//  LogList.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/16/24.
//

import SwiftUI

struct LogList: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var selectedDate: Date
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        return formatter
    }
    
    func buttonIcon(_ type: PressType) -> some View {
        switch type {
        case .push:
            return AnyView(PushButton())
        case .doublePush:
            return AnyView(DoublePushButton())
        case .hold:
            return AnyView(HoldButton())
        }
    }

    func isSameDay(_ date1: Date, as date2: Date) -> Bool {
            let calendar = Calendar.current
            return calendar.isDate(date1, inSameDayAs: date2)
        }
    
    
    var body: some View {
        VStack {
            List(viewModel.getSelectedButtonHistory().filter { log in
                return isSameDay(log.timestamp, as: selectedDate)
            }) { log in
                HStack {
                    buttonIcon(log.pressType)
                    Text(log.pressType.rawValue.capitalized)
                    Spacer()
                    Text("\(log.timestamp, formatter: dateFormatter)")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.gray)
                        .onTapGesture {
                            
                        }
                        
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
            
        }
    }
}

//#Preview {
//    LogList()
//}
