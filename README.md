# MovieViewer
asmt1 for CodePathU


# Project 1 - Movie Viewer

MovieViewer is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: ~20 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [X] Customize the UI.

The following **additional** features are implemented:

- [X] user may switch between TableView and CollectionView via a TabBarController

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Basic procedure is followed but what we're actually doing may be lost. Knowing why you do something can be just as important as knowing you need to do it.
2. How to better implement displaying the Network Error. Also implementing the Search Functionality.

## Video Walkthrough 

[Here's a walkthrough of implemented user stories](http://i.imgur.com/xVbJXST.gif):

<img src='http://i.imgur.com/xVbJXST.gif' title='Movie Viewer Walkthrough' width='250' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Right now the display of my Network Error technically works but it is a little bit janky.

Images Used:
Warning by Dalpat Prajapati from the Noun Project


## License

    Copyright 2016 Dustyn Buchanan August

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
