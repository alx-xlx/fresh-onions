#!/bin/sh
# hello! yes, this is a public link to a google sheet, to fetch as csv; and yes, i do know.
url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ0L9HBKSet6zF_u17QEqDtcidNwVSa1gOmv1nX07ZcjcSShE1DSL-3fb73ihGmQI6vkKGjTnfYQPUu/pub?output=csv"
now=`date "+%Y%m%d%H%M%S"`
out="log-$now.out.txt"
err="log-$now.err.txt"
tmp="/tmp/onion-tmp-$$.csv"
csv="master.csv"
exe="python3 rwos-db.py"

exec </dev/null >$out 2>$err

case "x$1" in
    x-n) dofetch=false ;;
    *) dofetch=true ;;
esac

set -x

curl "$url" > $tmp || exit 1

if [ -s $tmp ] ; then
    cmp $tmp $csv || cp $tmp $csv
fi

if $dofetch ; then
    $exe fetch || exit 1
fi

(
    cat 01-preamble.md
    echo ""
    $exe print || exit 1
    echo ""
    cat 02-footnotes.md
    echo ""
) > README.md

exit 0
