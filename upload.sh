#!/bin/bash

# Flutter project build
flutter build apk --split-per-abi

# Project build and get APK file path
apk_file_path="./build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"

# Server upload URL
server_url="https://upload.sametates.dev/upload"

echo "File uploading start"

# Get file size
file_size=$(wc -c < "$apk_file_path")

# Start percent value
percentage=0

# File upload to server, get the response
response=$(curl -# -F "file=@$apk_file_path" $server_url)

# Check response
status=$(echo "$response" | grep -o '<a.*<\/a>')
if [ -n "$status" ]; then
    echo -e "APK file successfully uploaded"

    # Get download link
    download_link=$(echo "$status" | sed 's/<[^>]*>//g')

    if [ -n "$download_link" ]; then
        echo "Download link: $download_link"
        echo "Project build clean"
        flutter clean
        flutter pub get
        echo "Upload and Clean success"
        echo "Download link: $download_link"

        # Send email using msmtp
        recipients="sametates4@outlook.com, trnyldrm3358@gmail.com, furkanvr34@gmail.com"     # Alıcı e-posta adresini girin
        subject="APK Download Link"
        message="Link 2 saat sonra kendini imha edecektir,
        Eklenen özellik: Uygulama arka plandan açıldıktan sonra çalışma saaiti güncelleyecek
        güncel çalışma saatini görmek için uygulamayı kapatıp  açmak gerekmiyecek

        başka bişe yok

        : $download_link"

        echo -e "Subject: $subject\n\n$message" | msmtp -- "$recipients"

        echo "Download link has been sent via email to $recipients"
    else
        echo "Download link error"
    fi
else
    echo "APK upload failed. Error: $response"
fi
