//
//  RegisterC3.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI

let faculties = ["🌍 Arts","🔬 Science","💼 Desautels Management","💻 Computing Studies","🦷 Dental Medicine","📚 Education","🛠 Engineering","🧠 Interfaculty B.A. & Sc.","⚖️ Law","🩺 Medicine","🎵 Schulich Music"]
let goOutOften = ["🌞 Everyday","🍻 5-6 times a week","🎟 3-4 times a week","🎶 Twice a week","🎉 Once a week","🌙 Sometimes","🗒 Rarely"]

struct RegisterC3: View {
    @State var inputHometown = ""
    @State private var isInput = false
    @State var faculty = ""
    @State var often = ""
    
    var now = 5
    @State var showPicker1 = false
    @State var showPicker2 = false
    public var body: some View {
        VStack {
            NavigationLink {
                RegisterC4()
                
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
                // What's Your hometown?
                Text("My Hometown")
                    .font(
                        Font.custom("New York", size: 28)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(height: 20, alignment: .leading)
                
                // inputForm
                
                VStack(spacing: 0) {
                    CustomTextField3(text: $inputHometown, placeholder: "Type hometown", onCommit: {
                        if !inputHometown.isEmpty {
                            isInput = true
                        }
                    })
                    // .multilineTextAlignment(.trailing)
                    .frame(width: .infinity, height: 32, alignment: .trailing)
                    .padding(.bottom, 5)
                    
                    Rectangle()
                        .padding(.top, 0)
                        .background(.black)
                        .frame(height: 1)
                }
                .padding(.top, 28)
                
                
                // What's Your Faculty?
                Text("Faculty")
                    .font(
                        Font.custom("New York", size: 28)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: 197, height: 20, alignment: .leading)
                    .padding(.top, 40)
                
                // inputForm
                
                VStack {
                    HStack {
                        Text(faculty.isEmpty ? "Select your Answer" : faculty)
                            .foregroundColor(.black)
                            .opacity(faculty.isEmpty ? 0.2 : 1)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .background(Color.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        showPicker1.toggle()
                    }
                    
                    Rectangle()
                        .padding(.top, 0)
                        .background(.black)
                        .frame(height: 1)
                }
                .padding(.top, 23)
                
                ZStack {
                    if showPicker1 {
                        List(faculties, id: \.self) { option in
                            Button(action: {
                                faculty = option
                                showPicker1 = false
                            }) {
                                Text(option)
                                    .foregroundColor(.black)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        // .frame(maxHeight: 1000)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    
                    if showPicker2 {
                        List(goOutOften, id: \.self) { option in
                            Button(action: {
                                often = option
                                showPicker2 = false
                            }) {
                                Text(option)
                                    .foregroundColor(.black)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        .frame(maxHeight: 1000)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    if (showPicker1 == false) && (showPicker2 == false) {
                        VStack(spacing: 0) {
                            // How often do you go out/not work in the evenings?
                            HStack(spacing: 0) {
                                Text("I go out/take the evenings off")
                                    .font(
                                        Font.custom("New York", size: 28)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.black)
                                    .frame(width: 246, height: 72, alignment: .topLeading)
                                    .padding(.top, 40)
                                
                                Spacer()
                            }
                            
                            // inputForm
                            
                            
                            VStack {
                                HStack {
                                    Text(often.isEmpty ? "Select your Answer" : often)
                                        .foregroundColor(.black)
                                        .opacity(often.isEmpty ? 0.2 : 1)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.black)
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .background(Color.white)
                                .cornerRadius(8)
                                .onTapGesture {
                                    showPicker2.toggle()
                                }
                                
                                Rectangle()
                                    .padding(.top, 0)
                                    .background(.black)
                                    .frame(height: 1)
                            }
                            .padding(.top, 23)
                            
                            
                            
                            
                            // Next
                            NavigationLink {
                                RegisterC4()
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
                                .background(Color(red: 0.89, green: 0.17, blue: 0.3))
                                .cornerRadius(33)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .simultaneousGesture(TapGesture().onEnded {
                                // 実行させたい処理を記載
                                updateProfile(segment: "hometown", value: inputHometown)
                                updateProfile(segment: "faculty", value: faculty)
                                updateProfile(segment: "oftenGo", value: often)
                            })
                            .padding(.top, 72)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterC3()
}


struct CustomPickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Image(systemName: "chevron.right")
                .rotationEffect(.degrees(90))
        }
        .foregroundColor(.black) // テキストの色を黒に変更
    }
}

extension View {
    func customPickerStyle() -> some View {
        self.modifier(CustomPickerStyle())
    }
}


struct CustomPicker: View {
    @Binding var selectedValue: String
    let options: [String]
    @State private var showPicker = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text(selectedValue.isEmpty ? "Select your Answer" : selectedValue)
                    .foregroundColor(.black)
                    .opacity(selectedValue.isEmpty ? 0.2 : 1)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(Color.white)
            .cornerRadius(8)
            .onTapGesture {
                showPicker.toggle()
            }
            
            Rectangle()
                .padding(.top, 0)
                .background(.black)
                .frame(height: 1)
        }
        
        if showPicker {
            List(options, id: \.self) { option in
                Button(action: {
                    selectedValue = option
                    showPicker = false
                }) {
                    Text(option)
                        .foregroundColor(.black)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .frame(maxHeight: 1000)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
        
    }
}
