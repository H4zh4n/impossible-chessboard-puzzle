

# <img src="assets/icons/app_icon.png" width="24px"/> Impossible Chessboard Puzzle  <img src="https://i.imgur.com/uyWVRAa.png" width="24px"/> 

A project to play and test impossible chessboard puzzle

> **Support** : Android, iOS, macOS, Linux, Web, Windows

- **Web Live demo** : https://haxhan.web.app/impossible_chessboard_puzzle/
- **Windows + Android build** : [Release](https://github.com/H4zh4n/impossible-chessboard-puzzle/releases). 

### Game premise
The impossible chessboard puzzle is a mathematical puzzle in which a prisoner is shown a chessboard with 64 coins, each of which is showing either heads or tails. The prisoner is then allowed to flip one coin, and then another prisoner enters the room and must try to guess which square the warden hid the key under.

Detailed explanation at 3Blue1Brown :

[![3Blue1Brown](https://github.com/H4zh4n/impossible-chessboard-puzzle/assets/47919702/a6d0271e-8088-41fd-9caf-785c41e17fbb)](https://www.youtube.com/watch?v=wTJI_WuZSwE)

### App Functionalities
- ***Dynamic Board*** : The boards are all dynamic. you can setup the board anyway you like, and the entire explanations will be around that board configurations.
- ***WHAT!?*** : explains what you should flip for the second person. when you setup the board and select a key, touch **WHAT!?** and it will explain it step by step what you should do if you don't have the app.
- ***WHERE!?*** : Explains what the second person should do to find the key.
- ***Import/Export*** : Export or Import board configurations. [Fun boards at the bottom](#custom-boards).
- ***Reset*** : Resets the board all to tails.
- ***Random*** : Random board configuration.


### Interactions
In the main page
- Clicking/touching the tiles (H or T) will flip them from <img src="https://i.imgur.com/NCzrHiE.png" width="30px" /> to <img src="https://i.imgur.com/bkYywhv.png" width="30px" /> and vice versa.

- Holding/Right clicking the tiles will place or remove the key. the key tile will be RED once placed. <img src="https://i.imgur.com/kbtNMWC.png" width="30px" />


- The Tile with the green background means that's the tile that needs to be flipped. <img src="https://i.imgur.com/ugaLrOS.png" width="30px" />




### UI
<img src="https://i.imgur.com/Or4Uqvq.png" width="30%"/> <img src="https://i.imgur.com/wlxzVjQ.png" width="30%"/> <img src="https://i.imgur.com/GRNp4Ds.png" width="30%"/>  



## Custom boards

#### *Mirrored*
Has a pleasing look when you place the key on the top 4 rows, the tile flip is always set at the same relative position at the bottom 4 rows. When key placed at the bottom 4 rows flip tiles is market on the above 4 rows same position.

```  
t t t t t h t t  
h t h h t t t t  
t h h t t h h h  
t t h h h h t t  
t h h h t h t t  
t h h t h h t h  
t t h h t t h t  
h t h t t t h t  
```
![mirror](https://github.com/H4zh4n/impossible-chessboard-puzzle/assets/47919702/d249e225-3aa5-4dc3-8149-824f99d787ae)
