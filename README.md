# Coin-portfolio - iOs app (PG5600 exam)
## 0 App description
Crypto currencies portfolio with features to add/remove and check trend of current portfolio. Demo application for people to try crypto currency market without material risk.

## 1 Settings
* SWIFT 4
* Xcode 9.2

## 2 Pods
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## 3 Diagram
Application core is two services
* CoreDataService - db communications
* ApiDataService - external api communications  
I used two representation of data for valuta and portfolio item for decoupling
![Diagram](./screenshot/app-diagram.png)

## 4 Task
I fulfilled all requirenments for given exam tasks. I also implemented reveal view using trird party library. I mock login/registration feature and leave it for future improvements. Also I played with creating my own gradient element.

## 5 Comments
For refresh I used button, which call ApiDataService and refresh current list of valutas -> it is sync refresh for PortfolioVC and MarketVC. Cell in portfolio are editable, means user can swipe on cell and see additional menu.
