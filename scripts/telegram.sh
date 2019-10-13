#!/bin/bash

set -e

GIT_SHA=1

if [[ -e build/app/outputs/apk/release/app-release.apk  ]]

then

	mv build/app/outputs/apk/release/app-release.apk build/app/outputs/apk/release/hades_${GIT_SHA}.apk

	curl -F chat_id="900025646" -F document=@"build/app/outputs/apk/release/hades_${GIT_SHA}.apk" https://api.telegram.org/bot$BOT_TOKEN/sendDocument

else

	curl -F chat_id="900025646" -F text="Build failed!" https://api.telegram.org/bot$BOT_TOKEN/sendMessage

fi
