//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kevin Ziroldi on 20/09/24.
//

import SwiftUI

struct ContentView: View {
    let moves = ["👊", "✋", "✌️"]
    
    @State var appMove = Int.random(in: 0...2)
    @State var desiredResult = Bool.random()    // true = win, false = loose
    
    @State var score = 0
    @State var playNumber = 0
    
    @State var showRestartGame = false
    
    let maxPlayNumber = 10
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Section {
                // current score
                Text("Score: \(score)/\(playNumber)").font(.largeTitle.weight(.semibold))
            }
            
            Spacer()
            
            Section {
                // app's choices
                Text("App's move: ")
                Text(moves[appMove]).font(.system(size: 50))
                if desiredResult {
                    Text("You should: WIN").font(.title.weight(.semibold))
                }else {
                    Text("You should: LOSE").font(.title.weight(.semibold))
                }
            }
            
            Spacer()
            
            Section {
                // buttons
                ForEach(0..<3) { number in
                    Button {
                        buttonTapped(number)
                    }label: {
                        Text(moves[number]).font(.system(size: 50))
                    }
                }
            }
            Spacer()
            Spacer()
        }.alert("Game ended", isPresented: $showRestartGame) {
            Button("Restart game", action: restartGame)
        }message: {
            Text("You scored \(score)/\(maxPlayNumber) correct answers")
        }
    }
    
    func buttonTapped(_ number: Int) {
        playNumber += 1
        if (moves[appMove] == "👊" && desiredResult && moves[number] == "✋") ||
            (moves[appMove] == "👊" && !desiredResult && moves[number] == "✌️") ||
            (moves[appMove] == "✋" && desiredResult && moves[number] == "✌️" ) ||
            (moves[appMove] == "✋" && !desiredResult && moves[number] == "👊") ||
            (moves[appMove] == "✌️" && desiredResult && moves[number] == "👊") ||
            (moves[appMove] == "✌️" && !desiredResult && moves[number] == "✋")
        {
            score += 1
        }
        
        if playNumber == maxPlayNumber {
            showRestartGame = true
        }else {
            appMove = Int.random(in: 0...2)
            desiredResult.toggle()
        }
    }
    
    func restartGame() {
        score = 0
        playNumber = 0
        appMove = Int.random(in: 0...2)
        desiredResult = Bool.random()
    }
}

#Preview {
    ContentView()
}
