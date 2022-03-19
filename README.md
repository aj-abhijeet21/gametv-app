# gametv_app

A new Flutter GameTV project.

This project utilizes API from http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all

Also features a login screen, input validation, and authentication service mocked on API https://gametv.free.beeceptor.com/auth?user=username&pass=password

This project uses http package for fetching data from API, also uses shared_preferences to store the username of currently logged in user.

Provider Pattern is used for State Management.

  User 1: 9898989898 / password123
  User 2: 9876543210 / password123