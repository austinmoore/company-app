Company App
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.5.0
- Rails 5.1.5

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Documentation and Support
-------------------------

rails new company-app --skip-action-cable --skip-turbolinks --skip-coffee --skip-spring -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb
rails g scaffold company name:string --no-routing-specs --no-helper-specs --no-view-specs
bin/rails g nested_scaffold company/employee first_name:string last_name:string --no-routing-specs --no-helper-specs --no-view-specs

Changes I would make to a production app:
* Use rubocop
* Localize everything


Issues
-------------

* (DONE) CRUD for companies: name
* CRUD for employees: first_name, last_name
** employee belongs to company
* Generate identity tokens
** Token must be unique but only within a class scope (i.e. employee and company
   could possibly have the same token if the format would be the same)
** Token is randomly generated from capital letters of English alphabet of 
   configured length with a configured delimiter for a configured attribute
** companies.identity ABCD:EFGH -> two-block token with ‘:’ used as delimiter
** employees.identifier ABCD-EFGH-IJKL -> three-block token with ‘-’ used as delimiter
* README
* tests
** unit
** system

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------
