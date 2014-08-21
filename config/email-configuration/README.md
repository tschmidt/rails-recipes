# Email Configuration

|Title|Description|
|-----|-----------|
|Rails Version|4.1.4|
|Gem Dependencies|none|

## Step 1

Set environment variables for your email configuration. This will include the `user_name`
and `password` at a minimum. You may also choose to put other information there as well.

The config file where you will add this information will depend on the type of shell you
use. For me, that will either be in a `.bashrc` or `.zshrc`. You should add lines that
look similar to this:

```
export MYAPP_EMAIL_USERNAME="some.email@some.dom"
export MYAPP_EMAIL_PASSWORD="for_realz_super_secrets_yo!"
```

What you choose to name the environment variable is really up to you. My advice to you is that you
use a consistent naming structure, especially on your development machine. I am typically
working on several applications at any given time which may require this type of setup.
Using a naming convention where I prefix with the name of the app and then the config key
has worked out fairly well.

Make sure to reload your shell after doing this so that the changes are picked up.

### If you use Pow for development

If you are using the Pow Server, you will need to create a `.powenv` file in your home
directory as well. In that file, add the same lines as above. Then, stop Pow. It [should]
automatically restart.

## Step 2

Open your project in your favorite editor. Then, open the `config/secrets.yml` file. Now,
add configuration that looks like this:

```yml
development:
  email_config:
    user_name: ENV["MYAPP_EMAIL_USERNAME"]
    password: ENV["MYAPP_EMAIL_USERNAME"]
```

Again, the keys that you give after `development` are up to you. I just think these make
sense.

## Step 3

There are 3 different environments that are set up by default when you create a new Rails
project: development, test and production. For each of these environments, you also get
a `config/environments/` file. You will need to add configuration to each of them depending
on your needs. View the `config/environments` files in this project to see how they should
be set up and why they are set up that way.

[Note] You can access the information you set up in Step 2 with `Rails.application.secrets.email_config['key']`.
