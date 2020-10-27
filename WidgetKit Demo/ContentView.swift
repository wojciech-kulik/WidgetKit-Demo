//
//  ContentView.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import SwiftUI
import WidgetKit
import Intents

struct ContentView: View {
    @State var title: String = "Hello"

    var body: some View {
        VStack(spacing: 50) {
            Text(title)
                .font(.headline)

            Button("Donate Game of Thrones") {
                let intent = ConfigurationIntent()
                let tvShow = IntentTvShow(identifier: "1", display: "Game of Thrones")
                intent.tvShow = tvShow

                INInteraction(intent: intent, response: nil).donate { error in
                    if let error = error {
                        print(error)
                    } else {
                        print("donated GoT")
                    }
                }
            }

            Button("Donate Breaking Bad") {
                let intent = ConfigurationIntent()
                let tvShow = IntentTvShow(identifier: "2", display: "Breaking Bad")
                intent.tvShow = tvShow

                INInteraction(intent: intent, response: nil).donate { error in
                    if let error = error {
                        print(error)
                    } else {
                        print("donated Breaking Bad")
                    }
                }
            }
        }
        .onOpenURL { title = $0.absoluteString == "tv://series?id=1" ? "Game of Thrones" : "Breaking Bad" }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
