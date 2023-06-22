//
//  OnboardingView.swift
//  OnboardingAnimation
//
//  Created by Bulut Sistem on 21.06.2023.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = true

    @State private var buttonWidth : Double = UIScreen.main.bounds.width - 80 
    @State private var buttonOffset : CGFloat = 0
    @State private var characterOffset : CGFloat = 0
    @State private var characterOffset2 : CGSize = .zero

    @State private var circleOffset : CGFloat = 0
    @State private var isAnimating : Bool = false
    @State private var isCharacterAnimating : Bool = false

    var body: some View {
        ZStack{
            Color("ColorRed")
                .ignoresSafeArea(.all,edges:.all)
            VStack (spacing: 20){
                
                Spacer()
                
                VStack{
                    
                    Text(!isCharacterAnimating ? "Share." : "Give.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)

                    Text("""
                    It's not how much we give but how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal,10)

                } // header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
               
                ZStack{
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 260,height: 260,alignment: .center)
                        
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 260,height: 260,alignment: .center)
                        
                    }
                    .blur(radius: isAnimating ? 0 : 5)
                    .opacity(isAnimating ? 1 : 0.5)
                    .animation(.easeOut(duration: 1), value: isAnimating)
                    .blur(radius: circleOffset != 0 ? 5 : 0)

                    .offset(x : circleOffset)
                    
                     
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x : characterOffset)
                        .rotationEffect(.degrees(Double(characterOffset2.width / 20)))
                  
                }//center
                
                Image(systemName: "arrow.left.and.right.circle")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 22)
                    
                    .gesture(
                        DragGesture()
                            .onChanged{ gesture in
                                if buttonOffset <= buttonWidth - 80 {
                                    characterOffset = gesture.translation.width
                                    circleOffset =   -gesture.translation.width
                                    characterOffset2 = gesture.translation
                                }
                                
                                isCharacterAnimating = true
                            }
                            .onEnded{ _ in
                                withAnimation(Animation.easeOut(duration: 0.5)){
                                    if buttonOffset > buttonWidth / 2 {
                                        characterOffset = buttonWidth - 80
                                        circleOffset = buttonWidth
                                        isOnboardingViewActive = false
                                    }else {
                                        characterOffset = 0
                                        circleOffset = 0
                                        
                                        
                                    }
                                }
                                characterOffset2.width = 0
                                characterOffset2.height = 0
                                isCharacterAnimating = false
                            }
                    )
                ZStack{
                    ZStack{
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                            .padding(8)
                        
                        Text("Get Started")
                            .font(.system(.title3,design:.rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x:20)
                        
                        HStack{
                            Capsule()
                                .fill(Color("ColorGreen"))
                                .frame(width: buttonOffset + 80)
                            Spacer()
                            
                        }
                        
                    }
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorGreen"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 25,weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80,alignment: .center)
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.5)){
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                            playSound(sound: "chimeup", type: "mp3")
                                        }else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        Spacer()
                    }
                }//footer
                .frame(width: buttonWidth ,height: 80,alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                Spacer()
                
                
            }
        }
        .onAppear(perform:{
            isAnimating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
