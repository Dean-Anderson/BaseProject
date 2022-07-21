//
//  ContentView.swift
//  Shared
//
//  Created by dean.anderson on 2022/07/09.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabBarContainer(items: TabBarItem.allCases)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
