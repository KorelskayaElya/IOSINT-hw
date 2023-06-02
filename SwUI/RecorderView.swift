//
//  RecorderView.swift
//  SwUI
//
//  Created by Эля Корельская on 02.06.2023.
//


import SwiftUI


struct RecorderView: View {
   
    var body: some View {
       Image(systemName: "record.circle")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(Color.red)
    }
}
struct RecorderView_Previews: PreviewProvider {
    static var previews: some View {
        RecorderView()
    }
}


