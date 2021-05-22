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
            //scaleCount += 1
        }
        .padding(50)
        .background((scaleCount.truncatingRemainder(dividingBy: 2)) == 0 ? Color.red : Color.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(scaleCount)
                .opacity(Double(2 - scaleCount))
                .animation(
                    Animation.easeInOut(duration: 2)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear{
            scaleCount = 2
        }
        //.scaleEffect(scaleCount)
        //.animation(.default)
        //.animation(.interpolatingSpring(stiffness: 50, damping: 1))
        //.blur(radius: (scaleCount - 1) * 3)
        //.animation(.easeInOut(duration: 2))
//        .animation(
//            Animation.easeInOut(duration: 2)
//                .repeatForever(autoreverses: true)
//                //.repeatCount(2, autoreverses: true)
//                //.delay(1)
//        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
