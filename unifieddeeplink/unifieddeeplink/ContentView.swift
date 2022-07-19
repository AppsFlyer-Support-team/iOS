//
//  ContentView.swift
//  unifieddeeplink
//
//  Created by Mark Serrano on 11/23/20.
//

import SwiftUI

class ShowingView: ObservableObject {
    
    init(showingView: Bool, color: String = "") {
        self.displayView = false
        self.color = color
    }
    
    @Published var displayView : Bool
    @Published var color : String
}

struct ContentView: View {
    
    @ObservedObject var showingView: ShowingView
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
                NavigationLink(destination: DeepLinkView(color: showingView.color), isActive: $showingView.displayView) { Text("Next View")}
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let show = ShowingView(showingView: false)
        
        ContentView(showingView: show)
    }
}
