//
//  ButtonBattery.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/16/24.
//

import SwiftUI

struct ButtonBattery: View {
    var batteryVoltage: Float
    var buttonConnected: Bool
        
    var batteryPercentage: Int {
        switch batteryVoltage {
            case 3.0...3.2:
                return 100
            case 2.7..<3.0:
                return 75
            case 2.4..<2.7:
                return 50
            case 2.1..<2.4:
                return 25
            default:
                return 0
        }
    }
    
    var batteryIconName: String {
        switch batteryPercentage {
            case 100:
                return "battery.100"
            case 75:
                return "battery.75"
            case 50:
                return "battery.50"
            case 25:
                return "battery.25"
            default:
                return "battery.0"
        }
    }
    
    var batteryIconColor: Color {
        switch batteryPercentage {
            case 100:
                return .green
            case 75:
                return .green
            case 50:
                return .yellow
            case 25:
                return .red
            default:
                return .red
        }

    }
    
    var body: some View {
        ZStack {
            Image(systemName: batteryIconName)
                .foregroundColor(buttonConnected ? batteryIconColor : .gray)
//            Text("\(batteryPercentage)")
//                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ButtonBattery(batteryVoltage: 3.1, buttonConnected: true)
}
