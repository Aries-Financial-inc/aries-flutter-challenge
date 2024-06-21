
## Brief

Your challenge is to create a Flutter component that can generate a risk & reward graph for options strategies. The component should accept an input of up to four options contracts and output the following:
1. A risk & reward graph where X is the price of the underlying at the time of expiry and Y is the profit/loss at that price. 
2. Max profit, max loss, and all break even points.

### Screenshot:
<img src="screen_shots/home.png?raw=true" width="300">

### App Profiling Result
No Jank found, App can run smoothly at 60-FPS


### Architecture
#### Clean architecture along with SOLID principles has been utilised

###     View
        Strictly only UI elements (No state or logic here)

###     Controller
        Handles the UI state and logic

###     Repository
        controls the data flow

###     Model
        data classes

###     Service
        fetches data from various sources 

#### State management used: GET-X
