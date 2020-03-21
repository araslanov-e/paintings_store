# API для магазина картин
## Setup

    $ bundle
    $ bundle exec rake db:migrate db:seeds

## Run
    
    $ puma -p 3000


## Test
  
    $ RACK_ENV=test bundle exec rake db:migrate
    $ rspec
