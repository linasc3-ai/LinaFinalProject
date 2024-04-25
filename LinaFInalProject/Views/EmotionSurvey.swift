//
//  EmotionSurvey.swift
//  LinaFinalProject
//
//  Created by Lina Chihoub on 4/25/24.
//
import SwiftUI

struct EmotionSurvey: View {
    @EnvironmentObject var viewmodel: ExerciseVM
    @EnvironmentObject var viewmodelEmotions: EmotionVM
    @State private var selectedEmotionIndex: Int = 0
    @State private var isActive = false // Controls navigation
    
    @State private var emotions: [EmotionM] = [
        EmotionM(name: "Happiness", emoji: "😄", severity: 0.0, reflection: ""),
        EmotionM(name: "Sadness", emoji: "😢", severity: 0.0, reflection: ""),
        EmotionM(name: "Anger", emoji: "😠", severity: 0.0, reflection: ""),
        EmotionM(name: "Fear", emoji: "😨", severity: 0.0, reflection: ""),
        EmotionM(name: "Disgust", emoji: "🤢", severity: 0.0, reflection: ""),
        EmotionM(name: "Surprise", emoji: "😲", severity: 0.0, reflection: ""),
        EmotionM(name: "Love", emoji: "😍", severity: 0.0, reflection: "")
    ]

    var body: some View {
            VStack {
                headerView
                    .padding(.bottom, 20)
                
                Form {
                    emotionPickerSection
                    severitySliderSection
                    writtenReflectionSection
                }
            }
            .navigationBarHidden(true)
        }

    private var headerView: some View {
        HStack(spacing: 10) {
            Image("PennFitLogo")
                .resizable()
                .cornerRadius(15)
                .scaledToFit()
                .frame(width: 50, height: 50)
                .shadow(radius: 5)
            
            Text("PennFit")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }

    private var emotionPickerSection: some View {
        Section(header: Text("Emotion Survey").font(.headline)) {
            Text("How are you feeling after your workout?")
            Picker("Select an Emotion", selection: $selectedEmotionIndex) {
                ForEach(emotions.indices, id: \.self) { index in
                    Text(emotions[index].emoji + " " + emotions[index].name)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }

    private var severitySliderSection: some View {
        Section(header: Text("Severity Rating")) {
            Slider(value: $emotions[selectedEmotionIndex].severity, in: 0.0...10.0, step: 1) {
                Text("Severity")
            } minimumValueLabel: {
                Text("0 - Not Severe")
            } maximumValueLabel: {
                Text("10 - Very Severe")
            }
            .accentColor(.blue)
        }
    }

    private var writtenReflectionSection: some View {
        Section(header: Text("Written Reflection")) {
            TextField("Why do you feel that way?", text: $emotions[selectedEmotionIndex].reflection)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .frame(height: 50)
                .padding(.vertical, 10)
            
            Button("Continue") {
                let currentEmotion = emotions[selectedEmotionIndex]
                viewmodelEmotions.saveEmotion(emotion: currentEmotion)
                isActive = true // Trigger navigation
            }
            .buttonStyle(RoundedRectangleButtonStyle(backgroundColor: Color.blue, foregroundColor: .white))
            
            NavigationLink(destination: DeepBreathingView(), isActive: $isActive) {
                EmptyView()
            }
        }
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct EmotionSurvey_Previews: PreviewProvider {
    static var previews: some View {
        EmotionSurvey()
            .environmentObject(ExerciseVM())
            .environmentObject(EmotionVM())
    }
}
