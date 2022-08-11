//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Николай Никитин on 10.08.2022.
//

import SwiftUI

struct ContentView: View {

  //MARK: - Properties
  @State private var showingScore = false
  @State private var isRoundEnded = false
  @State private var scoreTitle = ""
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var score = 0
  @State private var totalScore = 0
  @State private var numberOfQuestions = 8
  @State private var round = 1

  //MARK: - View
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
      ], center: .top, startRadius: 200, endRadius: 700)
        .ignoresSafeArea()
      VStack {
        Spacer()
        Text("Guess The Flag")
          .font(.largeTitle.bold())
          .foregroundColor(.white)
        Text("Round \(round)")
          .foregroundColor(.white)
          .font(.subheadline.weight(.heavy))
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              Image(countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        Spacer()
        Spacer()
        Text("Score: \(score)")
          .foregroundColor(.white)
          .font(.title.bold())
        Text("Questions left: \(numberOfQuestions)")
          .foregroundColor(.white)
          .font(.title.bold())
        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is \(score)")
    }
    .alert("8 questions passed!" ,isPresented: $isRoundEnded) {
      Button("Start new round", action: reset)
    } message: {
      Text("You have pass 8 questions of round \(round)! \nYour total score is \(totalScore)")
    }
  }

  //MARK: - Methods
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
      totalScore += 1
    } else {
      scoreTitle = "Wrong! That’s the flag of \(countries[number])"
    }
    numberOfQuestions -= 1
    if numberOfQuestions == 0 {
      isRoundEnded = true
    } else {
      showingScore = true
    }
  }

  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }

  func reset() {
    numberOfQuestions = 8
    score = 0
    round += 1
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewInterfaceOrientation(.portrait)
  }
}
