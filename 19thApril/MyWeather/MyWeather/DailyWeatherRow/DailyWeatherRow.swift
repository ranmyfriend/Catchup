//
//  DailyWeatherRow.swift
//  MyWeather
//
//  Created by BKS-GGS on 19/04/22.
//

import SwiftUI

struct DailyWeatherRow: View {
  private let viewModel: DailyWeatherRowViewModel
  
  init(viewModel: DailyWeatherRowViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack {
      VStack {
        Text("\(viewModel.day)")
        Text("\(viewModel.month)")
      }
      
      VStack(alignment: .leading) {
        Text("\(viewModel.title)")
          .font(.body)
        Text("\(viewModel.fullDescription)")
          .font(.footnote)
      }
        .padding(.leading, 8)

      Spacer()

      Text("\(viewModel.temperature)°")
        .font(.title)
    }
  }
}

//struct DailyWeatherRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyWeatherRow()
//    }
//}
