//
//  DeepLinkView.swift
//  unifieddeeplink
//
//  Created by Mark Serrano on 11/23/20.
//

import SwiftUI

struct DeepLinkView: View {
    
    @State var color: String
    
    var body: some View {
    
        ZStack{
            
            if color == "blue" {
                Color.blue.edgesIgnoringSafeArea(.all)

            } else if color == "red" {
                Color.red.edgesIgnoringSafeArea(.all)

            } else if color == "green" {
                Color.green.edgesIgnoringSafeArea(.all)

            } else if color == "yellow"{
                Color.yellow.edgesIgnoringSafeArea(.all)
            }
            Text(color)

        }

    }
}

struct DeepLinkView_Previews: PreviewProvider {
    static var previews: some View {
        DeepLinkView(color: "")
    }
}
