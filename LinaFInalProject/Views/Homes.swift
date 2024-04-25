//
//  Home.swift
//  FinalProj
//
//  Created by Lina Chihoub on 4/24/24.
//
import SwiftUI
import Charts // to use for displaying data

struct Homes: View {
    @EnvironmentObject var viewmodel: ExerciseVM
    @EnvironmentObject var viewmodelEmotions: EmotionVM
    
    var body: some View {
        
        ZStack {
            Color(red: 0.8, green: 0.9, blue: 1.0) // Light pastel blue background
                .edgesIgnoringSafeArea(.all)
            
            ScrollView { // Allows for scrolling if the content exceeds screen size
                VStack(alignment: .leading, spacing: 20) {
                    header
                    exerciseSummary
                    mentalHealthSummary
                    pastReflections
                    deepBreathSessions
                    startWorkoutButton
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }

    var header: some View {
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
        .padding(.top, 20)
        .padding(.horizontal)
    }

    var exerciseSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Exercise Summary")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .foregroundStyle(.blue)
            
            Text("Total Steps")
                .font(.headline)
                .padding(.horizontal)
                .foregroundStyle(.blue)
            
            Text("\(viewmodel.stepCount) Total Steps")
                .foregroundStyle(.black)
                .padding(.horizontal)
        }
    }

    var mentalHealthSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("My Mental Health Summary")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .foregroundStyle(.blue)
            
            Text("Reviewing your stats can help you reflect on your mental health as you exercise.")
            
            emotionFrequencyChart
            severityRatingsChart
        }
    }

    var emotionFrequencyChart: some View {
        VStack(alignment: .leading) {
            Text("Emotion Frequency Chart")
                .font(.headline)
                .padding(.horizontal)
                .foregroundStyle(.blue)
            
            Chart {
                ForEach(Array(viewmodelEmotions.emotionsCount.keys), id: \.self) { key in
                    if let count = viewmodelEmotions.emotionsCount[key] {
                        BarMark(
                            x: .value("Emoji", key),
                            y: .value("Count", count)
                        )
                        .foregroundStyle(by: .value("Emoji", key))
                    }
                }
            }
            .frame(height: 100)
            .padding(.horizontal)
        }
    }

    var severityRatingsChart: some View {
        VStack(alignment: .leading) {
            Text("Emotion Severity Chart")
                .font(.headline)
                .padding(.horizontal)
                .foregroundStyle(.blue)
            
            Chart {
                ForEach(viewmodelEmotions.averageSeverityByEmotion, id: \.name) { emotion in
                    BarMark(
                        x: .value("Emotion", emotion.name),
                        y: .value("Severity", emotion.averageSeverity)
                    )
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisValueLabel(value.as(String.self) ?? "", centered: true)
                }
            }
            .frame(height: 100)
            .padding(.horizontal)
        }
    }

    var pastReflections: some View {
        VStack(alignment: .leading) {
            Text("Past Reflections")
                .font(.headline)
                .padding(.horizontal)
                .foregroundStyle(.blue)

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewmodelEmotions.emotions.indices, id: \.self) { index in
                        Text(viewmodelEmotions.emotions[index].reflection)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    var deepBreathSessions: some View {
        VStack(alignment: .leading) {
            Text("Number of Deep Breath Sessions")
                .font(.headline)
                .padding(.horizontal)
                .foregroundStyle(.blue)
            Text("\(viewmodelEmotions.breathCount) Total Sessions")
                .foregroundStyle(.black)
                .padding(.horizontal)
        }
    }

    var startWorkoutButton: some View {
        HStack {
            Text("Ready to workout?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
            
            NavigationLink(destination: ExerciseViews()) {
                Text("Start Workout")
                    .bold()
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    Home()
//}
