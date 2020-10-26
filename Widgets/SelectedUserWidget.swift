//
//  Widgets.swift
//  Widgets
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct SelectedUserEntryView : View {
    var entry: UserTimelineProvider.Entry

    var body: some View {
        Text("test")
    }
}

@main
struct SelectedUserWidget: Widget {
    let kind: String = "SelectedUser"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: UserTimelineProvider()) { entry in
            SelectedUserEntryView(entry: entry)
        }
        .configurationDisplayName("Selected User")
        .description("This widget displays statistics for selected user.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct SelectedUserWidget_Previews: PreviewProvider {
    static var previews: some View {
        SelectedUserEntryView(entry: UserEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
