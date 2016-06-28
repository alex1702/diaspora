#!/bin/bash

echo "System updaten und abhängigkeiten installieren..."
/root/paketeInstallieren.sh

echo "Diaspora stoppen..."
service diaspora stop

cd /home/diaspora
echo "Zu benutzer Diaspora wechseln..."
su - diaspora
echo "In diaspora Ordner wechseln"
cd diaspora

echo "Git status:"
git status

echo "Alle Änderungen gesichert oder gelöscht?"
read x

echo "Änderungen löschen..."
git checkout -- *

echo "Updates besorgen..."
git pull update social-elaon-de

echo "Aktuelle ruby version:"
rvm list

cd .. && cd -

echo "Bundler installieren.."
gem install bundler
echo "Bunder ausführen.."
bin/bundle

echo "DB-Update..."
RAILS_ENV=production bin/rake db:migrate

echo "Assets cleanen und neu generien lassen..."
RAILS_ENV=production bin/rake assets:clean
RAILS_ENV=production bin/rake tmp:cache:clear assets:precompile

exit
echo "Diaspora starten..."
service diaspora start

