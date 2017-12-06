# Coin-portfolio - iOs app

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
