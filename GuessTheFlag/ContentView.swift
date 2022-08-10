//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Николай Никитин on 10.08.2022.
//

import SwiftUI

struct ContentView: View {

  //MARK: - Properties
  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
  var correctAnswer = Int.random(in: 0...2)

  //MARK: - View
  var body: some View {
    ZStack {
      Color.mint
        .ignoresSafeArea()
      VStack(spacing: 30) {
        VStack(spacing: 20) {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .foregroundColor(.white)
        }
        ForEach(0..<3) { number in
          Button {

          } label: {
            Image(countries[number])
              .renderingMode(.original)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
.previewInterfaceOrientation(.portrait)
  }
}
