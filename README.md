# Contentful Recipe Display

## Overview
Display recipes from contentful

## Setup
install asdf plugins for postgres, nodejs, ruby

install yarn

`asdf install`

```
createdb `whoami`
createdb contentful_recipe_display_development
createdb contentful_recipe_display_test
```

`bundle`
`rails db:migrate`

`touch .env.local`
`touch .env.test.local`
add `ACCESS_TOKEN=` then your key to `.env.local` and `.env.test.local`

Do this again for `SPACE_ID=` and `ENV_ID=`.

In the future the .env steps should be refactored into an env template

to run specs:
`bundle exec rspec`

to use server:
`rails server`

navigate browser to localhost:3000 to see the recipe index

