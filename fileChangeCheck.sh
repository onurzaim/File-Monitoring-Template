checkDir="$2"
tempDir="/tmp"
fileName=$(sed -e "s/\///g" <<< $checkDir)

function checkFilesMd5 () {
        echo -e "["
        for files in $(ls -1 $checkDir)
        do
                filemd5=$(md5sum $checkDir/$files | awk '{ print $1 }')
                echo -e " { \"{#FILENAME}\":\"$files\", \"{#FILEMD5}\":\"$filemd5\" },"
        done
echo -e "]"
}

function displayFilesMd5 () {
checkFilesMd5 > $tempDir/$fileName

lineNo=$(cat /tmp/etcpam.d | wc -l)
beforeLastline=$(expr $lineNo - 1 )
#sed -i "$($beforeLastline)"s/\},/\}/ $tempDir/$fileName
sed -i "$(echo $beforeLastline)s/\},/\}/" $tempDir/$fileName
cat $tempDir/$fileName
}

case $1 in
        json)
                displayFilesMd5
                ;;

        *)
                echo -n "usage: "
                echo -n "command \"directory\" \"json\"  "
                ;;

esac

