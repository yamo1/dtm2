//
//  SwiftUIView.swift
//  DTM
//
//  Created by 水野裕介 on 2024/07/05.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack() {
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 473, height: 932)
                    .background(
                        AsyncImage(url: URL(string: "https://via.placeholder.com/473x932"))
                    )
                    .offset(x: 0, y: 0)
            }
            .frame(width: 393, height: 852)
            .offset(x: 0, y: 0)
            Text("adam.coke@mail.mcgill.ca")
                .font(Font.custom("Modern Era", size: 18).weight(.bold))
                .tracking(0.72)
                .lineSpacing(27)
                .foregroundColor(Color(red: 0, green: 0.02, blue: 0.03))
                .offset(x: 0, y: -76.50)
            ZStack() {
                Ellipse()
                    .foregroundColor(.clear)
                    .frame(width: 5, height: 5)
                    .background(.black)
                    .offset(x: -15, y: 0)
                Ellipse()
                    .foregroundColor(.clear)
                    .frame(width: 5, height: 5)
                    .background(.black)
                    .offset(x: 0, y: 0)
                Ellipse()
                    .foregroundColor(.clear)
                    .frame(width: 5, height: 5)
                    .background(.black)
                    .offset(x: 15, y: 0)
            }
            .frame(width: 35, height: 5)
            .offset(x: 0, y: 27.50)
            Text("Resend")
                .font(Font.custom("Modern Era", size: 12).weight(.bold))
                .lineSpacing(18)
                .foregroundColor(Color(red: 0.89, green: 0.17, blue: 0.30))
                .offset(x: 143.50, y: 125)
            Text("Check Your McGill Email!")
                .font(Font.custom("TT Norms Pro Serif", size: 28).weight(.bold))
                .lineSpacing(42)
                .foregroundColor(.black)
                .offset(x: 0.50, y: -209)
            ZStack() {
                Text("􀆉")
                    .font(Font.custom("SF Pro", size: 17))
                    .lineSpacing(22)
                    .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                    .offset(x: -21.50, y: 0)
                Text("Back")
                    .font(Font.custom("SF Pro", size: 17))
                    .lineSpacing(22)
                    .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                    .offset(x: 10.50, y: 0)
            }
            .frame(width: 60, height: 12)
            .offset(x: -157.50, y: -351)
            Text("Welcome Back Adam ")
                .font(Font.custom("Modern Era", size: 12).weight(.bold))
                .foregroundColor(Color(red: 0.16, green: 0.65, blue: 0.27))
                .offset(x: 0.50, y: -306.50)
            ZStack() {
                ZStack() {
                    Text("9:41")
                        .font(Font.custom("SF Pro", size: 17))
                        .lineSpacing(22)
                        .foregroundColor(.black)
                        .offset(x: 0.17, y: 2.34)
                }
                .frame(width: 140.50, height: 54)
                .offset(x: -126.25, y: 0)
                ZStack() {
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 25, height: 13)
                            .cornerRadius(4.30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4.30)
                                    .inset(by: 0.50)
                                    .stroke(.black, lineWidth: 0.50)
                            )
                            .offset(x: -1.16, y: 0)
                            .opacity(0.35)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 21, height: 9)
                            .background(.black)
                            .cornerRadius(2.50)
                            .offset(x: -1.16, y: 0)
                    }
                    .frame(width: 27.33, height: 13)
                    .offset(x: 24.41, y: 2.50)
                }
                .frame(width: 140.50, height: 54)
                .offset(x: 126.25, y: 0)
            }
            .frame(width: 393, height: 54)
            .offset(x: 0, y: -399)
        }
        .frame(width: 393, height: 852)
        .background(.white)
        .cornerRadius(48)
    }
}

#Preview {
    SwiftUIView()
}
