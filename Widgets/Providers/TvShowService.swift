//
//  TvShowService.swift
//  WidgetKit Demo
//
//  Created by Wojciech Kulik on 26/10/2020.
//

import Foundation

final class TvShowService {
    func fetchTvShows(completion: @escaping ([TvShow]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion([.previewGameOfThrones, .previewBreakingBad])
        }
    }
}
