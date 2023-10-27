#!/bin/bash
url="https://URL_HERE.jamfcloud.com"
token_file="/tmp/token.json"
curl_output_file="/tmp/output.txt"

# encode the credentials into base64
credentials=$(printf "%s" "USER_HERE:PASS_HERE" | iconv -t ISO-8859-1 | base64 -i -)

# post the request to the token-issuing endpoint
curl --request POST \
--header "authorization: Basic $credentials" \
--url "$url/api/v1/auth/token" \
--header 'Accept: application/json' \
--output "$token_file"

# extract the token from the JSON response
token=$(plutil -extract token raw "$token_file")


#Gets JCDS Files and outputs to the path defined in the variable
curl --request GET \
--header "authorization: Bearer $token" \
--header 'Accept: application/json' \
"$url/api/v1/jcds/files" \
--output "$curl_output_file"

