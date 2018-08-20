# Hackathon Organizer [![Code Climate](https://codeclimate.com/github/rafaelbiriba/hackathon_organizer/badges/gpa.svg)](https://codeclimate.com/github/rafaelbiriba/hackathon_organizer) [![Travis](https://api.travis-ci.org/rafaelbiriba/hackathon_organizer.svg?branch=master)](https://travis-ci.org/rafaelbiriba/hackathon_organizer) [![Coverage Status](https://coveralls.io/repos/rafaelbiriba/hackathon_organizer/badge.svg?branch=master&service=github)](https://coveralls.io/github/rafaelbiriba/hackathon_organizer?branch=master)

Small rails app that receives Hackathon ideas and also to subscribe the developers into it.

*NOTE*: The application is still under development, but it **is stable to use**.

**Grab the lastest release at:
https://github.com/rafaelbiriba/hackathon_organizer/releases**

If you have any question about how to use the application, just reach me out!

## Prerequisites

- Google account for the login/access to the website
- Create a project at Google to get the GOOGLE_OAUTH_ID and GOOGLE_OAUTH_SECRET. (Details below)

### Creating the Google OAUTH Credentials

- Access `https://console.developers.google.com/apis/` and create your app there.
- Go to `Create credentials` > `Oauth Client ID` > `Web Application`
- Fill the information of your website url and your website oauth callback (Examples: http://example.com and http://example.com/auth/google_oauth2/callback)
- Extra step: Don't forget to add HTTP and HTTPS urls if this is your scenario.

## Installation

**Detailed documentation comming soon.**

Installation for a normal Rails app with Postgresql. (Recommended: Heroku with Postgresql plugin)

After deployment:
- Create the settings for production. (check `config/settings/production.yml.example` for the configuration file example)
- Setup the database yml for production Postgresql. (check `config/database.yml.production`)
- Run `rake db:prepare` (will create the db, load the schema and run the migrations)
- Run `rake users:give_superuser[example@mail.com]` to give the superuser admin to `example@mail.com`.

## TODO/Backlog List

- [HIGH] Finish the test coverage
- [HIGH] Refactor the controller (specially the projects)
- [HIGH] Add proper documentation
- [HIGH] Rename Subscribers to Workers, because is kind confusing
- [MID] Add kubernetes or ansible or [type-name-here] to automate the deploy (Today only supports Heroku)
- [MID] Add Edition concept (so we can have the history from previous hackathon)
- [MID] With the history, introduce a way to clone or copy old ideas into the running hackathon.
- [LOW] Add mentions at comments
- [LOW] Add notifications via email
- [LOW] Add my profile page (customize name, picture, and other preferences)
- [LOW] Support for Facebook login
- [LOW] Add a bug report feature (or at least a link for a github page)
- [LOW] Move this todo list to github issues

## Screenshots

**Detailed documentation comming soon.**

![Project list view](https://github.com/rafaelbiriba/hackathon_organizer/blob/master/docs/images/list.png)

![Project show view](https://github.com/rafaelbiriba/hackathon_organizer/blob/master/docs/images/show.png)

## Contributing

First of all, **thank you** for wanting to help!

1. [Fork it](https://help.github.com/articles/fork-a-repo).
2. Create a feature branch - `git checkout -b more_magic`
3. Add tests and make your changes
4. Check if tests are ok - `rake spec`
5. Commit changes - `git commit -am "Added more magic"`
6. Push to Github - `git push origin more_magic`
7. Send a [pull request](https://help.github.com/articles/using-pull-requests)! :heart:

### Development Notes

#### Switching Users

Only for development environment, you can easily switch users using `?user=<id>` at the url. This will switch the logged user on-the-fly. (Example: `http://localhost:3000/projects?user=3`)

#### Populating the Database

The file `seed.rb` is responsible to populate the database with a lot of dummy data. You can use this to create an functional application and test things around. You can run it using `rake db:seed`
