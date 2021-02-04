#!/bin/sh

gpg --symmetric --cipher-algo AES256 "${@}"
