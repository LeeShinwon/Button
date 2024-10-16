//
//  ButtonIcon.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/16/24.
//

import SwiftUI

struct PushButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(UIColor.systemGray6))
                .frame(width: 40, height: 40)
            Circle()
                .fill(Color.gray)
                .frame(width: 10, height: 10)
        }
    }
}

struct DoublePushButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(UIColor.systemGray6))
                .frame(width: 40, height: 40)
            
            HStack(spacing: 5) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 10, height: 10)
                
                Circle()
                    .fill(Color.gray)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

struct HoldButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(UIColor.systemGray6))
                .frame(width: 40, height: 40)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray)
                .frame(width: 20, height: 10)
        }
    }
}
