//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Peter Loux on 4/23/24.
//

import SwiftUI


struct ContentView: View {
	// state property for user's score
    @State private var score = 0
    
    // state property for game over
    @State private var gameOver = false
    
    // state property for number of questions asked
    @State private var questionsAsked = 0
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	var body: some View {
		ZStack {
            LinearGradient(colors: [.teal, .black], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
			VStack {
                VStack {
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    Spacer()
          

                    VStack (spacing: 15) {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                        
                            .font(.largeTitle.weight(.semibold))
                        Text("Score: \(score)")
                            .foregroundStyle(.white)
                            .font(.title.bold())
                            .frame(maxWidth: .infinity)
                        
                    }
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                }
                
				ForEach(0..<3) { number in
					Button {
						flagTapped(number)
					} label: {
						Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                    Spacer(minLength: 20)
				}
                
                
                Spacer(minLength: 80)
                
            } // end Vstack
            .padding()
            
		} // end Zstack
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
            Text("Your score is \(score)")
		}
        .alert("Game Over", isPresented:  $gameOver) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
            
	}
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
            
        }
        questionsAsked += 1
        if questionsAsked == 8 {
            gameOver = true
        }
        else {
            showingScore = true
        }
	}

	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
    
    func resetGame() {
        score = 0
        questionsAsked = 0
        gameOver = false
        askQuestion()
    }

	
}

#Preview {
    ContentView()
	
}
