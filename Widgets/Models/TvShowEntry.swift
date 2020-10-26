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
    let show: TvShow?
    let nextEpisode: Episode?
    let isError: Bool
}

extension TvShowEntry {
    static func preview(with configuration: ConfigurationIntent? = nil) -> TvShowEntry {
        return TvShowEntry(
            date: Date(),
            configuration: configuration ?? .preview,
            show: .previewGameOfThrones,
            nextEpisode: TvShow.previewGameOfThrones.nextEpisodes[0],
            isError: false
        )
    }

    static func error(with configuration: ConfigurationIntent) -> TvShowEntry {
        return TvShowEntry(
            date: Date(),
            configuration: configuration,
            show: nil,
            nextEpisode: nil,
            isError: true
        )
    }
}

extension ConfigurationIntent {
    static var preview: ConfigurationIntent = {
        let result = ConfigurationIntent()
        result.tvShow = IntentTvShow(identifier: TvShow.previewGameOfThrones.id, display: TvShow.previewGameOfThrones.title)

        return result
    }()
}
