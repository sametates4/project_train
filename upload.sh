#!/bin/bash

# flutter project build
flutter build apk --split-per-abi

# project build and get apk file path
apk_file_path="./build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"

# server upload url
server_url="https://upload.sametates.dev/upload"

echo "File uploading start"

# get file size
file_size=$(wc -c < "$apk_file_path")

# start percent value
percentage=0

# file upload to server get the response
response=$(curl -# -F "file=@$apk_file_path" $server_url)

# check response
status=$(echo "$response" | grep -o '<a.*<\/a>')
if [ -n "$status" ]; then
    echo -e "Apk file success uploaded"

    # get download conn
    download_link=$(echo "$status" | sed 's/<[^>]*>//g')

    if [ -n "$download_link" ]; then
        echo "Download conn: $download_link"
        echo "Project build clean"
        flutter clean
        flutter pub get
        echo "Upload and Clean success"
        echo "Download conn: $download_link"
    else
        echo "Download conn error"
    fi
else
    echo "APK upload to fail. Error: $response"
fi