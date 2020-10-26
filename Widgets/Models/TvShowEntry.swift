//
//  TvShowEntry.swift
//  WidgetsExtension
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import WidgetKit

struct TvShowEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let relevance: TimelineEntryRelevance? = nil
    let show: TvShow
    let nextEpisode: Episode
}

extension TvShowEntry {
    static func preview(with configuration: ConfigurationIntent? = nil) -> TvShowEntry {
        return TvShowEntry(
            date: Date(),
            configuration: configuration ?? ConfigurationIntent(),
            show: .previewGameOfThrones,
            nextEpisode: TvShow.previewGameOfThrones.nextEpisodes[0]
        )
    }
}
