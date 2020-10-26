//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by Wojciech Kulik on 27/10/2020.
//

import Intents

final class IntentHandler: INExtension, ConfigurationIntentHandling {
    private let showsService = TvShowService()

    func provideTvShowOptionsCollection(
        for intent: ConfigurationIntent,
        searchTerm: String?,
        with completion: @escaping (INObjectCollection<IntentTvShow>?, Error?) -> Void
    ) {
        showsService.fetchTvShows { shows in
            let filtered = searchTerm == nil ? shows : shows.filter { $0.title.lowercased().contains(searchTerm?.lowercased() ?? "") }
            let items = filtered.map { IntentTvShow(identifier: $0.id, display: $0.title) }

            let result = INObjectCollection(items: items)
            completion(result, nil)
        }
    }
}
