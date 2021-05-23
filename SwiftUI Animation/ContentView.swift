//
//  ContentView.swift
//  SwiftUI Animation
//
//  Created by Gayan Kalinga on 5/22/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        ViewTransition()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Creating Custom Animation
struct CornerRotateModifier: ViewModifier{
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

//Transition on View
struct ViewTransition: View{
    @State private var show = false
    
    var body: some View{
        VStack{
            Button("Tap Me"){
                withAnimation{
                    show.toggle()
                }
            }
            
            if show {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    //.transition(.scale)
                    .transition(.pivot)
                    //.transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            
        }
    }
}

//Card Drag Animation

struct CardDragAnimation: View{
    @State private var dragAmount = CGSize.zero
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.red, .yellow, .blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged{dragAmount = $0.translation }
                    .onEnded{_ in
                        withAnimation(.spring()){
                            dragAmount = .zero
                        }
                    }
            )
            //.animation(.spring())
    }
}

//String Drag Gesture Animation
struct StringDragAnimation: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

//Multiple animation modifiers
struct AnimationStack: View{
    @State private var enabled = false
     
     var body: some View{
         Button("Hit Me"){
             enabled.toggle()
         }
         .frame(width: 200, height: 200, alignment: .center)
         .background(enabled ? Color.red : Color.blue)
         .animation(.default)
         .foregroundColor(.white)
         
         .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
         .animation(.interpolatingSpring(stiffness: 50, damping: 1))
     }
}


//3d rotating animation
struct RotatingAnimation: View{
    @State private var animationAmount = 0.0
    
    var body: some View{
        //OverlayAnimationView()
        //BidningAnimation()
        Button("Tap Me") {
            //animationAmount += 360 -> This is not going to work since button has not animation modifire attached.
            
            //Option 1
//            withAnimation{
//                animationAmount += 360
//            }
            
            //Option 2
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
            
        }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}


//Animate using Binding
struct BindingAnimation: View{
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View{
        //OverlayAnimationView()

        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            
            Stepper("Scale amount 2", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }

    }
}

//Overlay Animation View as a SubView
struct OverlayAnimationView: View{
    @State private var scaleCount: CGFloat = 1
    var body: some View {
        VStack {
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
