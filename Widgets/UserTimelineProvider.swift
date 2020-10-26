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
        return UserEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (UserEntry) -> ()) {
        let entry = UserEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<UserEntry>) -> ()) {
        let entries = [UserEntry(date: Date(), configuration: configuration)]
        let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(5 * 60)))
        completion(timeline)
    }
}
