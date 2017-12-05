ffmpeg -i 【PS4FT】Luka\ Luka★Night\ Fever【Megurine\ Luka：V4X】-BkHJ495HOKI.mp4 -filter:v "fps=30, scale=454:256, crop=256:256:99:0"   -qscale:v 2 -huffman optimal luka_%08d.jpg
ffmpeg -i haku_00005354.jpg -i 00005287.jpg -filter_complex hstack output.jpg
