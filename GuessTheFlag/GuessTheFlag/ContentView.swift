//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Ziroldi on 16/09/24.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var tappedFlag = ""
    
    @State private var showingGameEnded = false
    @State private var numberTapped = 0
    @State private var numberCorrect = 0
    
    private let maxGames = 10
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Played flags: \(numberTapped)/\(maxGames)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.semibold))
                
                VStack {
                    Text("Tap the flag of").foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer]).foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }

                ForEach(0..<3) { number in
                    Button {
                       flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
                
                Text("Score: " + scoreTitle)
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Correct!")
            }else {
                Text("Wrong! That’s the flag of " + tappedFlag)
            }
        }
        .alert("Game ended!", isPresented: $showingGameEnded) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("You scored \(numberCorrect)/\(maxGames) correct answers")
        }
    }
    
    func flagTapped(_ number: Int) {
        numberTapped += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            numberCorrect += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        tappedFlag = countries[number]
        showingScore = true
    }

    func askQuestion() {
        if(numberTapped == maxGames) {
            showingGameEnded = true
        }else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func restartGame() {
        numberTapped = 0
        numberCorrect = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
