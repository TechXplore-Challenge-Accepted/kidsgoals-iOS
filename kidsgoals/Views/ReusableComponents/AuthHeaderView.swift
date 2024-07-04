//
//  AuthHeaderView.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import SwiftUI

struct AuthHeaderView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 75, height: 75)
            
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            
            Text(description)
                .fontWeight(.light)
        }
        .foregroundStyle(Color.primary)
        
    }
}

#Preview {
    AuthHeaderView(title: "Sign In", description: "Sign in to your account")
}
