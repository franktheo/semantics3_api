**Notes**
- Using rvm version 2.3.1
- Please register to get semantic3 API key and secret 
  and set them in your ~/.bashrc or a similar file
- Using jsonb in conjuntion with postgres 
  to store dynamic data obtained from semantics3
  Please use postgres version 9.4 or higher to take 
  advantage of this feature
- Please send me notes for enhancement requests or if you have
  questions.

**Gems used**
- semantics3-api 
- kaminari for pagination
- pg for database
- bootstrap-sass for layout
- brakeman for sanity check
- rack-mini-profiler for profiling
- simplecov for code coverage
- for testing
  selenium-webdriver
  capybara
  rspec-rails
  chromedriver-helper
  rails-controller-testing
  factory_girl_rails

**Running the app
- rvm use 2.3.1
- source ~/.bashrc (or similar file)
- start postgres server
- createdb development_semantic3_api
  createdb test_semantic3_api
- rake db:migrate
- rake db:seed (modify it as needed)
- rails s
- rake db:migrate RAILS_ENV=test
- rake db:seed RAILS_ENV=test
- rspec (for testing)
- view coverage/index.html for code coverage
- brakeman -5 -A

**rspec run
You should see something similar to:
Finished in 1 minute 10.83 seconds (files took 2.47 seconds to load)
25 examples, 0 failures

Coverage report generated for RSpec to ../coverage. 309 / 309 LOC (100.0%) covered.

**Brakeman run
+-------------------+-------+
| Scanned/Reported  | Total |
+-------------------+-------+
| Controllers       | 4     |
| Models            | 3     |
| Templates         | 10    |
| Errors            | 0     |
| Security Warnings | 0 (0) |
+-------------------+-------+