//
//  EpisodeCountdownWidget.swift
//  Widgets
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct EpisodeCountdownEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily

    var entry: TvShowEntry

    @ViewBuilder
    var headerView: some View {
        Text(entry.show?.title ?? "-")
            .minimumScaleFactor(0.5)
            .font(.headline)

        Text((widgetFamily == .systemSmall ? "" : "Next episode: ") +
            "\(entry.nextEpisode?.number ?? 0) of \(entry.show?.episodesInSeason ?? 0)")
            .font(.footnote)
            .foregroundColor(.gray)
    }

    var posterView: some View {
        Image(entry.show?.cover ?? "")
            .resizable()
            .frame(width: 120)
    }

    @ViewBuilder
    var timerView: some View {
        Text(entry.nextEpisode?.releaseDate ?? Date(), style: .timer)
            .minimumScaleFactor(0.3)
            .foregroundColor(Color.yellow.opacity(0.9))
            .font(.title)

        if (entry.configuration.hideDate?.boolValue != true) {
            Text(entry.nextEpisode?.releaseDate ?? Date(), style: .date)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }

    var countdownView: some View {
        ZStack {
            Color(white: 0.05, opacity: 1.0).ignoresSafeArea()

            HStack {
                if widgetFamily != .systemSmall { posterView }

                VStack(alignment: .leading, spacing: 5) {
                    headerView
                    Spacer()
                    timerView
                    Spacer()
                }
                .padding(.vertical, 16)
                .padding(.horizontal, widgetFamily == .systemSmall ? 16 : 24)

                Spacer()
            }
        }
        .foregroundColor(.white)
        .lineLimit(1)
        .widgetURL(URL(string: "tv://series?id=\(entry.show?.id ?? "")"))
    }

    func errorView(message: String) -> some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text(message)
                .padding()
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.white)
    }

    @ViewBuilder
    var body: some View {
        if entry.configuration.tvShow == nil {
            errorView(message: "Select a TV show from widget configuration")
        } else if entry.isError {
            errorView(message: "Could not get TV show")
        } else {
            countdownView
        }
    }
}

@main
struct EpisodeCountdownWidget: Widget {
    let kind: String = "EpisodeCountdown"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: EpisodeTimelineProvider()) { entry in
            EpisodeCountdownEntryView(entry: entry)
        }
        .configurationDisplayName("Episode Countdown")
        .description("Widget counts down time to the next episode.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct EpisodeCountdownWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EpisodeCountdownEntryView(entry: .preview())
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            EpisodeCountdownEntryView(entry: .preview())
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            EpisodeCountdownEntryView(entry: .preview())
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .redacted(reason: .placeholder)
        }
    }
}
