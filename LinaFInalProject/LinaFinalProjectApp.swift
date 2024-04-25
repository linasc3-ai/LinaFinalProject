//
//  LinaFinalProjectApp.swift
//  LinaFinalProject
//
//  Created by Lina Chihoub on 4/25/24.
//

import SwiftUI

@main
struct FinalProjApp: App {
    @StateObject var viewmodel = ExerciseVM()
    @StateObject var viewmodelEmotions = EmotionVM()
    
    var body: some Scene {
        WindowGroup {
            ExerciseViews()
                .environmentObject(viewmodel).environmentObject(viewmodelEmotions)
        }
    }
}
