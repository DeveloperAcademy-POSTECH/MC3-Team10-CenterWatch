//
//  TextModels.swift
//  CDDWatchApp Watch App
//
//  Created by 박상준 on 2023/09/02.
//

import SwiftUI

public final class AppText {
    
    //Usage: String(localized: "Key")
    
    //file name
    class ContentView {
        //method name
        class View {
            let notSet = LocalizedStringKey("Please complete the settings in the Ggood Ggood iOS app!")
            let startLabel = LocalizedStringKey("Start Time")
            let endLabel = LocalizedStringKey("End Time")
            let notiLabel = LocalizedStringKey("Notification Interval")
            let unit = LocalizedStringKey("Hour")
        }
    }
}
