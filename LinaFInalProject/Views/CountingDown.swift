//
//  CountdownView.swift
//  FinalProj
//
//  Created by Colin  on 2024/4/22.
//
import SwiftUI

struct CountingDown: View {
    @ObservedObject var viewModel: ExerciseVM
    @State private var progress: CGFloat = 1.0
    @State private var scaleEffect: CGFloat = 1.0

    var body: some View {
            VStack {
                
                // header to display logo
                HStack(spacing: 10) {
                                    Image("PennFitLogo")
                                        .resizable()
                                        .cornerRadius(30)
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text("PennFit")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                }
                                .padding()
                
                Text("Keep Moving!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                ZStack {
                    ProgressCircleView(progress: $progress)
                        .frame(width: 250, height: 250)
                        .scaleEffect(scaleEffect)
                        .animation(.easeInOut(duration: 0.5), value: scaleEffect)
                    
                    VStack {
                        Text("\(viewModel.timeRemaining) sec")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(viewModel.timeRemaining > 10 ? .primary : .red)
                        Text("Steps: \(viewModel.steps)")
                            .font(.title)
                            .padding(.top, 20)
                    }
                }
                
                if viewModel.timeRemaining == 0 {
                    NavigationLink(destination: EmotionSurvey()) {
                        Text("End Workout")
                            .fontWeight(.semibold)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding()
                }
            }
            .onReceive(viewModel.timerPublisher) { _ in
                updateProgress()
            }
            .onAppear {
                resetProgress()
            }
        }
    
    private func resetProgress() {
        let totalDuration = Double(viewModel.duration) ?? 0
        viewModel.timeRemaining = Int(totalDuration * 60.0)
        progress = 1.0
        scaleEffect = 1.0
    }
    
    private func updateProgress() {
        let totalDuration = Double(viewModel.duration) ?? 0
        progress = CGFloat(viewModel.timeRemaining) / (totalDuration * 60.0)
        scaleEffect = 1 + (1 - progress) * 0.1
    }
}

// Helper view to draw the progress circle
struct ProgressCircleView: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.5), value: progress)
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountingDown(viewModel: ExerciseVM())
    }
}
