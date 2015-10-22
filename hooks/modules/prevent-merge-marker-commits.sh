h1 "Prevent merge marker commits"

ERROR=0
for file in $(commit_files); do
    if egrep -rls "^<<<<<<< |^>>>>>>> |^======= $" $file >/dev/null ; then
    	fail $file
    	ERROR=1
    fi
done

if [ $ERROR -eq 0 ]; then
	ok "No merge markers found"
fi

return $ERROR