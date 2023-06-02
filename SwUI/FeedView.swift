//
//  FeedView.swift
//  SwUI
//
//  Created by Эля Корельская on 02.06.2023.
//

import SwiftUI

struct FeedView: View {
    @State var pushNotifications = false
    @State var messages = false
    @State var number: Double = 0
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $pushNotifications) {
                    Text("Push")
                }
                Toggle(isOn: $messages) {
                    Text("SMS")
                }
                VStack {
                    Text("\(number, specifier: "%.0f")").foregroundColor(number >= 0 ? .green : .red)
                    Slider(value:$number, in: -100...100, step: 1)
                }
                Text("Громкость")
                    .foregroundColor(Color.blue)
                    .background(Color.mint)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                Text("Громкость")
                    .foregroundColor(Color.red)
                    .font(.system(size: 40, weight: .bold, design: .monospaced))
                CircleView()
                
            } .navigationTitle("Settings")
            
        }
        
        
    }
}
struct CircleView: View {
    var body: some View {
        VStack {
            let colors = Gradient(colors: [.red,.yellow,.green,.blue,.purple])
            let gradient = AnyGradient(colors)
            Circle()
                .fill(gradient)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

