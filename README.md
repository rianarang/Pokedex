# Pokedex

## A bit about the app
This Pokedex uses a simple architecture where we have Repositories to abstract network requests, allowing them to be reused by multiple ViewModels. The ViewModel does what ViewModels do, business logic and whatnot, you know the deal. Then we have the Views which house all the SwiftUI, they sit still and look pretty while the VM's do all the heavy lifting.

The app implements pagination by checking if we are at the bottom of the current list, if this is true it triggers the ViewModels loadMoreData function which keeps track of the current page and updates the offset accordingly. 
Shoutout to this Youtube Video: [Pagination in SwiftUI with LazyVGrid](https://youtu.be/hluc9h0uVXI)

Lastly, the Images are loaded using one of the SwiftPackageManager Packages 'URLImage'. This package handles standard HTTP caching protocols for me :)


## demo video!

[Pokedex Demo](https://youtube.com/shorts/JChwobT0-lo?feature=share)

## If I had more time...
- I would add unit testing
- SwiftUI Previews
- Better handling of state variables, if feels a bit of a mess right now
- Better UI (this would involve me pulling some more stats and making it prettier)
