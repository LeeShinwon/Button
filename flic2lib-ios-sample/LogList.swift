//
//  LogList.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/16/24.
//

import SwiftUI

struct LogList: View {
    var body: some View {
        VStack {
            HStack {
                PushButton()
                
                Text("시작")
                
                Spacer()
                
                Text("오전 10:16")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                DoublePushButton()
                
                Text("골인")
                
                Spacer()
                
                Text("오전 11:34")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            HStack {
                HoldButton()
                
                Text("끝")
                
                Spacer()
                
                Text("오후 07:04")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            HStack {
                PushButton()
                
                Text("시작")
                
                Spacer()
                
                Text("오전 10:16")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            HStack {
                DoublePushButton()
                
                Text("골인")
                
                Spacer()
                
                Text("오전 11:34")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            HStack {
                HoldButton()
                
                Text("끝")
                
                Spacer()
                
                Text("오후 07:04")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    LogList()
}
