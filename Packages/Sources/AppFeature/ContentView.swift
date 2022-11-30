//
//  ContentView.swift
//  CustomConfigurationSample
//
//  Created by Yutaka Tajika on 2022/11/29.
//

import SwiftUI

public struct ContentView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            #if AD_HOC
            Text("Hello, adhoc world!")
            #elseif RELEASE
            Text("Hello, release world!")
            #elseif DEBUG
            Text("Hello, debug world!")
            #endif
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
