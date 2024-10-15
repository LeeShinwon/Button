//
//  ContentView.swift
//  flic2lib-ios-sample
//
//  Created by Oskar Öberg on 2024-02-09.
//

import SwiftUI
import BottomSheet

struct ContentView: View {

    @State private var selection: Tab = .log
    
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.5)
    
    @StateObject var viewModel = ViewModel()

    
    enum Tab {
        case log
        case settings
    }
	
	var body: some View {
        
        NavigationStack {
            TabView(selection: $selection) {
                Group {
                    NavigationView {
                        VStack {
                            Log()
                        }
                        
                    }
                    .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [.relative(0.2), .relative(0.5), .relativeTop(0.95)], headerContent: {
                        HStack {
                            Text("버튼")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            NavigationLink(destination: AddButton()) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            
                        }
                        .padding()
                    }) {
//                        Divider()
                        ButtonList()
                    }
//                    .customBackground(Color.white.cornerRadius(20))
                    .tabItem {
                        Label("로그", systemImage: "button.programmable")
                    }
                    
                    
                    
                    NavigationView {
                        Settings()
                    }
                    .tabItem {
                        Label("설정", systemImage: "gearshape")
                    }
                }
//                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                
            }

        }.environmentObject(viewModel)
        
        // for the preview
	}
}

#Preview {
	ContentView()
    
}

