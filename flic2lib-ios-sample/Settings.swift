//
//  Settings.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/14/24.
//

import SwiftUI
import StoreKit

struct Settings: View {
    
    @AppStorage("isVibrationEnabled") private var isVibrationEnabled: Bool = true
    @AppStorage("isDarkMode") private var isDarkMode: Bool = UIScreen.main.traitCollection.userInterfaceStyle == .dark

    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    var appBuild: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    var body: some View {
        VStack(alignment: .leading) {

//            언어 설정
//            데이터
            
            Toggle(isOn: $isVibrationEnabled) {
                Text("진동 활성화")
            }
            
            Divider()
            
            Toggle(isOn: $isDarkMode) {
                Text("다크 모드 활성화")
            }
            
            Divider()
            
            Button(action: {
                
            }) {
                Text("앱 초기화하기")
                    
            }
            
            Divider()
            
            Button(action: {
                requestReview()
            }) {
                Text("앱 평가하기")
                    
            }
            
            Divider()
            
            HStack {
                Text("버전 정보")
                Spacer()
                Text("\(appVersion)")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
}

#Preview {
    Settings()
}
