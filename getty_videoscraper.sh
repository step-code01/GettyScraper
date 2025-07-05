#!/bin/bash

#!/bin/bash

PAGE_URL="https://www.gettyimages.in/videos/ambulance-siren"
curl -s "$PAGE_URL" -A "Mozilla/5.0" |
  grep -Eo 'https://[^"]+\.mp4' |
  sort -u > video_urls.txt

echo "Found $(wc -l < video_urls.txt) video URLs"

i=1
mkdir -p getty_downloads

while IFS= read -r url; do
    ext="${url##*.}"
    wget -q --show-progress "$url" -O "getty_downloads/getty_video_$i.$ext"
    echo "Saved getty_video_$i.$ext"
    ((i++))
done < video_urls.txt

:'If you do have a page where .mp4 links appear directly in HTML, this script structurally works but for static HTML sites.
Getty uses JavaScript to dynamically load videos.
So when curl fetches the page, it gets only static HTML, not the actual playable video URLs.'
