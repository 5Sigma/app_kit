<a id="getting-started" name="getting-started"></a>

###Getting started
AppKit was built to quickly generate web based data
applications. It is excellent at prototyping or building
transient internal tools.

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

<a id="create-user" name="create-user"></a>
####Creating a user

You will need to create a new AppKit user to be able to login
to your application. The easiest way to do this for the
first time is from the rails console.

    rails console
    AppKit::User.create(
      first_name: 'John',
      last_name: 'Doe',
      password: 'some passphrase',
      password_confirmation: 'some passphrase'
    )

This will setup your first user so you will be able to
login. AppKit uses [Devise](http://devise.plataformatec.com.br)
to handle authentication.

