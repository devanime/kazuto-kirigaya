#!/usr/bin/env bash

while getopts "d" option
do
 case "${option}"
 in
 d)
   DRYRUN_OPTION=1
   ;;
 esac
done

DRYRUN=${DRYRUN_OPTION:-0}

basedir=$(pwd)
themesdir="$basedir/wp-content/themes"

read -p "Site Name: " SITE_NAME

DEFAULT_THEME_NAME=$(echo "$SITE_NAME" | tr ' ' - | tr '[:upper:]' '[:lower:]')
read -p "Theme directory name: [${DEFAULT_THEME_NAME}] " THEME
THEME=${THEME:-${DEFAULT_THEME_NAME}}

read -p "Git repo for ${SITE_NAME}: " GIT_REPO
if [[ GIT_REPO -eq "" ]]
then
    PACKAGE_NAME="devanime/$THEME"
else
    PACKAGE_NAME="devanime/$(php init-replace.php .git '' $(basename $GIT_REPO))"
fi

DEFAULT_LOCAL_URL=$(echo "http://$THEME.test" | tr -d '-')
read -p "Local URL [${DEFAULT_LOCAL_URL}]: " LOCAL_URL
LOCAL_URL=${LOCAL_URL:-${DEFAULT_LOCAL_URL}}

DEFAULT_DB_NAME="scotchbox"
read -p "Default local db name: [${DEFAULT_DB_NAME}] " DB_NAME
DB_NAME=${DB_NAME:-${DEFAULT_DB_NAME}}

read -p "Default local db user: [root] " DB_USER
DB_USER=${DB_USER:-root}

read -p "Default local db password: [root] " DB_PASSWORD
DB_PASSWORD=${DB_PASSWORD:-root}

php init-replace.php devanime/kirito-kirigaya $PACKAGE_NAME composer.json
php init-replace.php {db_name} $DB_NAME {db_user} $DB_USER {db_password} $DB_PASSWORD local-config-sample.php
php init-replace.php {theme-name} $THEME README.md

echo "Fetching WP salts"
curl -s 'https://api.wordpress.org/secret-key/1.1/salt' | php init-replace.php //{salts}// wp-config.php

cp "local-config-sample.php" "local-config.php"
rm -rf .github && mv github-workflow .github

if [[ DRYRUN -eq 1 ]]
then
    exit
fi

# Point of no return!

composer install

childthemedir="$themesdir/giorno-giovanna"
themedir="$themesdir/$THEME"

mv $childthemedir $themedir

composer remove devanime/giorno-giovanna --dev

php init-replace.php "Giorno Giovanna" "$SITE_NAME" $themedir/style.css
php init-replace.php {local_url} "$LOCAL_URL" giorno-giovanna "$THEME" package.json
php init-replace.php giorno-giovanna "$THEME" composer.json

(cd $themedir && rm -rf .git* composer.json)
composer develop
rm -rf .git
git init
git add -A .
git reset init.sh init-replace.php
git commit -am "Giorno Giovanna configured"
if [[ ! GIT_REPO -eq "" ]]
then
    git remote add origin $GIT_REPO
    git push --set-upstream origin master
    git checkout -b develop
    git push --set-upstream origin develop
fi

rm -rf init*
