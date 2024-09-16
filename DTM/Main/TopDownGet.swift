//
//  TopDownGet.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/27.
//

import SwiftUI

struct TopDownGet: View {
    @State private var showDetailView = false
    @Namespace var namespace
    @Binding var isMatch: Bool
    @State var matchData: [String] = ["","","","","",""]
    @State var from = ""
    @State private var isConfirm = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button {
                        // Decline
                        matchDelete(to: userName) { success in
                            if success {
                                print("処理が完了しました。")
                                // 他の処理をここで実行
                                isMatch = false
                            } else {
                                print("処理中にエラーが発生しました。")
                                // エラーハンドリング
                            }
                        }
                    } label: {
                        Text("Decline")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                    }
                    
                    Spacer()
                    
                    Button {
                        // Profiles
                        showDetailView = true
                    } label: {
                        Group {
                            Text("Profiles")
                            Image(systemName: "chevron.right")
                                .font(
                                    Font.custom("Modern Era", size: 10)
                                        .weight(.bold)
                                )
                        }
                        .font(
                            Font.custom("Modern Era", size: 14)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                        .fullScreenCover(isPresented: $showDetailView) {
                            TopDownGetDetail(showDetailView: $showDetailView, namespace: namespace,isMatch: $isMatch, from: $from, matchData: $matchData)
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 11)
                
                VStack(spacing: 0) {
                    Text("\(from)'s DTM")
                        .font(
                            Font.custom("Modern Era", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(width: 350, height: 30, alignment: .top)
                    
                    HStack(spacing: 0) {
                        Image("calendar")
                            .frame(width: 15, height: 13.81686)
                            .padding(.trailing, 10)
                        Text(String(matchData[0]))
                            .font(
                                Font.custom("Modern Era", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .frame(width: 198, alignment: .topLeading)
                        Spacer()
                        Text("15: 45 : 53")
                            .font(
                                Font.custom("Modern Era", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.02, green: 0.16, blue: 0.1))
                        Image(systemName: "info.circle")
                            .frame(width: 15, height: 15)
                            .padding(.leading, 10)
                    }
                    .padding(.top, 36)
                    
                    HStack(spacing: 0) {
                        Image("Hear Icon")
                            .frame(width: 14, height: 12.46)
                            .padding(.trailing, 10)
                        Text(matchData[1])
                            .font(
                                Font.custom("Modern Era", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .frame(alignment: .topLeading)
                        Spacer()
                        Button {
                            // mapをタップしたときの動作
                            
                        } label: {
                            Image("map")
                                .frame(width: 12, height: 15)
                                .padding(.trailing, 10)
                            Text(matchData[4])
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.06, green: 0.47, blue: 0.94))
                        }
                    }
                    .padding(.top, 24)
                    
                    Button {
                        showDetailView = true
                    } label:{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 381)
                            .background(.black.opacity(0.2))
                            .background(
                                Image("testImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 310, height: 381)
                                    .clipped()
                            )
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 10)
                            .padding(.top, 30)
                    }
                    .fullScreenCover(isPresented: $showDetailView) {
                        TopDownGetDetail(showDetailView: $showDetailView, namespace: namespace, isMatch: $isMatch, from: $from, matchData: $matchData)
                    }
                    
                    Button {
                        // meetUpButton
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                            isConfirm = true
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Text("Accept")
                                .font(
                                    Font.custom("Modern Era", size: 16)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(Constants.GraysWhite)
                                .frame(width: 79, alignment: .top)
                        }
                        .padding(.horizontal, 35)
                        .padding(.vertical, 12)
                        .frame(width: 149, height: 48, alignment: .center)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.13, green: 0.83, blue: 0.61), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.13, green: 0.85, blue: 0.62), location: 0.35),
                                    Gradient.Stop(color: Color(red: 0.1, green: 0.76, blue: 0.45), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                        )
                    }
                    .padding(.top, 30)
                }
                .padding(.horizontal, 36)
                .padding(.top, 36)
                
                Spacer()
                
                Divider()
                    .padding(.horizontal, 15)
                    .padding(.bottom, 8)
            }
            .task {
                Task {
                    do {
                        try await fetchMatch(to: userName, matchData: $matchData, getFrom: $from)
                        print("###############")
                        print(matchData as Any)
                        print("from:\(from)")
                        print("###############")
                    } catch {
                        print("Failed to fetch data: \(error)")
                    }
                }
            }
            
            if isConfirm {
                PopupConfirmView(isPresented: $isConfirm, matchData: $matchData, isMatch: $isMatch, from: $from)
            }
        }
    }
}

#Preview {
    TopDownGet(isMatch: Binding<Bool>.constant(true), matchData: ["","","","","",""])
}
