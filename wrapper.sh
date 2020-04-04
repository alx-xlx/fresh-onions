#!/bin/sh
# hello! yes, this is a public link to a google sheet, to fetch as csv; and yes, i do know.
url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQqSujmnoPkrliifIVfpJwdLTRpUFIHLXcYjoJoJYiu3g-vj2dMm26YEOhpaIJi0seCF0CoWGUOopa3/pub?output=csv"
now=`date "+%Y%m%d%H%M%S"`
out="log-$now.out.txt"
err="log-$now.err.txt"
tmp="/tmp/onion-tmp-$$.csv"
csv="master.csv"
exe="./rwos-db.py"

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
