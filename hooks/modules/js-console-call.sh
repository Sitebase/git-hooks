if [ $(count_commit_files js) -eq 0 ] ; then
	return 0
fi

h1 "JS console call module"

ERROR=0
for file in $(commit_files js); do
    if grep -P '^(?!.*//.*console\.(log|error|info|debug))(?=.*console\.(log|error|info|debug))' $file >/dev/null ; then
        fail $file
        grep -P '^(?!.*//.*console\.(log|error|info|debug))(?=.*console\.(log|error|info|debug))' $file
        ERROR=1
    else
    	ok $file
    fi  
done

return $ERROR