//
//  CustomConfigurationSampleApp.swift
//  CustomConfigurationSample
//
//  Created by Yutaka Tajika on 2022/11/29.
//

import AppFeature
import SwiftUI

@main
struct CustomConfigurationSampleApp: App {
    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView()
                #if AD_HOC
                Text("adhoc")
                #elseif RELEASE
                Text("release")
                #elseif DEBUG
                Text("debug")
                #endif
            }
        }
    }
}
