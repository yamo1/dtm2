//
//  DescribeView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI

struct DescribeView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            // Title
            Text("How it works")
                .font(
                    Font.custom("ModernEra-Medium", size: 20)
                )
                .foregroundColor(Color(red: 0.03, green: 0.03, blue: 0.03))
                .padding(.top, 24)
                .padding(.bottom, 24)
            
            Divider()
            
            // Image
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 231.09677, height: 143.44186)
                .background(
                    Image("howsPage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 231.09677124023438, height: 143.44186401367188)
                        .clipped()
                )
                .padding(.top, 48)
            
            Text("Find someone attractive: Send a time and place to meet. No Small talk! ")
                .font(
                    Font.custom("ModernEra-Medium", size: 18)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 357, alignment: .center)
                .padding(.top, 24)
            
            Divider()
                .frame(width: 300)
                .padding(.top, 48)
            
            // Image
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 231.09677, height: 144)
                .background(
                    Image("howsPage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 231.09677124023438, height: 144)
                        .clipped()
                )
                .padding(.top, 48)
            
            // Main2
            Text("Social Invite: meet them at a house party, club, bar with both your friends")
                .font(
                    Font.custom("ModernEra-Medium", size: 18)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(width: 357, alignment: .center)
                .padding(.top, 24)
            
            // Button
            Button {
                dismiss()
            } label: {
                Text("Nice got it")
                    .font(
                        Font.custom("ModernEra-Medium", size: 15.72327)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                    .frame(width: 103.81357, alignment: .top)
                    .padding(.horizontal, 40.96044)
                    .padding(.vertical, 8.47458)
                    .frame(width: 125, height: 41.66667, alignment: .center)
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
                    .cornerRadius(23.30508)
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
            }
            .padding(.top, 60)
            
            Spacer()
        }
    }
}

#Preview {
    DescribeView()
}
