FROM curlimages/curl:latest

USER 1000:1000

WORKDIR /home/curl_user

ENTRYPOINT ["curl"]
