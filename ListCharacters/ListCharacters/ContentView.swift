//
//  ContentView.swift
//  ListCharacters
//
//  Created by Эля Корельская on 01.06.2023.
//

import SwiftUI

struct ContentView: View {
    
 @State private var selectedCell: Post?
    var body: some View {
        List(data) {
            post in
            Section(header: Text("Catoons")){
                CharacterRow(post: post)
                    .onTapGesture {
                        selectedCell = post
                    }
                }
            }
        .sheet(item: $selectedCell) { post in
            CharacterDetails(post: post)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


