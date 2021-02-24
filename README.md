# ECS189-BattleBoats

## Project Summary

We're going to build a game with rules similar to the famous Battleship board game. It will have three game modes:
1. User vs. AI
2. User vs. User (local device)
3. *User vs. User (remote)

*Dependent on feasibility of implementation.

User vs. User (remote): The user finds a friend who is using the app. The two users will then be connected and will play against each other.

User vs. User (local): The user A will select the part of the grid he wants to attack and then the app will display a transition view so that they can pass the phone to user B without giving away their ship positions. User B plays, repeat.

User vs. AI: The user will play against an AI, potentially with different difficulty levels.

## Trello Board

Link: https://trello.com/b/ap3arKXO/progress.

## Team Members

Matthew Afshin (matthewafshin)

<img src="https://cdn.discordapp.com/attachments/813565377992196136/813568929493549087/2021-02-22-163156.jpg" width="200" height="150">

Noah Cordova (mrcordova)

<img src="https://cdn.discordapp.com/attachments/813565377992196136/813567090581176346/IMG_20210222_162418815_MP.jpg" width="150" height="200">

Dhruva Eswar (officialfuggie)

<img src="https://cdn.discordapp.com/attachments/800862001122508842/813625991658209340/IMG_1716.jpg" width="150" height="200">

Zilin Peng (ZilinPeng)

<img src="https://cdn.discordapp.com/attachments/813565377992196136/813568654452588544/Photo_on_9-6-20_at_3.59_AM.jpg" width="225" height="150">

Austin Way (AWayzy)

<img src="https://cdn.discordapp.com/attachments/800862001122508842/813642710191833129/image0.png" width="150" height="200">

## Sprint Planning 5

Achievements: 

Moving forward: 

Potential issues: 

## Sprint Planning 4

Achievements: 

Moving forward: 

Potential issues: 

## Milestone 2

## Sprint Planning 3

Achievements: 

Moving forward: 

Potential issues: 

## Milestone 1

### Screens

See design files in main branch: https://github.com/AWayzy/ECS189-BattleBoats/tree/main/Designs.

### Third-Party Libraries

We don't intend to use any third-party libraries to develop this app.

### Server Support

By nature, BattleBoats would only require a server and stored user data in a remote User-User game mode. As this play option is a stretch goal and at the back of the priority queue, we are not pursuing server support at this time.

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
