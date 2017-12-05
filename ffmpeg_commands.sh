ffmpeg -i 【PS4FT】Luka\ Luka★Night\ Fever【Megurine\ Luka：V4X】-BkHJ495HOKI.mp4 -filter:v "fps=30, scale=454:256, crop=256:256:99:0"   -qscale:v 2 -huffman optimal luka_%08d.jpg
ffmpeg -i haku_00005354.jpg -i 00005287.jpg -filter_complex hstack output.jpg
nohup ls haku | sort -n | parallel -u --block 100M 'python inference.py --model "haku2luka/haku2luka.pb" --input "haku/{}" --output "./result/{}"' &
ffmpeg -framerate 30 -i haku/%08d.jpg -framerate 30 -i result/%08d.jpg -filter_complex hstack -f mp4 -q:v 0 output.mp4
