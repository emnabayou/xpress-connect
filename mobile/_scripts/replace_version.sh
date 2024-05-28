# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Please specify the app version"
    exit 1
fi

# Retrieve the new version from the command-line argument
new_version="$1"

# Use the new version in the sed command to replace the version in your file
sed -i "s/version: .*/version: $new_version/" pubspec.yaml
#sed -i '' -e "s/version: .*/version: $new_version/" mobile/pubspec.yaml