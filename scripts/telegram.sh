#!/bin/bash

set -e

GIT_SHA=$(git rev-parse --short ${BUILD_SHA})
CHAT_ID="-332180086"

if [[ -e build/app/outputs/apk/release/app-release.apk  ]]

then

	curl -F chat_id=$CHAT_ID -F document=@"build/app/outputs/apk/release/hades_${GIT_SHA}.apk" https://api.telegram.org/bot$BOT_TOKEN/sendDocument

	curl -F chat_id=$CHAT_ID -F text="Build succeeded for ${GIT_SHA}!" https://api.telegram.org/bot$BOT_TOKEN/sendMessage
else

	curl -F chat_id=$CHAT_ID -F text="Build failed!" https://api.telegram.org/bot$BOT_TOKEN/sendMessage

fi
