# 😃 Anonymojizer
Anonymize people in images by replacing any faces by emojis.

## How to use it ?
1. Pick an image from the gallery
2. Choose an emoji
3. The anonymization process will detect faces and replace them by the selected emoji
4. Export your new image to the gallery

## How it works ?
I'm using Apple's Vision framework to process the images and detect faces (read [Apple developer documentation](https://developer.apple.com/documentation/vision)).
