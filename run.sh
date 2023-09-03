#!/usr/bin/env bash

if ! [[ $(type -P flatpak-builder) ]]; then
	echo "Please install 'flatpak-builder'"
	exit 1
fi

clear

runtime=$(grep runtime-version org.openmsx.openMSX.yaml|awk '{print $2}')
flatpak --user install flathub org.freedesktop.Sdk//${runtime} -y

if ! flatpak-builder --repo=testing-repo --force-clean build-dir org.openmsx.openMSX.yaml;
then
	echo "flatpak build failed."
	exit 1
fi

flatpak --user remote-add --if-not-exists --no-gpg-verify msx-testing-repo testing-repo
flatpak --user install msx-testing-repo org.openmsx.openMSX -y
flatpak --user install msx-testing-repo org.openmsx.openMSX.Debug -y
flatpak update -y
