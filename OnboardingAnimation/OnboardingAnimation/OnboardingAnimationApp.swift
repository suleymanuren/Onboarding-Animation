//
//  OnboardingAnimationApp.swift
//  OnboardingAnimation
//
//  Created by Bulut Sistem on 21.06.2023.
//

import SwiftUI

@main
struct OnboardingAnimationApp: App {
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
