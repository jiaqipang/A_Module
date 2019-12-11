#!/bin/bash

VersionString=`grep -E 's.version.*=' A_Module.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' A_Module.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" A_Module.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push CAPrivatePod A_Module.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

