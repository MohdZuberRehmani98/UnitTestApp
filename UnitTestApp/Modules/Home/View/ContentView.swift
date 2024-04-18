//
//  ContentView.swift
//  UnitTestApp
//
//  Created by Zuber Rehmani on 26/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ContentViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: ContentViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserSignedin {
                    SignedInHomeView()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .transition(.move(edge: .leading))
                } 
                if !vm.currentUserSignedin {
                    signupLayer
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .transition(.move(edge: .leading))
                }
            }
           
            
        }
        
    }
}

#Preview {
    ContentView(isPremium: Bool.random())
}
extension ContentView {
    var signupLayer: some View {
        VStack {
            TextField(vm.placeholder, text: $vm.textfieldText)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button(action: {
                withAnimation(.spring) {
                    vm.signupAction()
                }
            }, label: {
                Text("Signup")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
            })
        }
    }
}


struct SignedInHomeView: View {
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show Welcome alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.red)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    return Alert(title: Text("Welcome to the app"))
                }
                
                NavigationLink(destination: Text("Destination"), label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .cornerRadius(10)
                })

            }
            .navigationTitle("Welcome")
            .padding()
        }
       
        .ignoresSafeArea()
    }
}
