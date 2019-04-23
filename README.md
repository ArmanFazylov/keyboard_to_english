
# lockscreen_layout_switcher
Ubuntu 16.04 and 18.04: The included script (`lockscreen_lang_switcher.sh`) switches the keyboard layout to the first layout (or the specified layout)
when the system is unlocked.

### Installation instructions:

0. Place script in "/usr/local/bin/",  make it executable (might require sudo) 
```
	sudo chmod +x lockscreen_lang_switcher.sh
```
1. Search "Startup Applications" on your Ubuntu machine
2. Click add new
3. Give it a "name" and "comment" 
4. Set command field: "nohup /usr/local/bin/lockscreen_lang_switcher.sh -l [layout_number] &"
<img src="/image.png" alt="Image"/>
`layout_number` follows the order you see when normally switching layouts, with first layout corresponding to zero.
`-l` can be ommited, in which case it will default to option `0`.

5. Restart, switch language to other than the specified layout, press CMD + L
6. Try logging in

Enjoy it!

### Usage on other Ubuntu Versions

It is possible to try running this script with other Ubuntu versions, by over-riding the version that will be set with the `-r` flag.
You can either set 18.04 or 16.04. It has not been tested on other versions (and there is no intention to do so).

### PS. to kill script use:
```
	ps ax | grep "[l]ockscreen_lang_switcher.sh" | grep -v grep | awk '{print $2}' | xargs kill
```
