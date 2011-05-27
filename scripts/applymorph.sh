#!/sbin/sh

# temporary theme directory: /tmp/metamorph/theme/out
BASE_DIR="/tmp/metamorph/theme/out"
MMREC_LOG=/sdcard/mmrec/mmrec.log

echo "`date -u +%H:%M:%S` -- Applying theme!" >> $MMREC_LOG

for subtheme in /tmp/metamorph/theme/out/*/
do
	if [[ "$subtheme" == "framework-res" ]]
	then
		cd "$subtheme"
		zip -r /system/framework/framework-res.apk ./*
		zipalign -f 4 /system/framework/framework-res.apk /tmp/framework-res.apk
		mv /tmp/framework-res.apk /system/framework/framework-res.apk
		echo "`date -u +%H:%M:%S` -- Themed framework-res.apk" >> $MMREC_LOG
	else
		cd "$subtheme"
		if [[ -e /system/app/"$subtheme".zip ]]
		then
			zip -r /system/app/"$subtheme".apk ./*
			zipalign -f 4 /system/app/"$subtheme".apk /tmp/"$subtheme".apk
			mv /tmp/"$subtheme".apk /system/app/"$subtheme".apk
			echo "`date -u +%H:%M:%S` -- Themed $subtheme.apk" >> $MMREC_LOG
		else
			echo "`date -u +%H:%M:%S` -- $subtheme.apk does not exist." >> $MMREC_LOG
		fi
	fi
done

# clean up our mess
sync
sleep 2
rm -rf /tmp/*
sleep 1
sync
