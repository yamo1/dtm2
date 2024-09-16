//
//  RegisterC4.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/23.
//

import SwiftUI

let hobbies1 = ["Clubbing","Reading","Cold swimming","Djing"]
let hobbies2 = ["Chess","Poetry","Music","Dancing","Art"]
let hobbies3 = ["Concerts","Coding","Climing","Ice Hockey"]
let hobbies4 = ["Writing","Yoga","Gym","Films","Cooking"]
let hobbies5 = ["Tennis","Martial Arts","Nature","Astronomy"]
let hobbies6 = ["Hiking","Board Games","Skiing","Athletics"]
let hobbies7 = ["Football","Ice Skating","Traveling","Running"]
let hobbies8 = ["Soccer","Fashion","Video games","Raves"]

struct RegisterC5: View {
    @State var inputHobby = ""
    @State private var isInput = false
    @State var hobby1 = ""
    @State var hobby2 = ""
    @State var hobbies0 = [""]
    
    var now = 7
    public var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                RegisterC6_1()
                
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
            
            // Number
            VStack(alignment: .leading) {
                // Two Passions/Hobbies
                ScrollView {
                    HStack(spacing: 0) {
                        Text("2 hobbies/passions")
                            .font(
                                Font.custom("New York", size: 28)
                                    .weight(.bold)
                            )
                            .foregroundColor(.black)
                            .frame(width: 313, height: 20, alignment: .topLeading)
                            .padding(.top, 48)
                        
                        Spacer()
                    }
                    // Add Space
                    // Genre List
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(hobbies1, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies1.last {
                                    Spacer()
                                }
                            }
                        }
                        HStack(spacing: 0) {
                            ForEach(hobbies2, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies2.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies3, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies3.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies4, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies4.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies5, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies5.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies6, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies6.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies7, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies7.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies8, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies8.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                        HStack(spacing: 0) {
                            ForEach(hobbies0, id: \.self) { gen in
                                optionHobbies(title: gen, hobby1: $hobby1, hobby2: $hobby2)
                                if gen != hobbies0.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.top, 15)
                    }
                    .padding(.top, 48)
                    
                    // inputForm
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            HStack(spacing: 0) {
                                CustomTextField3(text: $inputHobby, placeholder: "Type genre", onCommit: {
                                })
                                .frame(width: .infinity, height: 32, alignment: .trailing)
                                .padding(.bottom, 0)
                                
                                Button {
                                    if !inputHobby.isEmpty {
                                        isInput = true
                                        var judge = true
                                        for index in hobbies0 {
                                            if index == inputHobby {
                                                judge = false
                                            }
                                        }
                                        if judge {
                                            hobbies0.append(inputHobby)
                                        }
                                    }
                                } label: {
                                    Text("add +")
                                        .font(
                                            Font.custom("ModernEra-Medium", size: 14)
                                                .weight(.medium)
                                        )
                                        .padding(.vertical, 6)
                                        .frame(width: 61, height: 23, alignment: .center)
                                        .foregroundColor(inputHobby == "" ? Color(red: 0.93, green: 0.93, blue: 0.93) : .black)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .inset(by: 0.5)
                                                .stroke(inputHobby == "" ? Color(red: 0.93, green: 0.93, blue: 0.93) : Color(red: 0.89, green: 0.17, blue: 0.3), lineWidth: Constants.StrokeBorder)
                                        )
                                        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 2)
                                }
                                
                                .padding(.trailing, 5)
                            }
                            .frame(width: 255, alignment: .leading)
                            Spacer()
                        }
                        
                        HStack(spacing: 0) {
                            Rectangle()
                                .padding(.top, 0)
                                .background(.black)
                                .frame(width: 255, height: 1, alignment: .leading)
                            Spacer()
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 43)
                    
                }
                // Next
                NavigationLink {
                    RegisterC6_1()
                } label: {
                    Text("Next")
                        .font(
                            Font.custom("ModernEra-Medium", size: 16)
                        )
                        .bold()
                        .frame(width: 54, height: 22)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
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
                        .cornerRadius(33)
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .simultaneousGesture(TapGesture().onEnded {
                    // 実行させたい処理を記載
                    updateProfile(segment: "hobby1", value: hobby1)
                    updateProfile(segment: "hobby2", value: hobby2)
                })
                
                Spacer()
            }
            //.padding(.top, 50)
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterC5()
}

struct optionHobbies: View {
    var title: String
    @Binding var hobby1: String
    @Binding var hobby2: String
    
    var body: some View {
        if title != ""{
            HStack(alignment: .center, spacing: 8) {
                Button {
                    if hobby1 == "" {
                        hobby1 = title
                    } else if hobby2 == "" {
                        hobby2 = title
                    } else {
                        hobby1 = hobby2
                        hobby2 = title
                    }
                    
                } label: {
                    Text(title)
                        .font(
                            Font.custom("ModernEra-Medium", size: 14)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
            }
            .padding(8)
            .background(hobby1 == title || hobby2 == title ? Constants.SelectedColour : Constants.BackgoroundGrey)
            .cornerRadius(10)
        }
    }
}
