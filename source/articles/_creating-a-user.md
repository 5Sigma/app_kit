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
