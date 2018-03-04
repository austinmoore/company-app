Company App
================

Simple implementation of a programming challenge in which companies have many
employees. Both companies and employees have a similar but slightly different
unique token.

Requirements
-------------

This application requires:

- Ruby 2.5.0
- Postgres 9.x+

Getting Started
---------------

1. Install the dependencies: `bundle install`
1. Create the development and test databases: `bin/rails db:create db:migrate db:test:prepare`
1. Run the specs to confirm everything is working: `bundle exec rspec`
1. Start the web server: `bin/rails server`
1. Point your browser to `http://localhost:3000`

Notes
-----

I created a large chunk of the code with the following three commands:

1. `rails new company-app --skip-action-cable --skip-turbolinks --skip-coffee --skip-spring -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb`
2. `bin/rails g scaffold company name:string --no-routing-specs --no-helper-specs --no-view-specs`
3. `bin/rails g nested_scaffold company/employee first_name:string last_name:string --no-routing-specs --no-helper-specs --no-view-specs`

I chose to use scaffolds in this app, because the "main part" of the app is
  the token generation and not the UI.
  
Since this is a small app, I chose to implement the token generation as a mixin
  which uses ActiveRecord callbacks on the model. This is probably the simplest
  solution. If the project was larger, then I would recommend encapsulating the
  company/employee creation in service objects that call the token generator
  explicitly (i.e. instead of via callbacks). If the project would use
  [CQRS](https://martinfowler.com/bliki/CQRS.html) and 
  [event sourcing](https://martinfowler.com/eaaDev/EventSourcing.html) (i.e.
  persist the events instead of just the latest state), then I would
  implement it asynchronously as a 
  [process manager](https://medium.com/@drozzy/long-running-processes-event-sourcing-cqrs-c87fbb2ca644).
  
This is *not a production ready app*. At least the following things are missing:
 
* Use [rubocop](https://github.com/bbatsov/rubocop) to enforce a common style guide
* Everything must be [localized](http://guides.rubyonrails.org/i18n.html)
* Consider using client side rendering (e.g. https://reactjs.org/) + server
  side API instead of server side rendering
* Use UUIDs instead of integers for ids (especially if they are going to be 
  exposed by an API)
* Use [foreman](https://github.com/ddollar/foreman) for starting the web server 
  (and other processes)
* Always soft-delete instead of hard-delete on destroy action
* [Paginate](https://github.com/kaminari/kaminari) all results in views
* Add request specs if the backend implements an API 
* Use namespaces for all modules/classes
* [Exception logging](https://github.com/rollbar/rollbar-gem)
* [Performance monitoring](https://github.com/newrelic/rpm)
