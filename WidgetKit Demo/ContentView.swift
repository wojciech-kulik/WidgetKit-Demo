//
//  ContentView.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Circle()
            .stroke()
            .trim(from: 0, to: 0.75)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
