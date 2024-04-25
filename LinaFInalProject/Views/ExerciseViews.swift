//
//  ExerciseView.swift
//  FinalProj
//
//  Created by Colin  on 2024/4/22.
//

import SwiftUI
import CoreMotion

struct ExerciseViews: View {
    @EnvironmentObject var viewModel: ExerciseVM
    @State private var showCountdownView = false
    @State private var showPermissionDeniedAlert = false

    var body: some View {
        NavigationView {
            ZStack{
                Color(.blue).ignoresSafeArea()
                
                VStack {
                    
                    HStack(spacing: 10) {
                        Image("PennFitLogo")
                            .resizable()
                            .cornerRadius(15)
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .shadow(radius: 5)
                            .foregroundStyle(.white)
                        
                        Text("PennFit")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    
                    
                    Text("Let's Get Started!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                    
                    Text("PennFit is here to help you exercise with your mental health in mind.").foregroundStyle(.white)
                    
                    TextField("Enter exercise duration (minutes)", text: $viewModel.duration)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Start Workout") {
                        // Check if step counting is available before starting
                        if CMPedometer.isStepCountingAvailable() {
                            viewModel.startExercise()
                            withAnimation {
                                showCountdownView = true
                            }
                        } else {
                            showPermissionDeniedAlert = true
                        }
                    }
                    .disabled(viewModel.isCollectingData || viewModel.duration.isEmpty)
                    .buttonStyle(StartButtonStyle())
                    .padding()
                    .alert(isPresented: $showPermissionDeniedAlert) {
                        Alert(
                            title: Text("Permission Denied"),
                            message: Text("Please enable motion & fitness tracking in settings."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    NavigationLink(destination: CountingDown(viewModel: viewModel), isActive: $showCountdownView) {
                        EmptyView()
                    }
                    .hidden()
                }}
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.requestPedometerAuthorization() // Correct function name
        }
    }
}

struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseViews()
    }
}
