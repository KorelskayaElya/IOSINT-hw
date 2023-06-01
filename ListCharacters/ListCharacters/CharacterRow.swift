//
//  CharacterRow.swift
//  ListCharacters
//
//  Created by Эля Корельская on 01.06.2023.
//

import SwiftUI

struct CharacterRow: View {
    var post: Post
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.system(size: 24, weight: .bold, design: .rounded))
            post.image
                .resizable()
                .frame(width: 250, height: 250)
            Text(post.subtitle)
                .font(.system(size: 19, weight: .regular, design: .rounded))
            Spacer()
            
        }.padding(100)
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(post: data[0])
    }
}

