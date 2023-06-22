//
//  HomeView.swift
//  OnboardingAnimation
//
//  Created by Bulut Sistem on 21.06.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = false
    @State private var isAnimating : Bool = false

    var body: some View {
        ZStack{
            VStack(spacing: 20){
                Spacer()
                
                    ZStack{
                        Circle()
                            .stroke(Color(hex: 0x643843).opacity(0.3), lineWidth: 20)
                            .padding()
                        Circle()
                            .stroke(Color(hex: 0x99627A).opacity(0.4), lineWidth: 40)
                            .padding()
                        Circle()
                            .stroke(Color(hex: 0xC88EA7).opacity(0.4), lineWidth: 80)
                            .padding()
                        Image("character-2")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .offset(y: isAnimating ? 60 : -60)
                            .animation(
                                Animation
                                    .easeInOut(duration: 4)
                                    .repeatForever()
                                ,value: isAnimating
                            )
                    }
                  
                Spacer()
                VStack(spacing: 20){
                    
                    Text("The time that leads to mastery is dependent on the intensity of our focus.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                        .padding()
                }
                Spacer()
                Button(action: {
                    playSound(sound: "success", type: "m4a")

                    isOnboardingViewActive = true

                }){
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Restart")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(.title3,design: .rounded))
                }.buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
            }.onAppear{
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
                    isAnimating = true
                })
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
