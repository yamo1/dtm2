//
//  FirstPageView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI

struct FirstPageView: View {
    @State private var isShowView = false
    @State private var isButton = false
    
    var body: some View {
        
        // full view vstack
        VStack(spacing: 0) {
            
            // How it works button
            Button() {
                isShowView = true
            } label: {
                Image(systemName: "info.circle")
                    .frame(width: 14, height: 14)
                Text("How it works")
                    .frame(width: 83, height: 11, alignment: .top)
            }
            .font(
                Font.custom("ModernEra-Medium", size: 14)
            )
            .foregroundColor(.black)
            .sheet(isPresented: $isShowView) {
                DescribeView()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 48)
            .padding(.trailing, 18)
            
            Text("Down To Meet")
                .font(
                    Font.custom("New York", size: 36)
                        .weight(.bold)
                )
                .frame(width: 253, height: 28)
                .padding(.top, 60)
                .foregroundColor(Color(red: 0.03, green: 0.03, blue: 0.03))
            
            Text("The McGill Dating App")
                .font(
                    Font.custom("ModernEra-Bold", size: 20)
                )
                .padding(.top, 48)
                .kerning(0.8)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            VStack(spacing: 0) {
                VStack(spacing: 0){}.padding(.top, 336)
                Button {
                    isButton = true
                } label: {
                    Text("Create account / Log in")
                        .font(
                            Font.custom("ModernEra-Bold", size: 18)
                                .weight(.bold)
                        )
                        .frame(width: 207)
                }
                .frame(width: 292, height: 55)
                .foregroundColor(Color.white)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                            Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .cornerRadius(35)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                .fullScreenCover(isPresented: $isButton) {
                    RegisterEmailView()
                }
                
                // info
                Text("By creating an account you agree to our Terms. See how we use your data in our privacy policy. ")
                    .font(
                        Font.custom("ModernEra-Medium", size: 12)
                    )
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .frame(width: 292, alignment: .leading)
                    .padding(.top, 24)
                
                Text("Not affiliated with McGill University  ")
                    .font(Font.custom("ModernEra-Medium", size: 10))
                    .foregroundColor(Constants.ContentGrey)
                    .frame(width: 292, alignment: .leading)
                    .padding(.top, 8)
            }
            .padding(.trailing, 50)
            .padding(.leading, 50)
        }
        Spacer()
    }
}

#Preview {
    FirstPageView()
}
