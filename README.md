# HomWork-3

# DB Browser for SQLite Screenshot

<img width="807" alt="Screen Shot 2022-09-26 at 14 56 25" src="https://user-images.githubusercontent.com/91742636/192270608-f1b862e9-b731-4999-8d26-3dc90104e5cc.png">


<img width="1404" alt="Screen Shot 2022-09-25 at 16 40 29" src="https://user-images.githubusercontent.com/91742636/192146684-703dab74-523c-4446-a03e-c9c5ad41f250.png">

# Code 
 ```swift
  func applicationDocumentsDirectory() {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "yo.BlogReaderApp" in the application's documents directory.
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }

 ```
 
