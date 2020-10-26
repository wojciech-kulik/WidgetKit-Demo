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
                    configuration: .preview,
                    show: .previewBreakingBad,
                    nextEpisode: TvShow.previewBreakingBad.nextEpisodes[0],
                    isError: false
                )
                : .preview(with: .preview))
        }

        if let snapshot = snapshot.first, snapshot.show?.id == configuration.tvShow?.identifier {
            return completion(snapshot)
        }

        completion(.preview(with: configuration))
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<TvShowEntry>) -> ()) {
        tvShowService.fetchTvShows { [weak self] tvShows in
            guard let show = tvShows.first(where: { $0.id == configuration.tvShow?.identifier }) else {
                return completion(Timeline(entries: [.error(with: configuration)], policy: .after(Date().addingTimeInterval(5 * 60))))
            }

            var entries: [TvShowEntry] = []
            var date = Date()

            for episode in show.nextEpisodes {
                entries.append(
                    TvShowEntry(
                        date: date,
                        configuration: configuration,
                        show: show,
                        nextEpisode: episode,
                        isError: false
                    )
                )
                date = episode.releaseDate
            }

            self?.snapshot = entries
            completion(Timeline(entries: entries, policy: .atEnd))
        }
    }
}
