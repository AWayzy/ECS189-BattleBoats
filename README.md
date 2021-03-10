# ECS189-BattleBoats

## Project Summary

We're going to build a game with rules similar to the famous Battleship board game. It will have three* game modes:
1. User vs. User (remote)
2. *User vs. User (local device)
3. *User vs. AI

*Dependent on timeline. Stretch goals.

*User vs. User (remote): The user finds a friend who is using the app. The two users will then be connected and will play against each other.

*User vs. User (local): The user A will select the part of the grid he wants to attack and then the app will display a transition view so that they can pass the phone to user B without giving away their ship positions. User B plays, repeat.

User vs. AI: The user will play against an AI, potentially with different difficulty levels.

### Installation Notes

Make sure that once either player has moved on to his Setup screen, that he does not quit the app or move it to the background. BattleBoats is to be played in real time until completion, at the risk of unexpected behavior otherwise.

## Trello Board

Link: https://trello.com/b/ap3arKXO/progress.

## Team Members and Roles

Matthew Afshin (matthewafshin). Role: Initial designs. Played point for developing backend. Designed database and methods for realtime observation.

<img src="https://cdn.discordapp.com/attachments/813565377992196136/813568929493549087/2021-02-22-163156.jpg" width="200" height="150">

Noah Cordova (mrcordova). Role: Led UI design. Created solutions to represent and manipulate ship and board objects.

<img src="https://cdn.discordapp.com/attachments/813565377992196136/813567090581176346/IMG_20210222_162418815_MP.jpg" width="150" height="200">

Dhruva Eswar (officialfuggie). Role: UX. Haptic feedback patterns for feel, navigation. Iterated on structure of and communication to DB.

<img src="https://cdn.discordapp.com/attachments/800862001122508842/813625991658209340/IMG_1716.jpg" width="150" height="200">

Zilin Peng (ZilinPeng). Role: Led testing efforts. Finalized UI/UX. Supported research and development of backend.

<img src="https://cdn.discordapp.com/attachments/813565377992196136/813568654452588544/Photo_on_9-6-20_at_3.59_AM.jpg" width="225" height="150">

Austin Way (AWayzy). Role: Spearheaded gameplay implementation. Codified board data for client-server communication. Created foundation and MVP.

<img src="https://cdn.discordapp.com/attachments/800862001122508842/813642710191833129/image0.png" width="150" height="200">

## Sprint Planning 5

Achievements: Host game room and find game by room. Backend fully developed; readers and listeners implemented to collect and send updates. UI fleshed out to adjust to user screens. All navigation in place for naturally advancing game flow. Several controlled actions tested in realtime. Merges up to date as of now.

Moving forward: Minor design changes. Maintain a local board representation to catch and conditionally display updates. Haptic feedback in gameplay (hit, miss, sink). Cycle views (start->..->end->start). Exhaustive testing. Clean up the base and merge everything.

Potential issues: Possible haptic feedback lag when diplaying an opponent's play on your board. Trouble displaying a portion of a ship, as currently constructed.

## Sprint Planning 4

Achievements: Created distinct haptic patterns for each Battleship action, and incorporated vibrations into board setup to "magically" mimic live play. Created Firebase project and designed structure for DB game representation, including recent move information for each player. Added all methods for initial board setup, making for a runnable, partially functional app. Added more view navigation and transitions. Saved board data locally, for necessary DB extractions and updates.

Moving forward: Remaining screens and UI design across the board. Realtime updates and reads from the server. Finding opponents by phone number. Adding the game logic once all other components are in place. Wider incorporation of magic moments (haptics) once server setup and gameplay are firmer. Merge final modifications from all existing branches. Endgame logic.

Potential issues: Timeline may restrict ability to implement customizable usernames. Minor bugs on setup page. Limited knowledge of bringing external images and drawings to use in place of current rectangular objects. Constraints not yet set up.

## Milestone 2

### Sprint Planning 3

Achievements: Elected to move forward with "magic moment" of various haptic feedback responses to key Battleship actions (hit, sink, miss). Created the grid as grouped set of independent Views, allowing for tap gestures and streamlined move tracking. Pivoted to begin with a remote play mode, flipping local play to a stretch goal.

Moving forward: Merge current existing game logic with newly developed board representation. Allow for initial board setup upon start game. Save state of each square and of overall board (with respect to integrity of placed ships) in some data structure. Determine how to send this information to linked opponent once a player has made his move. Save user profile (phone number) on server, and potentially allow username updates. Link players together via server request. Configure haptic feedback previously described. 

Potential issues: None of us have worked with Firebase before, so wiring up the BB server and user database is currently viewed as a blocked task.

## Milestone 1

### Screens

See design files in main branch: https://github.com/AWayzy/ECS189-BattleBoats/tree/main/Designs.

### Third-Party Libraries

We don't intend to use any third-party libraries to develop this app.

### Server Support

By nature, BattleBoats would only require a server and stored user data in a remote User-User game mode. As this play option is a stretch goal at this time and at the back of the priority queue, we are not currently pursuing server support.

### Models

Board: Two-dimensional array of UI buttons. Individual button attributes (interaction, color) determine whose board (Player, AIPlayer/Player (enemy)) is being viewed, hits, misses, and full sinks. Accompanying 2D array of button attributes map directly to the grid. Board updates each time the attrubutes matrix changes. Each player initializes own board configuration on Setup page.

Player: Has two boards, one for his own and one with fewer read permissions to represent his enemy's grid. Actions for AIPlayer are automated, and initial board is randomized, but AIPlayer is basically a Player.

### ViewControllers and Navigation

HomeView --(bool local_mode/AI_mode)--> SetupView --(Board initial_boards[])--> GameView <-> TransitionView -> GameOverView

### Tasks

Organized on Trello: https://trello.com/b/ap3arKXO/progress.

### Testing Plan

Detailed here: https://github.com/AWayzy/ECS189-BattleBoats/blob/main/Testing.md.

## Sprint Planning 2

Achievements: Created project foundation with several classes to model game components: https://github.com/AWayzy/ECS189-BattleBoats/commit/a8cf827acc8a186f30802dcca2791a3d4402a416. Added initial logic. Created Balsamiq screens to showcase potential elements of space on starting and game views.

Moving forward: Created several tasks aligning with one week's worth of development. Elected to focus on local and AI play before exploring feasibility of remote PvP game mode, due to portable nature of game states. Examined available Battleship-like apps on the market. Considering iOS TabView to show the user both own grid and enemy's with varied view permissions, distinct from any available version and unique to ours. Decided to create and modify screens directly on XCode for greater flexibility. This all naturally made for week-long tasks, divided amongst team members as organized on Trello: https://trello.com/b/ap3arKXO/progress.

Potential issues: Discussed merits and drawbacks of using large array of UIButtons vs. TableView component to serve as BattleBoats grid. Considered tradeoffs of  inefficiencies/inflexibilities between both methods. Time constraints and extensive nature of main features may stand in the way of future remote user vs. user mode implementation.

## Sprint Planning 1

Brainstormed several ideas: Chess/Go Fish/Battleship, Trip Pricing app (Maps API), Diablo character stats, Document/Event Organizer.
Created Github repository.
Created Trello board.
Drafted proposal.
Discussed potential ideas moving forward:
1. Levels of difficulty of computer play.
2. Finding inexpensive means of hosting user profile data.
3. Transition view from User A to User B for local device head-to-head play.

Intention of beginning initial programming stages (launch screen, AI design) as early as this weekend/next week.
