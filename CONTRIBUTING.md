## Contributing

### Code of conduct

We aspire to create a welcoming environment for collaboration on this project.
To that end, we follow the [18F Code of
Conduct](https://github.com/18F/code-of-conduct/blob/master/code-of-conduct.md)
and ask that all contributors do the same.

### Not sure what to work on?

Issues that are ready for contributions are tagged with [help
wanted](https://github.com/18F/dolores-landingham-bot/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22).

Comment on the issue you're working on so we all know who is working on what.

If you're thinking about working on a feature unrelated to an existing issue,
consider creating an issue before you start work to get feedback from the team.
We are always happy to receive pull requests but don't want anyone to feel like
they wasted time if a pull request is submitted but not merged.

### Git Protocol

To contribute to this project, people internal to 18F can create a branch and
submit a pull request. If you are external to 18F, you can fork the repository
and submit a pull request that way.

We are minimizing commits on the `master` branch by rebasing and squashing
commits on branches before merging them into `master`. This will require you to
force push on your branch (but not to `master`...please don't force push
`master`).

For a more detailed walk through on how to do this, you can read thoughtbot's
[Git Protocol](https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature)
document.

18F-ers can merge their changes into `develop` after getting approval from
another contributor. After a PR has been merged into `develop`, it is
automatically deployed to staging by Travis. After changes have been verified on
staging, the commits can be merged into `master` and Travis will deploy the
changes to production.

PRs can be merged manually by merging the branch locally and pushing or by using
the merge button on GitHub.

### Managing time / Updating holidays

Each message created will send a specified number of **business days** after an
employee joins 18F.  What constitutes a business day is managed by the gem
`business_time` and is configured [here](config/initializers/business_time.rb)
and [here](config/business_time.yml). To add days that dolores will skip, add
that date to the `holidays` field in [this yaml config
file](config/business_time.yml).

### Vagrant setup

A [Vagrant](http://vagrantup.com) configuration is available that creates a
local server preconfigured with all the dependencies required by this project.

To use vagrant for development:

```
# Provision a new virtual server in VirtualBox (installs postgres, other
# dependencies, and sets up the project's database)
vagrant up

# connect to the server to run foreman, run tests, etc:
vagrant ssh

# Vagrant shares your project's directory with the virtual server in the
# /vagrant directory:
cd /vagrant

# run tests
rake

# Vagrant maps port 5000 of the virtual server to localhost:5000, so it seems
# like you are running the project locally:
foreman start
```

### App setup

To get started, run `bin/setup`

Prior to running `bin/setup`, it may be necessary to launch the postgres server using

```bash
postgres -D /usr/local/var/postgres
```

You can also use the [Postgres OSX app](http://postgresapp.com/).

If bin/setup fails with the following error message:

```bash
fe_sendauth: no password supplied
Couldn't create database for {"adapter"=>"postgresql", "database"=>"postgres", "encoding"=>"utf8", "host"=>"localhost", "min_messages"=>"warning", "pool"=>5, "reaping_frequency"=>10, "timeout"=>5000}
rake aborted!
```

check your database.yml file. You might need to set database credentials (i.e.,username:<uname>, password:<pw>)

After setting up, you can run the application using [foreman]:

```bash
foreman start
```

[foreman]: https://github.com/ddollar/foreman

The application will run locally at http://localhost:5000/.

If you have previously run a project on a different port, a `.foreman` file
may be generated at the root of your directory. If so, make sure that this
file is set to port `5000` or you will be unable to authenticate locally with MyUSA.

If your server isn't defaulting to Port 5000, you may have to add a .foreman
file to root directory. In the file, add `port: 5000`.

### Testing

Testing is done using `capybara-poltergeist`, which requires a local install of
[phantomjs](https://github.com/jonleighton/poltergeist#installing-phantomjs).
You can run the entire test suite using:

```bash
rake
```

### Required Keys

The setup script creates a `.env` file with a dummy environment configuration
variables.  If you are internal to 18F and would like access to these configs,
you can contact Jessie Young. Otherwise, you can create a Slack bot
[here](https://18f.slack.com/services/new/bot).

#### Slack application

Create a [Slack application](https://api.slack.com/apps).

1. Set the [display name](https://api.slack.com/apps/A016530DGA0/app-home) to "Mrs. Landingham" (or another value of your choice)

1. Grant the `im:write` and `users:read` scopes

1. Obtain the value for `SLACK_API_TOKEN` from "Bot User OAuth Access Token" on [OAuth & Permissions](https://api.slack.com/apps/A016530DGA0/oauth).

1. Install the application to your workspace

#### Secret key base

Generate a value for `SECRET_KEY_BASE` by running `rake secret`.

#### GitHub authentication

We are using [OmniAuth GitHub Team
Auth](https://github.com/jonmagic/omniauth-github-team-member) for
authentication.

1. Create a [GitHub OAuth application](https://github.com/settings/developers)
for development with the following:

  For Homepage url:

  `http://localhost:5000/`

  Authorization callback URL:

  `http://localhost:5000/auth/githubteammember/callback`

1. Obtain the value for `GITHUB_CLIENT_ID` from `Client ID` on your application page.

1. Obtain the value for `GITHUB_CLIENT_SECRET` from `Client Secret` on your application page.

1. Obtain the value for `GITHUB_TEAM_ID` from the GitHub API:

1.1 Generate an [access
token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
and then obtain with it:

```bash
curl https://api.github.com/user/teams -H 'Authorization: token YOUR_ACCESS_TOKEN'
```

If you do not belong to a GitHub team or would like to set up the app without
doing the above, an alternative is to comment out the line in the controller
that confirms you are a member of the correct team:

```ruby
  # app/controllers/auth_controller

  def oauth_callback
    # if team_member?
      dev_test_email = "your_email@example.com"
      user = User.find_or_create_by(email: dev_test_email)
      sign_in(user)
      flash[:success] = "You successfully signed in"
      redirect_to root_path
    # end
  end
```

## Granting Yourself Admin Access

Once you've logged in locally, open the Rails console and change
your admin status to "true".

```bash
rails c
user = User.last
user.update(admin: true)
```

This will allow you to create and schedule messages.

Note: scheduled messages may not send if you're using over the weekend, which is
due to the business_time gem referenced above.

## Automated Deployment

Dolores is configured to be deployed [automatically via Travis](https://docs.travis-ci.com/user/deployment/script/).

When code is merged and pushed to the `develop` branch and the tests pass,
Travis will deploy the changes to staging. When code is merged and pushed to
`master` and the tests pass, Travis will deploy the changes to production. It is
for this reason that you should verify that changes have taken place and behave
as expected on staging before merging them to master.

## Manual Deployment

If for some reason you need to deploy manually, Dolores can be deployed with
Cloud Foundry by an 18f-er.

Refer to [docs.cloud.gov](https://docs.cloud.gov/getting-started/setup/) for
getting set up with Cloud Foundry.

The Dolores Landingham bot is deployed within the `gsa-18f-dolores` Cloud Foundry org. To
see if you have access to the `gsa-18f-dolores` do the following in the root of your repo:

`cf orgs`

If `gsa-18f-dolores` does not show up as an available org, you can request access by asking a
org-manager to [invite you as a `SpaceDeveloper`](https://docs.cloud.gov/apps/managing-teammates/) to
the `prod` and `staging` spaces of that org.

Once you have access to the org, you can target the Cloud Foundry organization
and space for this project:

```bash
# To target the production space
cf target -o gsa-18f-dolores -s prod

# To target the staging space
cf target -o gsa-18f-dolores -s staging
```

Once your target is set, you can push the application. We have two Cloud Foundry
instances: `dolores-app` and `dolores-staging`. Test your changes by pushing to
`dolores-staging` in the `staging` space before pushing to the `dolores-app`
instance to the `prod` space.

```bash
# Pushing the production app while targeting the "prod" space.
cf push -f manifest.yml

# Pushing the staging app while targeting the "staging" space.
cf push -f manifest_staging.yml
```

New migrations will be run automatically. See the manifest files for
more details on the Cloud Foundry setup.
- [Production manifest](manifest.yml)
- [Staging manifest](manifest_staging.yml)
- [Base manifest](manifest_base.yml)

To see existing environment variables:

`cf env <app-instance-name>`

To set or change the value of an environment variable:

`cf set-env <app-instance-name> <env-name> <env-value>`

You may have to set these environment variables manually as they contain secrets.
- `GITHUB_CLIENT_ID`
- `GITHUB_CLIENT_SECRET`
- `GITHUB_TEAM_ID`
- `SLACK_API_TOKEN`
