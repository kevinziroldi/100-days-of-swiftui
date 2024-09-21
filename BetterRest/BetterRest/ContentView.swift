//
//  ContentView.swift
//  BetterRest
//
//  Created by Kevin Ziroldi on 21/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
        DatePicker("Please enter a date", selection: $wakeUp)
    }
}

#Preview {
    ContentView()
}
