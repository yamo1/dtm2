//
//  RegisterC1.swift
//  DTM
//
//  Created by 水野裕介 on 2024/06/22.
//

import SwiftUI

struct RegisterC2: View {
    @State var inputName = ""
    @State private var isInput = false
    @State var gender: String? = nil
    @State var sexualOrientation: String? = nil
    @State var year: String? = nil
    @State var height = 0
    
    @State var nationality1 = ""
    @State var nationality1Mark = ""
    @State var nationality2 = ""
    @State var nationality2Mark = ""
    @State var nationality3 = ""
    @State var nationality3Mark = ""
    
    @State private var query: String = ""
    @State private var queryIndex: Int = -1
    @State private var suggestions: [String] = []
    @State private var selectedSuggestionIndex: Int? = nil
    @State private var suggestionsIndex: [Int] = []
    
    @FocusState private var focusNow:Bool
    
    @State private var dummy = false
    
    // Create an array of tuples where each element is (index, value)
    let indexedItems = allItems[1].enumerated().map { ($0, $1) }
    
    var now = 4
    
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack {
            NavigationLink {
                RegisterC3()
                
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
                
                // What's Your McGill Email?
                Text("Your Nationality")
                    .font(
                        Font.custom("New York", size: 28)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .padding(.top, 60)
                
                // inputForm
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            ZStack {
                                CustomTextField(text: $query, onCommit: {
                                    selectTopSuggestion()
                                }, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                                .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                                .frame(height: 36)
                                .focused($focusNow)
                                
                                if isInput {
                                    Text("Successfully added")
                                        .padding(.leading, 5)
                                        .padding(.bottom, 1)
                                        .padding(.top, 1)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(
                                            Font.custom("ModernEra-Medium", size: 14)
                                        )
                                        .foregroundColor(.green)
                                        .background(Color.white)
                                        .onAppear() {
                                            DispatchQueue.main.async {
                                                query = ""
                                            }
                                        }
                                }
                                
                            }
                            .onAppear() {
                                DispatchQueue.main.async {
                                    focusNow = true
                                }
                            }
                            
                            
                            Button {
                                if !query.isEmpty && queryIndex != -1 {
                                    if nationality1 == "" {
                                        nationality1 = query
                                        nationality1Mark = allItems[0][queryIndex]
                                        UIApplication.shared.endEditing()
                                        isInput = true
                                        // 1秒後にshowTextをfalseにする
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            isInput = false
                                        }
                                    } else if nationality2 == "" {
                                        if nationality1 != query {
                                            nationality2 = query
                                            nationality2Mark = allItems[0][queryIndex]
                                            UIApplication.shared.endEditing()
                                            isInput = true
                                            // 1秒後にshowTextをfalseにする
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                isInput = false
                                            }
                                        }
                                    } else if nationality3 == "" {
                                        if nationality1 != query && nationality2 != query {
                                            nationality3 = query
                                            nationality3Mark = allItems[0][queryIndex]
                                            UIApplication.shared.endEditing()
                                            isInput = true
                                            // 1秒後にshowTextをfalseにする
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                isInput = false
                                            }
                                        }
                                    }
                                    
                                }
                            } label: {
                                Text("add 3")
                                    .font(
                                        Font.custom("ModernEra-Medium", size: 14)
                                            .weight(.medium)
                                    )
                                    .frame(width: 38, height: 14)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .foregroundColor(query.isEmpty ? Color(red: 0.93, green: 0.93, blue: 0.93): .black)
                                    .background(.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 0.5)
                                            .stroke(query.isEmpty ? Color(red: 0.93, green: 0.93, blue: 0.93): Color(red: 0.89, green: 0.17, blue: 0.3), lineWidth: Constants.StrokeBorder)
                                        
                                    )
                                    .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 2)
                            }
                            .disabled(query.isEmpty)
                            .padding(.trailing, 5)
                        }
                        .padding(.top, 67)
                        
                        
                        ZStack {
                            VStack(spacing: 0) {
                                Rectangle()
                                    .padding(.top, 0)
                                    .padding(.bottom, 0)
                                    .background(.black)
                                    .frame(width: 245, height: 1, alignment: .leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack(spacing: 0) {
                                    List() {
                                        ForEach(suggestions.indices, id: \.self) { index in
                                            Text(allItems[0][suggestionsIndex[index]] + " " + suggestions[index])
                                                .font(
                                                    Font.custom("ModernEra-Medium", size: 14)
                                                        .weight(.medium)
                                                )
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .listRowBackground(index == selectedSuggestionIndex ? Color(red: 0.9, green: 0.91, blue: 1) : Color.white)
                                                .onTapGesture {
                                                    query = suggestions[index]
                                                    queryIndex = suggestionsIndex[index]
                                                    suggestions = []
                                                    dummy = true
                                                    focusNow = false
                                                }
                                        }
                                    }
                                    .scrollContentBackground(.hidden)
                                    .frame(width: 300)
                                    .background(Color.white)
                                    .listRowInsets(EdgeInsets())
                                    .padding(.top,0)
                                    .listStyle(.plain)
                                    .cornerRadius(15)
                                    .shadow(color: suggestions.isEmpty == true || focusNow == false ? .clear : .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if suggestions.isEmpty {
                                VStack(spacing: 0) {
                                    Text("Add up to 3")
                                        .font(
                                            Font.custom("ModernEra-Medium", size: 12)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Constants.InfoGrey)
                                        .frame(width: 69, alignment: .topLeading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 16)
                                    
                                    Spacer()
                                }
                                
                                // selected Nation
                                VStack(spacing: 0) {
                                    HStack(spacing: 0) {
                                        if nationality1 != "" {
                                            Text(nationality1Mark)
                                                .font(
                                                    Font.custom("ModernEra-Medium", size: 24)
                                                )
                                        }
                                        if nationality2 != "" {
                                            Text(nationality2Mark)
                                                .font(
                                                    Font.custom("ModernEra-Medium", size: 24)
                                                )
                                        }
                                        if nationality3 != "" {
                                            Text(nationality3Mark)
                                                .font(
                                                    Font.custom("ModernEra-Medium", size: 24)
                                                )
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 60)
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        Spacer()
                
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onChange(of: query) { newValue in
                        updateSuggestions(for: newValue)
                        if dummy {
                            suggestions = []
                            dummy = false
                        }
                    }
                    
                    VStack(spacing: 0) {
                        Spacer()
                        
                        // Next
                        NavigationLink {
                            RegisterC3()
                            
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
                            updateProfile(segment: "nationality1", value: nationality1)
                            updateProfile(segment: "nationality2", value: nationality2)
                            updateProfile(segment: "nationality3", value: nationality3)
                        })
                        .padding(.bottom, 4)
                    }
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.leading, 26)
            .padding(.trailing, 26)
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
        Spacer()
    }
    private func selectTopSuggestion() {
        if let index = selectedSuggestionIndex {
            query = suggestions[index]
            queryIndex = suggestionsIndex[index]
            suggestions = []
            dummy = true
        }
    }
    
    private func updateSuggestions(for query: String) {
        if !query.isEmpty {
            let suggestionsWithIndex = indexedItems.filter { $0.1.lowercased().contains(query.lowercased()) }
            suggestions = suggestionsWithIndex.map { $0.1 }
            suggestionsIndex = suggestionsWithIndex.map { $0.0 }
            
            selectedSuggestionIndex = suggestions.isEmpty ? nil : 0
        } else {
            suggestions = []
            selectedSuggestionIndex = nil
        }
    }
}

#Preview {
    RegisterC2()
}


struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onCommit: () -> Void
        
        init(text: Binding<String>, onCommit: @escaping () -> Void) {
            _text = text
            self.onCommit = onCommit
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onCommit()
            return true
        }
    }
    
    @Binding var text: String
    var onCommit: () -> Void
    var padding: UIEdgeInsets
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChangeSelection(_:)), for: .editingChanged)
        
        // Design
        textField.placeholder = ""
        
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        return textField
    }
    
    
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    static func dismantleUIView(_ uiView: UITextField, coordinator: Coordinator) {
        // Remove constraints to avoid any conflict if needed
        uiView.removeConstraints(uiView.constraints)
    }
}


