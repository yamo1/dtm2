//
//  DoubleDatesMatch.swift
//  DTM
//
//  Created by 水野裕介 on 2024/09/10.
//

import SwiftUI

struct DoubleDatesMatch: View {
    @State var tmp = false
    var body: some View {
        VStack(spacing: 0) {
            Text("実験中")
            Button {
                checkInvite(name: "john.takahashi") { ttt in
                    // tmp = ttt
                }
                Task {
                    do {
                        try await checkDoubleMatch(name: "john.takahashi") { ttt in
                            tmp = ttt
                        }
                    } catch {
                        print(error)
                    }
                }
                
            } label: {
                Text("Push")
            }
            if tmp {
                Text("exist")
            } else {
                Text("not")
            }
        }
        .task {
            Task {
                do {
                    try await getDouble()
                    print("!!!!!!!!!!!!!!")
                    try await createInvite(to: "john.takahashi", from: "sigeru.sasaki", eventKey: "1")
                    print("!!!!!!!!!!!!!!")
                } catch {
                    print("Failed to fetch data: \(error)")
                }
            }
        }
    }
    
}

#Preview {
    DoubleDatesMatch()
}
