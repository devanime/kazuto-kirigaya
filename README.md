# README #

Skeleton Framework provides a composer based dependency management system for WordPress installation and deployment. Based on the [Wordpress Site Stack recipe by Rarst](http://composer.rarst.net/recipe/site-stack)

Theme is based on [Sage by Roots](https://roots.io/sage/).


## How to use ##

### First Time Install ###

Try running `$ sh init.sh` for automated setup, otherwise use the instructions below. (Modify composer.json with any needed dependencies first.)

Clear the git repo so you can create a new one later.

```
$ rm -rf .git
```

Modify `composer.json` to specify any required plugins.

Install your composer dependencies:

```
$ composer develop
```

NOTE: This custom command will run `composer install`, `yarn`, `bower install` and `gulp --production`.

Now you should have the WP core installed in `/wp`, and plugins/base theme installed in `/wp-content`.

At this point, you can safely remove the `require-dev` section from `composer.json` if you don't feel like using the `--no-dev` switch for the rest of the life of the project.

Copy `local-config-sample.php` to `local-config.php` and fill in your local database credentials.

Don't forget to populate the salt section in `wp-config.php` for security.

Next, you'll need to rename the base theme and do your initial setup.
 
```
$ cd wp-content/themes
$ mv skeleton-theme {theme-name}
```

Remove the .git folder from your theme to avoid unpleasantness.

```
$ cd {theme-name}
$ rm -rf .git*
```

Modify your theme's `bower.json` file to include any theme dependencies (this is standard [Sage](https://roots.io/sage/) setup from here).

If and only if, you have modified the `bower.json` file, then run `npm install`, `bower install`, and `gulp` to rebuild and get started with development. 

```
$ npm install
$ bower install
$ gulp
```

### Local Dev Setup for an Existing Project ###

Install dependencies:

```
$ composer develop
```

## DeployBot Notes ##

DeployBot's build tools will install composer dependencies and execute the gulp build, but there are a few settings that need to be configured.
 
### Compile, compress, or minimize your code ###

Use the `Beanstalk Auth` box rather than the default, otherwise composer will be unable to fetch from our private repos.

Commands:

```
cd wp-content/themes/{theme-name}
gulp --production
```

### Run commands after new version is uploaded (For atomic sftp deployments)###

```
ln -s $SHARED/uploads $RELEASE/wp-content/uploads
```

### Upload configuration files (For atomic sftp deployments) ###

`local-config.php`

### Exclude certain paths from being uploaded ###

```
wp-content/themes/{theme-name}/node_modules
wp-content/themes/{theme-name}/bower_components
wp/wp-content
```

### Advanced options ###

Cached build commands:

```
# refresh: bower.json, package.json, composer.json, composer.lock

composer install --no-dev
cd wp-content/themes/{theme-name}
rm -rf node_modules bower_components
npm install
bower install
```
