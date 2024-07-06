# get the latest filename
# curl "https://go.dev/dl/?mode=json" | jq '.[0].files'

# find the release name
# grep -Eo 'go[0-9]+\.[0-9]{2}\.[0-9]+\.linux-amd64\.tar\.gz'

# or full command:

if command -v go >/dev/null 2>&1; then
    echo "Go is already installed. Exiting."
    exit 0
fi

filename=$(curl -s "https://go.dev/dl/?mode=json" | jq '.[0].files' | grep -Eo 'go[0-9]+\.[0-9]{2}\.[0-9]+\.linux-amd64\.tar\.gz')
echo "Downloading ${filename}"
# download the file
curl -O "https://storage.googleapis.com/golang/$filename"

echo "Extracting to /usr/local"
sudo tar -xzf "${filename}" -C /usr/local

{   
    echo ''
    echo 'export PATH="$PATH:/usr/local/go/bin"'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH="$PATH:$GOPATH/bin"'
    echo ''
} >> ~/.zshrc

rm "${filename}"

echo "Go Installation complete, reload the zshrc now"