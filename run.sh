echo "Scanning"
./wrapper.sh
echo "------------------"
echo "Scanning Completed"
echo "------------------"
echo "Updating https://github.com/alx-xlx/fresh-onions/README.md"
./github-update.sh
echo "------------------"
echo "Task Completed"