
# Typingspeed-bot

[![NPM version](https://img.shields.io/npm/v/typingspeed-bot.svg?style=flat)](https://www.npmjs.com/package/typingspeed-bot)
![](https://img.shields.io/badge/unicodeveloper-approved-brightgreen.svg)

Typingspeed-bot is a bot built on the Hubot framework.

### Running Typingspeed-bot Locally

You can test your hubot by running the following, however some plugins will not behave as expected unless the [environment variables](#configuration)
they rely upon have been set.

You can start Typingspeed-bot locally by running:

    % bin/hubot

You'll see some start up output and a prompt:

    [Fri Dec 25 2015 14:10:35 GMT+0100 (GMT)] INFO Using default redis on localhost:6379
    typingspeed-bot>

Then you can interact with Typingspeed-bot by typing `typingspeed-bot help`.

    typingspeed-bot> typingspeed-bot help
    `typingspeed-bot` - Welcomes you to typingspeed-bot with some instructions
    `ready` - Displays a random paragraph that you are required to type
    ...


##  Persistence

If you are going to use the `hubot-redis-brain` package (strongly suggested),
you will need to add the Redis to Go addon on Heroku which requires a verified
account or you can create an account at [Redis to Go][redistogo] and manually
set the `REDISTOGO_URL` variable.

    % heroku config:add REDISTOGO_URL="..."

If you don't need any persistence feel free to remove the `hubot-redis-brain`
from `external-scripts.json` and you don't need to worry about redis at all.

[redistogo]: https://redistogo.com/

## Deployment

    % heroku create <app-name>
    % git push heroku master

Check out this [tutorial](http://goodheads.io/2015/10/30/creating-your-first-slack-bot/#time-to-deploy) to learn how to deploy a slackbot on heroku

If your Heroku account has been verified you can run the following to enable
and add the Redis to Go addon to your app.

    % heroku addons:add redistogo:nano

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

You'll need to edit the `Procfile` to set the name of your hubot.

More detailed documentation can be found on the [deploying hubot onto
Heroku][deploy-heroku] wiki page.

### Deploying to UNIX or Windows

If you would like to deploy to either a UNIX operating system or Windows.
Please check out the [deploying hubot onto UNIX][deploy-unix] and [deploying
hubot onto Windows][deploy-windows] wiki pages.

[heroku-node-docs]: http://devcenter.heroku.com/articles/node-js
[deploy-heroku]: https://github.com/github/hubot/blob/master/docs/deploying/heroku.md
[deploy-unix]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md
[deploy-windows]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart` if
you're having issues.
