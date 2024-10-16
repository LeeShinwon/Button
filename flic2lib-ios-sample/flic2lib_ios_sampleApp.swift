//
//  flic2lib_ios_sampleApp.swift
//  flic2lib-ios-sample
//
//  Created by Oskar Öberg on 2024-02-09.
//

import SwiftUI

@main
struct flic2lib_ios_sampleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = UIScreen.main.traitCollection.userInterfaceStyle == .dark

    init() {
            registerDefaultSettings()
        }
    
	var body: some Scene {
		WindowGroup {
			ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
    
		}
	}
    
    func registerDefaultSettings() {
        let defaults: [String: Any] = [
            "isVibrationEnabled": true, // 진동 기본값을 true로 설정
        ]
        UserDefaults.standard.register(defaults: defaults)
    }
}
