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
* Check for uncommented console.log calls in javascript files which can break your code in older browsers like IE

# Modules

Some extra information about some of the modules

## JSHint

You can overwrite the default jshint config by placing a .jshintrc file in the root of your repository.
Git hooks also supports the use of `.jshintignore in the root folder of your repo.

# Install

Git clone the repo in your home folder in .hooks directory:

>cd ~<br />
>git clone https://github.com/Sitebase/git-hooks.git .hooks

Create a link to the git-hooks script in /usr/bin

>ln -s ~/.hooks/git-hooks /usr/bin/git-hooks

Now to install the hooks on your repository

> cd /path/to/my/repo<br />
> git hooks enable

And that's it. 
If you now do a commit the needed commit checks will be run for that specific file extension.

# Modules
Modules currently only run when the pre-commit hook is called.

## Listing modules
An overview of the installed modules and their current status can be retrieved using `git hooks module list`.

## Enabling and disabling modules
These modules can be enabled and disabled using `git hooks module [enabled|disable] module_name`.

# Addons
Addons will be loaded into git-hooks whenever the `helper.sh` script is included, they reside in the `addons` folder.

To include your own addon, simply add a shell script to the folder and it will be loaded.

## Addon convention
Addons should have their functions start with a fixed prefix. For example `my_addon` as prefix will result in functions like `my_addon_usage`.

Providing a function with only the prefix as name will allow you to use it on the commandline. For example `git hooks my_addon`

# Update

Just run `git pull` and all your projects that use hooks are up to date.

# Skip checks

Of course from time to time it will happen that a check fails but actually you now the code you've written is valid. The you can add `--no-verify` to skip the hooks.

>git commit -m "Awesome new feature" --no-verify

# Todo

* Make PHP mess detection module
* Make PHP check style module

# Contributors
This project is made possible due to the efforts of these fine people:

* [Wim Mostmans](http://twitter.com/Sitebase) - Original author and maintainer<br />
* [Jorgen Evens](https://twitter.com/JorgenEvens)

# License

(The MIT License)

Copyright (c) 2013 Wim Mostmans

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.