#!/bin/bash

# Umask should be set to 002 or group write will be disabled
# Quite a few installs run into an issue where UMASK 022 should be 002 so its closer to 0775
# https://hub.docker.com/r/nubs/composer-build/~/dockerfile/
umask 002

# Run php-fpm
php-fpm
