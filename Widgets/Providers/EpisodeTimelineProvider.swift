//
//  EpisodeTimelineProvider.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import WidgetKit
import Intents

final class EpisodeTimelineProvider: IntentTimelineProvider {
    private let tvShowService = TvShowService()

    private var snapshot: [TvShowEntry] = []

    func placeholder(in context: Context) -> TvShowEntry {
        return TvShowEntry.preview()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (TvShowEntry) -> ()) {
        guard !context.isPreview else {
            return completion(context.family == .systemSmall
                ? TvShowEntry(
                    date: Date(),
                    configuration: configuration,
                    show: .previewBreakingBad,
                    nextEpisode: TvShow.previewBreakingBad.nextEpisodes[0]
                )
                : .preview(with: configuration))
        }

        if let snapshot = snapshot.first {
            return completion(snapshot)
        }

        completion(.preview(with: configuration))
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<TvShowEntry>) -> ()) {
        tvShowService.fetchTvShows { [weak self] tvShows in
            guard let show = tvShows.first else { return }

            var entries: [TvShowEntry] = []
            var date = Date()

            for episode in show.nextEpisodes {
                entries.append(
                    TvShowEntry(
                        date: date,
                        configuration: configuration,
                        show: show,
                        nextEpisode: episode
                    )
                )
                date = episode.releaseDate
            }

            self?.snapshot = entries
            completion(Timeline(entries: entries, policy: .atEnd))
        }
    }
}
