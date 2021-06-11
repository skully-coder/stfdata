# STFData

### This is an app developed for Wireframe, the UI/UX Challenge for Prometheus X, organized by IECSE.

The app is divided into three distinct parts:  
- **Social Media**:
    This part of the app utilises the `/social-media` endpoint of the API provided. Using the data provided by the API. There are two distinct sets of data:
    - *Posts*:
        Posts visualises the data taken from the `/posts` endpoint of the API and converts it into Cards, which when pressed on, navigates to the page dedicated to the particular post. The page also contains a feature to like the post by either double tapping the picture or on tapping the like button.
    - *Users*:
        Users visualises the data taken from the `/users` endpoint of the API and converts it into Cards, which when pressed on, navigates to the page dedicated to that particular user.
- **Stocks**:
    This part of the app utilises the `/stocks` endpoint of the API provided. Using the data provided by the API, the data is rendered into different Cards, unique to every Stock. On pressing the Card, the app navigates to the page for that stock, with all the data present, which was provided by the API.
- **Governments**:
    This part of the app utilises the `/institutes` endpoint of the API provided. Using the data provided by the API, the data is rendered into different Cards, unique to every Institute. On pressing the Card, the app navigates to the page for that Institute, with all the data present, which was provided by the API.