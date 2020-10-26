//
//  Provider.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import WidgetKit
import Intents

struct UserTimelineProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> UserEntry {
        NSLog("My widget >> placeholder")
        // Placeholder should contains sample data.
        // Any text will be replaced with empty rectangles (like for shimmer effect).
        // This is used when widget is waiting for snapshot/timeline (only first time).
        UserEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (UserEntry) -> ()) {
        NSLog("My widget >> Snapshot (preview: \(context.isPreview)")
        let entry = UserEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<UserEntry>) -> ()) {
        NSLog("My widget >> getTimeline")
        let entries = [UserEntry(date: Date(), configuration: configuration)]

        let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(5 * 1000)))
        completion(timeline)
    }
}
