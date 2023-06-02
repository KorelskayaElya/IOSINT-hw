//
//  CharacterDetails.swift
//  ListCharacters
//
//  Created by Эля Корельская on 01.06.2023.
//

import SwiftUI

struct CharacterDetails: View {
    
    var post: Post
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                
                Divider()
                
                Text(post.description)
                
                Divider()
                post.image1
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 12)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .navigationTitle(post.title)
        .background(Color(.systemGray6))
    }
}

struct CharacterDetails_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetails(post: data[0])
    }
}

