# Trivia
A trivia game app built with MVVM leveraging Alamofire, SwiftyJSON, Combine, Unit Testing, and Realm. 

TODO: Add screenshot here

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

## Dependencies
- Realm
- Alamofire
- SwiftyJSON

## Other notable technologies
- Apple's Combine framework
- MVVM pattern
- XCTest
