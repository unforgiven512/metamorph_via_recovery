#!/sbin/sh

MMREC_LOG=/sdcard/mmrec/mmrec.log

touch $MMREC_LOG
echo "--------------------------------------------------------------------------------" >> $MMREC_LOG
echo "METAMORPH VIA RECOVERY" >> $MMREC_LOG
echo "--------------------------------------------------------------------------------" >> $MMREC_LOG
echo "`date -u +%H:%M:%S` -- Startup Checks initialized" >> $MMREC_LOG
themezip="`ls -1 /tmp/metamorph/theme/*.zip | grep .zip`"
themezip="${themezip##*/}"
echo "`date -u +%H:%M:%S` -- Theme = ${themezip%.zip}" >> $MMREC_LOG

if ([ -f "/tmp/metamorph/tools/zip" ] && [ -f "/tmp/metamorph/tools/zipalign" ] && [ -f "/tmp/metamorph/theme/${themezip}" ])
	then
		# Awesome, everything is swell
		# Let's go ahead and unzip our theme!
		mkdir -p /tmp/metamorph/theme/out
		unzip -q /tmp/metamorph/theme/${themezip} -d /tmp/metamorph/theme/out/
		echo "`date -u +%H:%M:%S` -- Extracted theme to /tmp/metamorph/theme/out/*." >> $MMREC_LOG
		return 0
	else
		# Something is missing, exit with error
		echo "`date -u +%H:%M:%S` -- Something went wrong, exiting." >> $MMREC_LOG
		echo "`date -u +%H:%M:%S` -- Check that your theme is in the theme directory." >> $MMREC_LOG
		echo "`date -u +%H:%M:%S` -- DEBUG: \$themezip = ${themezip}" >> $MMREC_LOG
		return 1
fi
