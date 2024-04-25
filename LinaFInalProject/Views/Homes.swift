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
            ScrollView { // Allows for scrolling if the content exceeds screen size
                
                VStack(alignment: .leading, spacing: 20) {
                    
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

                    
                    // Exercise Summary
                    Text("My Exercise Summary")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundStyle(.blue)
                    
                    // Placeholder for exercise statistics
                    // to do - add exercise stats here
                    
                    // Mental Health Summary
                    Text("My Mental Health Summary")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .foregroundStyle(.blue)
                    
                    Text("Reviewing your stats can help you reflect on your mental health as you exercise.")
                    
                    // Emotion Frequency Chart
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
                    
                    // Severity Ratings Chart
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
                    
                    // Past Reflections List
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

                    Text("Number of Deep Breath Sessions")
                        .font(.headline)
                        .padding(.horizontal)
                        .foregroundStyle(.blue)
                    // to do - display number of deep breathing sessions user had
                    Text("\(viewmodelEmotions.breathCount) Total Sessions").foregroundStyle(.red)
                    
                        // Start Workout Button
                        HStack {
                            Text("Ready to workout?")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
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
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }


//#Preview {
//    Home()
//}
