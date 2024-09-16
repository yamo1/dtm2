//
//  MainTab.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/06.
//

import SwiftUI

struct MainTab: View {
    
    @State private var selection = 3
    
    var body: some View {
        TabView(selection: $selection) {
            DoubleDatesView()
                .tabItem {
                    Image(selection == 1 ? "Two Heads_Red" : "Two_Heads")
                        .font(.system(size: 24, weight: .medium))
                        .frame(width: 26.01877, height: 24)
                }
                .tag(1)
            
            TonightView()
                .tabItem {
                    Image(selection == 2 ? "Coctail_Red" : "Cocktail")
                        .font(.system(size: 24, weight: .medium))
                        .frame(width: 26.01877, height: 24)
                        .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                }
                .tag(2)
            
            DownToMeetView()
                .tabItem {
                    Image(selection == 3 ? "Loveheart_Red" : "Loveheart")
                        .font(.system(size: 24, weight: .medium))
                        .frame(width: 26.01877, height: 24)
                        .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                }
                .tag(3)
            
            YourMeetUpsView()
                .tabItem {
                    Image(selection == 4 ? "Events_Red" : "Events")
                        .font(.system(size: 24, weight: .medium))
                        .frame(width: 26.01877, height: 24)
                        .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                }
                .tag(4)
        }
        .accentColor(Color(red: 0.89, green: 0.17, blue: 0.3))
    }
}

#Preview {
    MainTab()
}
