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

    var body: some View {
        ZStack {
            HStack(spacing: 24) {
                if widgetFamily != .systemSmall {
                    Image(entry.show.cover)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .shadow(color: Color.black.opacity(0.2), radius: 3)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(entry.show.title)
                        .minimumScaleFactor(0.3)
                        .font(.headline)

                    Text((widgetFamily == .systemSmall ? "" : "Next episode: ") +
                        "\(entry.nextEpisode.number) of \(entry.show.episodesInSeason)")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()

                    Text(entry.nextEpisode.releaseDate, style: .timer)
                        .minimumScaleFactor(0.3)
                        .foregroundColor(Color.yellow.opacity(0.9))
                        .font(.title)

                    Text(entry.nextEpisode.releaseDate, style: .date)
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Spacer()
                }

                if widgetFamily == .systemMedium { Spacer() }
            }
            .padding(widgetFamily == .systemSmall ? 16 : 26)
        }
        .frame(width: .infinity, height: .infinity)
        .foregroundColor(.white)
        .lineLimit(1)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.black.opacity(0.86), Color.black]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .widgetURL(URL(string: "tv://series?id=\(entry.show.id)"))
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
