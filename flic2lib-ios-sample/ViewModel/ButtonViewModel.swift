//
//  ButtonViewModel.swift
//  flic2lib-ios-sample
//
//  Created by 이신원 on 10/15/24.
//

import SwiftUI
import flic2lib
import AudioToolbox

class ViewModel : NSObject, ObservableObject, FLICButtonDelegate, FLICManagerDelegate {
    
    @Published var buttons: [Button] = []
    @Published var promptToRemoveButton: Bool = false
    @Published var buttonToBeRemoved: Button?
    @Published var isScanning: Bool = false
    @Published var scanState: FLICButtonScannerStatusEvent? = nil
    
    @Published var selectedButton: UUID?
    @Published var buttonPressHistory: [UUID: [ButtonPressRecord]] = [:]
    
    enum PressType: String {
        case push
        case doublePush
        case hold
    }
    
    struct ButtonPressRecord {
        let pressType: PressType
        let timestamp: Date
    }
    
    struct Button {
        let identifier: UUID
        var name: String?
        var emoji: String = "🔘"
        var pushed: Bool = false
        var connected: Bool = false
        var batteryVoltage: Float?
        
        init(_ flicButton: FLICButton) {
            self.identifier = flicButton.identifier
            self.name = flicButton.name
            self.connected = flicButton.state == .connected
        }
        
        init(identifier: UUID, name: String?) {
            self.identifier = identifier
            self.name = name
        }
    }
    
    override convenience init() {
        self.init(preview: false)
    }
    
    init(preview: Bool) {
        super.init()
        if (!preview) {
            FLICManager.configure(with:self, buttonDelegate: self, background: true)
        }
        if let firstButton = buttons.first {
            self.selectedButton = firstButton.identifier
        }
    }
    
    func getSelectedButton() -> Button? {
        return buttons.first(where: { $0.identifier == selectedButton })
    }

    func buttonDidConnect(_ flicButton: FLICButton) {
        print("buttonDidConnect")
        if let index = indexOf(flicButton) {
            buttons[index].connected = true
        }
    }
    
    func buttonIsReady(_ button: FLICButton) {
        print("buttonIsReady")
        reloadButtons()
    }
    
    func button(_ flicButton: FLICButton, didDisconnectWithError error: Error?) {
        print("didDisconnectWithError", error ?? "")
        if let index = indexOf(flicButton) {
            buttons[index].connected = false
        }
    }
    
    func button(_ button: FLICButton, didFailToConnectWithError error: Error?) {
        print("didFailToConnectWithError", error ?? "")
    }
    
    func managerDidRestoreState(_ manager: FLICManager) {
        print("managerDidRestoreState")
        reloadButtons()
    }
    
    func manager(_ manager: FLICManager, didUpdate state: FLICManagerState) {
        print("managerDidUpdate")
    }
    
    func button(_ flicButton: FLICButton, didReceiveButtonDown queued: Bool, age: Int) {
        print("didReceiveButtonDown")
        if let index = indexOf(flicButton) {
            buttons[index].pushed = true
 
            if UserDefaults.standard.bool(forKey: "isVibrationEnabled") {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            
        }
    }
    
    func button(_ flicButton: FLICButton, didReceiveButtonDoubleClick queued: Bool, age: Int) {
        print("didReceiveButtonDoubleClick")
        if let index = indexOf(flicButton) {
            let button = buttons[index]
            let pressRecord = ButtonPressRecord(pressType: .doublePush, timestamp: Date())
            buttonPressHistory[button.identifier, default: []].append(pressRecord)
        }
    }
    
    func button(_ flicButton: FLICButton, didReceiveButtonHold queued: Bool, age: Int) {
        print("didReceiveButtonHold")
        if let index = indexOf(flicButton) {
            let button = buttons[index]
            let pressRecord = ButtonPressRecord(pressType: .hold, timestamp: Date())
            buttonPressHistory[button.identifier, default: []].append(pressRecord)
        }
    }
    
    func button(_ flicButton: FLICButton, didReceiveButtonClick queued: Bool, age: Int) {
        print("didReceiveButtonClick")
        if let index = indexOf(flicButton) {
            let button = buttons[index]
            let pressRecord = ButtonPressRecord(pressType: .push, timestamp: Date())
            buttonPressHistory[button.identifier, default: []].append(pressRecord)
        }
    }

    
    func button(_ flicButton: FLICButton, didReceiveButtonUp queued: Bool, age: Int) {
        print("didReceiveButtonUp")
        if let index = indexOf(flicButton) {
            buttons[index].pushed = false
        }
    }
    
    func button(_ flicButton: FLICButton, didUpdateBatteryVoltage voltage: Float) {
        if let index = indexOf(flicButton) {
            buttons[index].batteryVoltage = voltage
        }
    }
    
    func button(_ flicButton: FLICButton, didUpdateNickname nickname: String) {
        
    }
    
    func indexOf(_ flicButton: FLICButton) -> Int?{
        for (i, button) in self.buttons.enumerated() {
            if button.identifier == flicButton.identifier {
                return i
            }
        }
        return nil
    }
    
    func getButton(uuid: UUID) -> Button? {
        for button in self.buttons {
            if button.identifier == uuid {
                return button
            }
        }
        return nil
    }
    
    func reloadButtons() {
        DispatchQueue.main.async {
            var buttons: [Button] = []
            if let manager = FLICManager.shared() {
                for flicButton in manager.buttons() {
                    buttons.append(Button(flicButton))
                }
            }
            self.buttons = buttons
        }
    }

    
    func removeButton(_ button: ViewModel.Button) {
        if let flicButton = FLICManager.shared()?.buttons().first(where: { $0.identifier == button.identifier }) {
            Task {
                defer {
                    reloadButtons()
                }
                
                do {
                    try await FLICManager.shared()?.forgetButton(flicButton)
                }
            }
        }
    }
    
    func scan() {
        scanState = nil
        isScanning = true
        FLICManager.shared()?.scanForButtons(stateChangeHandler: { event in
            print(event);
            self.scanState = event
        }, completion: { button, error in
            self.isScanning = false
        })
    }
}
