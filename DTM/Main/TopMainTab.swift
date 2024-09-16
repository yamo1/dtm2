//
//  MainTab.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/06.
//

import SwiftUI
var myProfile: UserProfile?

struct TopMainTab: View {
    
    @Binding var selection: Int
    @State private var isMatch = false
    @State private var isMatching = false
    
    @State var matchingData = [String: Any]()
    @State var withWho = ""
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selection) {
                TopDoubleDatesView(data: $matchingData, withWho: $withWho)
                    .tabItem {
                        Image(selection == 1 ? "Two Heads_Red" : "Two_Heads")
                            .font(.system(size: 24, weight: .medium))
                            .frame(width: 26.01877, height: 24)
                    }
                    .tag(1)
                    .task {
                        Task {
                            do {
                                try await fetchMatching(to: userName) { database in
                                    if let data = database {
                                        matchingData = data
                                        let fieldNames = Array(data.keys) // フィールド名を取得
                                        withWho = fieldNames[0]
                                        if !fieldNames.isEmpty {
                                            isMatching = true
                                        } else {
                                            isMatching = false
                                        }
                                        
                                        for fieldName in fieldNames {
                                            if let fromArray = data[fieldName] as? [Any] {
                                            }
                                        }
                                    }
                                }
                            } catch {
                                print("Failed to fetch data: \(error)")
                            }
                        }
                    }
                
                TopTonightview()
                    .tabItem {
                        Image(selection == 2 ? "Coctail_Red" : "Cocktail")
                            .font(.system(size: 24, weight: .medium))
                            .frame(width: 26.01877, height: 24)
                            .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                    }
                    .tag(2)
                
                
                if isMatch {
                    TopDownGet(isMatch: $isMatch)
                        .tabItem {
                            Image(selection == 3 ? "Loveheart_Red" : "Loveheart")
                                .font(.system(size: 24, weight: .medium))
                                .frame(width: 26.01877, height: 24)
                                .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                        }
                        .tag(3)
                        .onAppear {
                            searchMatch(to: userName) { database in
                                if let data = database {
                                    let fieldNames = Array(data.keys) // フィールド名を取得
                                    print("Field names: \(fieldNames)")
                                    if !fieldNames.isEmpty {
                                        isMatch = true
                                    } else {
                                        isMatch = false
                                    }
                                    
                                    for fieldName in fieldNames {
                                        if let fromArray = data[fieldName] as? [Any] {
                                            let firstElement = fromArray[0]
                                            print("First element: \(firstElement)")
                                        }
                                    }
                                }
                            }
                        }
                } else {
                    TopDowntomeet()
                        .tabItem {
                            Image(selection == 3 ? "Loveheart_Red" : "Loveheart")
                                .font(.system(size: 24, weight: .medium))
                                .frame(width: 26.01877, height: 24)
                                .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                        }
                        .tag(3)
                        .onAppear {
                            searchMatch(to: userName) { database in
                                if let data = database {
                                    let fieldNames = Array(data.keys) // フィールド名を取得
                                    print("Field names: \(fieldNames)")
                                    if fieldNames != [] {
                                        isMatch = true
                                    } else {
                                        isMatch = false
                                    }
                                    
                                    for fieldName in fieldNames {
                                        if let fromArray = data[fieldName] as? [Any] {
                                            // "from" フィールドの配列から特定の要素にアクセス
                                            let firstElement = fromArray[0] // Monday Aug 5th 0:0
                                            // let lastElement = fromArray[4] // McGill University
                                            
                                            print("First element: \(firstElement)")
                                            // print("Last element: \(lastElement)")
                                        }
                                    }
                                }
                            }
                        }
                }
                
                if isMatching {
                    WaitMatchView(data: $matchingData, withWho: $withWho)
                        .tabItem {
                            Image(selection == 4 ? "Events_Red" : "Events")
                                .font(.system(size: 24, weight: .medium))
                                .frame(width: 26.01877, height: 24)
                                .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                        }
                        .tag(4)
                        .task {
                            Task {
                                do {
                                    try await fetchMatching(to: userName) { database in
                                        if let data = database {
                                            matchingData = data
                                            let fieldNames = Array(data.keys) // フィールド名を取得
                                            withWho = fieldNames[0]
                                            if !fieldNames.isEmpty {
                                                isMatching = true
                                            } else {
                                                isMatching = false
                                            }
                                            
                                            for fieldName in fieldNames {
                                                if let fromArray = data[fieldName] as? [Any] {
                                                }
                                            }
                                        }
                                    }
                                } catch {
                                    print("Failed to fetch data: \(error)")
                                }
                            }
                        }
                } else {
                    TopYourMeetUpsView()
                        .tabItem {
                            Image(selection == 4 ? "Events_Red" : "Events")
                                .font(.system(size: 24, weight: .medium))
                                .frame(width: 26.01877, height: 24)
                                .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                        }
                        .tag(4)
                        .task {
                            Task {
                                do {
                                    try await fetchMatching(to: userName) { database in
                                        if let data = database {
                                            matchingData = data
                                            let fieldNames = Array(data.keys) // フィールド名を取得
                                            withWho = fieldNames[0]
                                            if !fieldNames.isEmpty {
                                                isMatching = true
                                            } else {
                                                isMatching = false
                                            }
                                            
                                            for fieldName in fieldNames {
                                                if let fromArray = data[fieldName] as? [Any] {
                                                }
                                            }
                                        }
                                    }
                                } catch {
                                    print("Failed to fetch data: \(error)")
                                }
                            }
                        }
                }
            }
        }
        .accentColor(Color(red: 0.89, green: 0.17, blue: 0.3))
    }
}

#Preview {
    TopMainTab(selection: Binding<Int>.constant(3))
}
