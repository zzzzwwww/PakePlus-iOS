//
//  ContentView.swift
//  PakePlus
//
//  Created by Song on 2025/3/29.
//

import SwiftUI

struct ContentView: View {
    var url = URL(string: "https://www.apple.com")!

    var body: some View {
        WebView(url: url)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
