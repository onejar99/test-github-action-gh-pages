#!/bash/bin

echo "HOME=[$HOME]"
echo "GITHUB_WORKSPACE=[$GITHUB_WORKSPACE]"
echo "GITHUB_RUN_ID=[$GITHUB_RUN_ID]"
echo "GITHUB_REPOSITORY=[$GITHUB_REPOSITORY]"
echo "GITHUB_SHA=[$GITHUB_SHA]"
echo "MY_SECRET=[$MY_SECRET]"
echo "USER_NAME=[$USER_NAME]"
echo "USER_EMAIL=[$USER_EMAIL]"
echo "OUTPUT_DIR=[$OUTPUT_DIR]"
echo "whoami=[$(whoami)]"
echo "pwd=[$(pwd)]"
GH_PAGES_FOLDER=${GITHUB_REPOSITORY}_ghpages
export GH_PAGES_FOLDER
echo "GH_PAGES_FOLDER=[$GH_PAGES_FOLDER]"
ls -al

git clone -b gh-pages --single-branch https://${MY_SECRET}@github.com/${GITHUB_REPOSITORY}.git ${GH_PAGES_FOLDER}
ls -al
rm -rf $GH_PAGES_FOLDER/$BOOK_DIR
cp -rf $OUTPUT_DIR $GH_PAGES_FOLDER/$BOOK_DIR
cd $GH_PAGES_FOLDER
ls -al

git config --local user.name $USER_NAME
git config --local user.email $USER_EMAIL
git status
git add --all
git commit -m "Deploy to Github Pages 🥂 (from $GITHUB_SHA)"
git push origin gh-pages -f
echo Deploy gh-pages completed! 💪💯
