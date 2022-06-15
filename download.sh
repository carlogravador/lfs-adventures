
cat packages.csv | while read line; do
    NAME="`echo $line | awk -F\, '{print$1}'`"
    VERSION="`echo $line | awk -F\, '{print$2}'`"
    URL="`echo $line | awk -F\, '{print$3}' | sed "s/@/$VERSION/g"`"
    MD5SUM="`echo $line | awk -F\, '{print$4}'`"
    CACHEFILE="$(basename "$URL")"

    echo ------------------------------------------------------------------------------------------
    echo NAME $NAME
    echo VERSION $VERSION
    echo URL $URL
    echo MD5SUM $MD5SUM
    echo CACHEFILE $CACHEFILE
    echo ------------------------------------------------------------------------------------------

    if [ ! -f "$CACHEFILE" ]; then

        echo "DOWNLOADING ${URL}"
        wget "$URL"

        if ! echo $MD5SUM $CACHEFILE | md5sum -c > /dev/null; then
            rm -rf $CACHEFILE
            echo "Verification of ${CACHEFILE} FAILED! MD5 mismatch!"
            exit 1
        fi
    else
        echo "SKIP DOWNLOADING ${URL}, ALREADY EXIST"
    fi

    echo ------------------------------------------------------------------------------------------



done
