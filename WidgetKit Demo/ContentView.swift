//
//  ContentView.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var title: String = "Hello"

    var body: some View {
        Text(title)
            .onOpenURL { title = $0.absoluteString == "tv://series?id=1" ? "Game of Thrones" : "Breaking Bad" }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
