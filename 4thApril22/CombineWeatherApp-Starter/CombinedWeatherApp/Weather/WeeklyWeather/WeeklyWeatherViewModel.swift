/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import Combine

class WeekyWeatherViewModel: ObservableObject, Identifiable {
  @Published var city: String = ""
  @Published var dataSource: [DailyWeatherRowViewModel] = []
  private let weatherFetcher: WeatherFetchable
  private var disposables = Set<AnyCancellable>()
  
  /*
   Add a scheduler parameter, so you can specify which queue the HTTP request will use.
   The city property uses the @Published property delegate so it acts like any other Publisher. This means it can be observed and can also make use of any other method that is available to Publisher.
   As soon as you create the observation, $city emits its first value. Since the first value is an empty string, you need to skip it to avoid an unintended network call.
   Use debounce(for:scheduler:) to provide a better user experience. Without it the fetchWeather would make a new HTTP request for every letter typed. debounce works by waiting half a second (0.5) until the user stops typing and finally sending a value. You can find a great visualization of this behavior at RxMarbles. You also pass scheduler as an argument, which means that any value emitted will be on that specific queue. Rule of thumb: You should process values on a background queue and deliver them on the main queue.
   You observe these events via sink(receiveValue:) and handle them with fetchWeather(forCity:) that you previously implemented.
   Finally, you store the cancelable as you did before.
*/
  
  init(weatherFetcher: WeatherFetcher,
       scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")) {
    self.weatherFetcher = weatherFetcher
    
    $city
      .dropFirst(1)
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      .sink(receiveValue: fetchWeather(forCity:))
      .store(in: &disposables)
  }
  
  func fetchWeather(forCity city: String) {
    weatherFetcher.weeklyWeatherForecast(forCity: city)
      .map { response in
        response.list.map(DailyWeatherRowViewModel.init)
      }
      .map(Array.removeDuplicates)
      .receive(on: DispatchQueue.main)
    
      .sink(receiveCompletion: {[weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure:
          self.dataSource = []
        case .finished:
          break
        }
      }, receiveValue: { [weak self] forecast in
        guard let self = self else { return }
        self.dataSource = forecast
      })
      .store(in: &disposables)
  }
  
}

extension WeekyWeatherViewModel {
  var currentWeatherView: some View {
    return WeeklyWeatherBuilder.makeCurrentWeatherView(withCity: city, weatherFetcher: weatherFetcher)
  }
}
