if [ $(count_commit_files php) -eq 0 ] ; then
	return 0
fi

h1 "Debug code detect module"

ERROR=0
for file in $(commit_files php); do
    if egrep -n 'debugger|alert' $file >/dev/null ; then
		fail $file
		egrep -n 'debugger|alert' $file
        ERROR=1
	else
		ok $file
	fi
done

return $ERROR