# keyboard_to_english
Ubuntu: Following script changes keyboard input language to English after locking screen by pressing CMD + L.

Installation instructions:
0. Place script in "/usr/local/bin/",  make it executable (might require sudo)
1. Search "Startup Applications" on your Ubuntu machine
2. Click add new
3. Give it a "name" and "comment" 
4. Set command field: "nohup /usr/local/bin/lockscreen_lang_switcher.sh &"
5. Restart, switch languae other than EN, press CMD + L
6. Try logging in

Enjoy it!