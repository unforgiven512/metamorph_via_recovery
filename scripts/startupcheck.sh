#!/sbin/sh

touch /tmp/metamorph.log
echo "--------------------------------------------------------------------------------" >> /tmp/metamorph.log
echo "METAMORPH VIA RECOVERY" >> /tmp/metamorph.log
echo "--------------------------------------------------------------------------------" >> /tmp/metamorph.log
echo "`date -u +%H:%M:%S` -- Startup Checks initialized" >> /tmp/metamorph.log
themezip=`ls -1 /tmp/metamorph/theme/*.zip | grep .zip`
themezip=${themezip##*/}
echo "`date -u +%H:%M:%S` -- Theme = ${themezip%.zip}" >> /tmp/metamorph.log
mkdir /tmp/metamorph/theme/out

if ([ -f "/tmp/metamorph/tools/zip" ] && [ -f "/tmp/metamorph/tools/zipalign" ] && [ -f "/tmp/metamorph/theme/${themezip}" ])
	then
		# Awesome, everything is swell
		# Let's go ahead and unzip our theme!
		unzip -q /tmp/metamorph/theme/${themezip} -d /tmp/metamorph/theme/out/
		echo "`date -u +%H:%M:%S` -- Everything should be working correctly." >> /tmp/metamorph.log
		return 0
	else
		# Something is missing, exit with error
		echo "`date -u +%H:%M:%S` -- Something went wrong, exiting." >> /tmp/metamorph.log
		echo "`date -u +%H:%M:%S` -- Check that your theme is in the theme directory." >> /tmp/metamorph.log
		echo "`date -u +%H:%M:%S` -- DEBUG: \$themezip = ${themezip}" >> /tmp/metamorph.log
		return 1
fi
