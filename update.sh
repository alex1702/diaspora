#!/bin/bash

echo "System updaten und abhängigkeiten installieren..."
/root/paketeInstallieren.sh

echo "Diaspora stoppen..."
service diaspora stop

cd /home/diaspora

if [[ "diaspora" != "$LOGNAME" ]]; then
	echo "Wechsel Benutzer zu diaspora"
	su - diaspora -c "$0 diaspora"
	echo $?
fi

if [ "$1" == "diaspora" ]; then
	echo "In diaspora Ordner wechseln"
	cd /home/diaspora/diaspora

	echo "Git status:"
	git status

	echo "Alle Änderungen gesichert oder gelöscht?"
	read x

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

	echo "Diaspora starten..."
	service diaspora start

fi


