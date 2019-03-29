# Brownfield Of Dreams

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

In reality, this is a project we did at Turing where we had to add features to an existing code base. That code base intentionally had technical debt in it that we had to fix, including low test coverage and many violations of typical Ruby conventions. We added features that involved consuming a Github API on the Users dashboard to show followers and people the user is following, OAuth through Github, email activation and sending email invites. This is what it looks like after our two weeks of work!

## Local Setup

First you'll need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. There will be one failing spec if you don't have this set up.

Next, you will need two valid Github API keys (from actual Github users, i.e. you and a friend) to show the tests are passing. You will need to request these keys on Github's developer settings (under personal access tokens) and request user and repo scopes. These two examples will be defined within `ENV['ACCESS_TOKEN']` and `ENV['AT_2']`.

Additionally, you will need to request a client_id and client_secret from the OAuth apps tab under the same developer settings page on Github. You will need to make a new OAuth app and you can call it 'Brownfield of Dreams' and you will receive the id and secret. The id will be defined within `ENV['GITHUB_KEY']` and the secret will be `ENV['GITHUB_SECRET']`.

The final missing piece is Sendgrid. You will need to get a Sendgrid username and password from their website and those additionally will be defined within `ENV['SENDGRID_USERNAME']`, and `ENV['SENDGRID_PASSWORD']`, respectively.

For now, just hang on to these keys, store them in a safe, accessible, private place.

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
$ bundle update
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up your private environment
```
$ figaro install
```

Place your keys from before in your application.yml file
```
# in config/application.yml

YOUTUBE_API_KEY: <your youtube api key>

ACCESS_TOKEN: <your github personal access token>

AT_2: <your friend's github personal access token>

GITHUB_KEY: <your client id>

GITHUB_SECRET: <your client secret>

SENDGRID_USERNAME: <your sendrid user name>

SENDGRID_PASSWORD: <your sendgrid password>
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

## Test it!

Run the test suite:
```
$ rspec
```
If there is an error, try this:
```
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0

### Authors
Tim Allen
Julia Marco Oteros
