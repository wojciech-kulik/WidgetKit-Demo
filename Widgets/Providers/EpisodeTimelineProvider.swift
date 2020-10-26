//
//  EpisodeTimelineProvider.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import WidgetKit
import Intents

struct EpisodeTimelineProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> TvShowEntry {
        return TvShowEntry.preview()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (TvShowEntry) -> ()) {
        completion(TvShowEntry.preview(with: configuration))
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<TvShowEntry>) -> ()) {
        let entries = [TvShowEntry.preview(with: configuration)]
        let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(5 * 60)))
        completion(timeline)
    }
}
