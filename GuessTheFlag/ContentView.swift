//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ricky David Groner II on 10/17/23.
//

import SwiftUI

struct FlagImage: View {
    var flag = ""
    
    var body: some View {
        Image(flag).clipShape(.capsule).shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var questionCount = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(.teal), location: 0.3),
                .init(color: Color(.indigo), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag").font(.largeTitle.bold()).foregroundStyle(.white)
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: countries[number])
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)").foregroundStyle(.white).font(.title.bold())
                
                Spacer()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCount == 8 {
                Button("Start Over", action: askQuestion)
            } else {
                Button("Continue", action: askQuestion)
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that is the flag of \(countries[number])"
            score -= 1
        }
        
        questionCount += 1
        if questionCount == 8 {
            scoreTitle = "Your final score is"
        }
        showingScore = true
    }
    
    func askQuestion() {
        if questionCount == 8 {
            questionCount = 0
            score = 0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
