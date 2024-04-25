import SwiftUI

struct DeepBreathingView: View {
    let totalTime = 60
    @EnvironmentObject var viewmodelEmotions: EmotionVM
    @State private var timeRemaining = 60
    @State private var progress: CGFloat = 1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // reflection questions to display
    let reflectionQuestions = [
            "What part of the workout did you enjoy the most?",
            "How did you feel during your workout?",
            "Did you achieve your exercise goal today?",
            "What could make your next workout better?",
            "How do you feel now after completing your workout?"
        ]

    var body: some View {
            VStack {
                // Header with Logo and Title
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

                Text("Time for a cool down...")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 20)

                Text("It's important to take time to breathe and reflect on how the workout made you feel.")
                
                Spacer()

                // Progress Circle and Breathe Text
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(Color.blue.opacity(0.5))

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.blue, lineWidth: 10)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: progress)

                    Text("Breathe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                }
                .frame(width: 250, height: 250)
                .padding(.vertical, 30)

                Spacer()

                Text("\(timeRemaining) seconds remaining...")
                    .font(.title3)
                    .foregroundColor(Color.red)

                Spacer()
                Text("Swipe through these questions for ideas on what to reflect on while you breathe.")
                reflectionTabView
                
                Spacer()

                if timeRemaining == 0 {
                    
                    VStack {
                        Text("Great work! You've successfully completed your exercise and emotion reflection.")
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        NavigationLink(destination: Homes()) {
                            Text("Complete Reflection")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .onAppear {
                self.startBreathingExercise()
                viewmodelEmotions.addBreath() // increase number of breaths
            }
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = CGFloat(self.timeRemaining) / CGFloat(self.totalTime)
                } else {
                    self.timer.upstream.connect().cancel()
                }
            }
    }

    func startBreathingExercise() {
        self.timeRemaining = totalTime
        self.progress = 1
    }
    
    var reflectionTabView: some View {
            TabView {
                ForEach(reflectionQuestions, id: \.self) { question in
                    Text(question)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 150)
        }
}


struct CooldownView_Previews: PreviewProvider {
    static var previews: some View {
        DeepBreathingView()
    }
}
