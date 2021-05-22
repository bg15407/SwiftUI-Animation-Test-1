//
//  ContentView.swift
//  SwiftUI Animation
//
//  Created by Gayan Kalinga on 5/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var scaleCount: CGFloat = 1
    
    var body: some View {
        Button("Hit It"){
            scaleCount += 1
        }
        .padding(50)
        .background((scaleCount.truncatingRemainder(dividingBy: 2)) == 0 ? Color.red : Color.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(scaleCount)
        .animation(.default)
        //.blur(radius: (scaleCount - 1) * 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
