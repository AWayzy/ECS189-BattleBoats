# ECS189-BattleBoats
Tracking: https://trello.com/b/ap3arKXO/progress.

## Project Summary

We're going to build a game with rules similar to the famous Battleship board game. It will have three game modes:
1. User vs. AI
2. User vs. User (local device)
3. User vs. User (remote)*

*Depending on feasibility of implementation.

User vs. User (remote): The user finds a friend who is using the app. The two users will then be connected and will play against each other.

User vs. User (local): The user A will select the part of the grid he wants to attack and then the app will display a transition view so that they can pass the phone to user B without giving away their ship positions. User B plays, repeat.

User vs. AI: The user will play against an AI, potentially with different difficulty levels.

# Sprint Planning

## Week 2

Achievements: Created project foundation with several classes to model game components: https://github.com/AWayzy/ECS189-BattleBoats/commit/a8cf827acc8a186f30802dcca2791a3d4402a416. Added initial logic. Created Balsamiq screens to showcase potential elements of space on starting and game views.

Moving forward: Created several tasks aligning with one week's worth of development. Elected to focus on local and AI play before exploring feasibility of remote PvP game mode, due to portable nature of game states. Examined available Battleship-like apps on the market. Considering iOS TabView to show the user both own grid and enemy's with varied view permissions, distinct from any available version and unique to ours. Decided to create and modify screens directly on XCode for greater flexibility. This all naturally made for week-long tasks, divided amongst team members as organized on Trello.

Potential issues: Discussed merits and drawbacks of using large array of UIButtons vs. TableView component to serve as BattleBoats grid. Considered tradeoffs of  inefficiencies/inflexibilities between both methods. Time constraints and extensive nature of main features may stand in the way of future remote user vs. user mode implementation.

## Week 1

Brainstormed several ideas: Chess/Go Fish/Battleship, Trip Pricing app (Maps API), Diablo character stats, Document/Event Organizer.
Created Github repository.
Created Trello board.
Drafted proposal.
Discussed potential ideas moving forward:
1. Levels of difficulty of computer play.
2. Finding inexpensive means of hosting user profile data.
3. Transition view from User A to User B for local device head-to-head play.

Intention of beginning initial programming stages (launch screen, AI design) as early as this weekend/next week.
