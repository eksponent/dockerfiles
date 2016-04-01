#!/bin/bash

# Umask should be set to 002 or group write will be disabled
umask 002

# Run php-fpm
php-fpm
