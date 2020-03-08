#!/bin/sh
echo "Creating ADMIN store - give access only to infrastructure admins!"
gopass init -p ~/.tsipis/admin-pass -s tsipis-admin-pass
echo "Creating user store - give access everybody else (careful though)"
gopass init -p ~/.tsipis/pass -s tsipis-pass

echo "Don't forget to add a git remote in both repositories if you want!"
