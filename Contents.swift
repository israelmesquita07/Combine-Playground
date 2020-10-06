
//  Created by Israel Pinheiro Mesquita on 06/10/20.

import Foundation
import Combine

enum WeatherError: String, Error {
    case itsColdToday = "It's Cold Today"
}

let weatherPublisher = PassthroughSubject<Int, WeatherError>()

let subscriber = weatherPublisher.filter { $0 > 25 }.sink(receiveCompletion: { error in
    print("It's not a good day to go out. Decipher the reason: \(error)")
}) { temperature in
        print("A good summer day with \(temperature) ºC")
}

weatherPublisher.send(30)
weatherPublisher.send(28)
weatherPublisher.send(10)
weatherPublisher.send(completion: Subscribers.Completion<WeatherError>.failure(.itsColdToday))
