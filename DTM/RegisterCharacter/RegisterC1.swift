//
//  RegisterC1.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI

let genders = ["Man", "Woman", "Beyond Binary"]
let sexualOrientatioins = ["Men", "Women", "Men & Women", "All Genders"]
let years = ["U1", "U2", "U3"," U4"]

struct RegisterC1: View {
    @State var inputName = ""
    @State private var isInput = false
    @State var gender = ""
    @State var sexualOrientation = ""
    @State var year = ""
    
    var now = 2
    
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack {
            NavigationLink {
                RegisterC1_2()
            } label: {
                Text("Complete later")
                    .font(
                        Font.custom("ModernEra-Medium", size: 12)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 32)
                    .padding(.top, 16)
            }
            
            // Line
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        ForEach(1...10, id:\.self) { number in
                            Spacer()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 25, height: 5)
                                .background(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color.clear)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    HStack {
                        ForEach(1...11, id:\.self) { number in
                            Image(systemName: number <= now ? "circle.fill" : "circle")
                                .frame(width: 15, height: 15)
                                .background(Color.white)
                                .foregroundColor(number <= now ? Color(red: 0.89, green: 0.17, blue: 0.3) : Color(red: 0.85, green: 0.85, blue: 0.85))
                            if number != 11 {
                                Spacer()
                            }
                        }
                    }
                }
            }
            .frame(width: 329, height: 15)
            .padding(.top, 48)
            .padding(.trailing, 32)
            .padding(.leading, 32)
            
            // Format
            VStack(alignment: .leading, spacing: 0) {
                
                // Gender
                VStack(spacing: 0) {
                    Text("I’m a")
                        .font(
                            Font.custom("New York", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 0) {
                        ForEach(genders, id: \.self) { gen in
                            optionGender(title: gen, gender: $gender)
                            if gen != genders.last {
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 31)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
                
                // Sexual Orientation
                VStack(spacing: 0) {
                    Text("I’m interested in")
                        .font(
                            Font.custom("New York", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 0) {
                        ForEach(sexualOrientatioins, id: \.self) {sex in
                            if sex != "All Genders" {
                                optionSex(title: sex, sexualOrientation: $sexualOrientation)
                                if sex != "Men & Women" {
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.top, 31)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    optionSex(title: "All Genders", sexualOrientation: $sexualOrientation)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 12)
                }
                .padding(.top, 51)
                
                // Year
                VStack(spacing: 0) {
                    Text("My Year")
                        .font(
                            Font.custom("New York", size: 28)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        ForEach(years, id: \.self) {ye in
                            optionYear(title: ye, year: $year)
                            if ye != years.last {
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 31)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 51)
                
                
                
                // Next
                NavigationLink {
                    RegisterC1_2()
                } label: {
                    Text("Next")
                        .font(
                            Font.custom("ModernEra-Medium", size: 16)
                        )
                        .bold()
                        .frame(width: 54, height: 22, alignment: .center)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        .foregroundColor(Color.white)
                        .background(gender.isEmpty || sexualOrientation.isEmpty || year.isEmpty ? AnyView(Constants.disableGrey) :
                            AnyView(LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.89, green: 0.17, blue: 0.3), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.91, green: 0.17, blue: 0.3), location: 0.35),
                                    Gradient.Stop(color: Color(red: 0.83, green: 0.13, blue: 0.35), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            ))
                        )
                        .cornerRadius(33)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                }
                // .disabled(gender.isEmpty && sexualOrientation.isEmpty && year.isEmpty)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .simultaneousGesture(TapGesture().onEnded {
                    // 実行させたい処理を記載
                    updateProfile(segment: "gender", value: gender)
                    updateProfile(segment: "sexualOrientation", value: sexualOrientation)
                    updateProfile(segment: "year", value: year)
                    // updateProfile(segment: "height", value: height)
                })
                .padding(.top, 48)
                
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
        Spacer()
    }
}

#Preview {
    RegisterC1()
}

struct optionGender: View {
    var title: String
    @Binding var gender: String

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                gender = title
                
            } label: {
                Text(title)
                    .font(
                        Font.custom("ModernEra-Medium", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(gender == title ? Color(red: 0.95, green: 0.76, blue: 0.82) : Color(red: 0.93, green: 0.93, blue: 0.93))
                    .cornerRadius(20)
            }
        }
        
    }
}

struct optionSex: View {
    var title: String
    @State var gateColor = true
    @Binding var sexualOrientation: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                gateColor.toggle()
                sexualOrientation = title
                
            } label: {
                Text(title)
                    .font(
                        Font.custom("ModernEra-Medium", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(sexualOrientation == title ? Color(red: 0.95, green: 0.76, blue: 0.82) : Color(red: 0.93, green: 0.93, blue: 0.93))
        .cornerRadius(40)
    }
}


struct optionYear: View {
    var title: String
    @State var gateColor = true
    @Binding var year: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                gateColor.toggle()
                year = title
                
            } label: {
                Text(title)
                    .font(
                        Font.custom("ModernEra-Medium", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(year == title ? Color(red: 0.95, green: 0.76, blue: 0.82) : Color(red: 0.93, green: 0.93, blue: 0.93))
        .cornerRadius(40)
    }
}

