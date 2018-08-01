
# keyboard_to_english
Ubuntu: Following script changes keyboard input language to English after locking screen by pressing CMD + L.

### Installation instructions:

0. Place script in "/usr/local/bin/",  make it executable (might require sudo) 
```
	sudo chmod +x lockscreen_lang_switcher.sh
```
1. Search "Startup Applications" on your Ubuntu machine
2. Click add new
3. Give it a "name" and "comment" 
4. Set command field: "nohup /usr/local/bin/lockscreen_lang_switcher.sh &"
<img src="/image.png" alt="Image"/>

5. Restart, switch language to other than EN, press CMD + L
6. Try logging in

Enjoy it!


### PS. to kill script use:
```
	ps ax | grep "[l]ockscreen_lang_switcher.sh" | grep -v grep | awk '{print $2}' | xargs kill
```
