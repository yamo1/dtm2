//
//  TonightView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/06.
//

import SwiftUI

struct TonightView: View {
    @State private var isShowView = false
    @State private var isCreate = false
    var body: some View {
        VStack(spacing: 0) {
            // How it works button
            Button() {
                isShowView = true
            } label: {
                Image(systemName: "heart")
                    .frame(width: 14, height: 14)
                Text("How it works")
                    .frame(width: 83, height: 11, alignment: .center)
            }
            .font(
                Font.custom("ModernEra-Regular", size: 14)
                    .weight(.medium)
            )
            .foregroundColor(.black)
            .sheet(isPresented: $isShowView) {
                DescribeView()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 24)
            .padding(.trailing, 18)
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Tonight")
                    .font(Font.custom("ModernEra-Medium", size: 24))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 24)
                    .padding(.leading, 18)
            }
            
            Text("Welcome to DTM\n\(userName)!")
                .font(
                    Font.custom("New York", size: 32)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 286, alignment: .top)
                .padding(.top, 96)
            
            
            Text("Create a profile to begin Meeting")
                .font(
                    Font.custom("ModernEra-Medium", size: 16)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 359, alignment: .top)
                .padding(.top, 72)
            
            Button {
                isCreate = true
            } label: {
                Text("Create Profile")
                    .font(
                        Font.custom("ModernEra-Bold", size: 16)
                    )
                    .bold()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.white)
            }
            .frame(width: 177, height: 48, alignment: .center)
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
            .cornerRadius(33)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 4)
            .padding(.top, 84)
            .fullScreenCover(isPresented: $isCreate) {
                RegisterPhoneNumberView()
            }
            
            Text("\(userName)@mail.mcgill.ca")
                .font(
                    Font.custom("ModernEra-Medium", size: 14)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                .frame(width: 359, alignment: .top)
                .padding(.top, 144)
            
            Spacer()
            Divider()
                .frame(width: 350, height: 1)
                .padding(.bottom, 12)
        }
    }
}

#Preview {
    TonightView()
}
