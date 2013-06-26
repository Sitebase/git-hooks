# About

Git hooks is a little framework that I've written to easily add code validations and checks in our Git workflow every time a developer tries to commit code.

This way you are sure that all code that is commited meets certain standards.

# Checks

For the moment we perform the following checks:

* JShint
* PHPLint
* Prevent commit on master (We work with git flow so commit to the master is a big no no)
* Check for merge markers
* Commit message must at least be 8 characters

# Install

Git clone the repo in your home folder in .hooks directory:

>cd ~<br />
>git clone git@github.com:Sitebase/git-hooks.git .hooks

Now to install the hooks on your repository

>cd ~/.hooks
>./install.sh path/to/your/repository/

And that's it. 
If you now do a commit the needed commit checks will be run for that specific file extension.

# Update

Just run `git pull` and all your projects that use hooks are up to date.

# Skip checks

Of course from time to time it will happen that a check fails but actually you now the code you've written is valid. The you can add `--no-verify` to skip the hooks.

>git commit -m "Awesome new feature" --no-verify

# Todo

* Make it possible to install hooks dir where you want
* Make PHP mess detection module
* Make PHP check style module