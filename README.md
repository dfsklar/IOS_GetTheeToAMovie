# Movie Catalog ("Rotten Tomatoes")

This is a movie-info browser application for iOS submitted as the Week 1 assignment for CodePath.

Time spent: 16 hours

Mandatory features completed:

* YES: User can view a list of movies. Poster images must be loading asynchronously.
* YES: User can view movie details by tapping on a cell.
* YES: User sees loading state while waiting for movies API.
* YES: User sees error message when there's a networking error.
* YES: User can pull to refresh the movie list.  (The reload is real, not simulated.)

Optional features completed:

* On Details page, low-res is loaded immediately and the high-res is loaded as soon as available

Future topics that I experimented with:

* The entire layout uses constraint-based auto-computed layout so runs well on any device form factor.  (This led to dozens of "misplaced view" warnings, and I do need guidance on how to let the system know that layout will be algorithmic so it will know to refrain from showing those those inaccurate warning messages.)


![Video Walkthrough](SklarDavid-Tumblr-MovieCatalog.gif)


Note that the reload is real, so recovering from temporary network failures is possible without rebooting the app.  In the video shown below, the app is started with the wifi turned off... the failure is reported to the user... I then re-enabled wifi... and used the swipe-down refresh gesture to perform a reload.

![Video Walkthrough](SklarDavid-Tumblr-MovieCatalog-networkerror.gif)
