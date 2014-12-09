<a id="adding-appkit" name="adding-appkit"></a>
####Adding AppKit to a project
After creating a new rails application simply add AppKit to your
`Gemfile` and run the install generator.

Edit the file `Gemfile` in the root of the application directory
and add:

    gem 'app_kit'

After the gem has been included in your `Gemfile` then run
bundler and the installation generator:

    bundle
    rails g app_kit:install

This will do a few things. First an initialization file will be
created located at `PROJECT/config/initializer/app_kit.rb`.
Second, a migration will be created for storing users.
Finally, A line will be added to your `config/routes.rb` to
mount the AppKit engine at `/`.
