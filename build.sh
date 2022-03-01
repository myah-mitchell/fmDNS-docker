Version="4.2.0"
fmDNSVersion="5.2.0"


# Build Images
Version=$Version docker-compose build

# Add Tag
docker tag micahmitchell/fmdns micahmitchell/fmdns:$fmDNSVersion

# Upload Images
docker push micahmitchell/fmdns:latest

docker push micahmitchell/fmdns:$fmDNSVersion
