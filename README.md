# Trivia
A trivia game app built with MVVM leveraging Alamofire, SwiftyJSON, Combine, Unit Testing, and Realm. 

![Trivia Portfolio x3 small](https://user-images.githubusercontent.com/25728996/125000673-862e0f80-e016-11eb-90d9-b539b8327ea4.png)

## Details
- 100% programmatic, no storyboards
- The `TriviaService` class utilizes Alamofire's request method to retrieve a random question from the opentdb API.
- The view models conform to the `ObservableObject` protocol to notify the views of new data
- Swift Package Manager to manage library dependencies
- Relies heavily on Dependency Injection to make it easier to unit test
- Uses Realm to save a user's progress
- Utilizes Realm's `NotificationToken`s to response to updated objects
- Uses SwiftyJSON to parse out the returned JSON from the opentdb API
- Appropiately places realm writes in a do catch block
- `AnimatedCountingLabel`, a subclass of `UILabel`, uses `CADisplayLink` to animate the change in value after answering a question

## Dependencies
- Realm
- Alamofire
- SwiftyJSON

## Other notable technologies
- Apple's Combine framework
- MVVM pattern
- XCTest
