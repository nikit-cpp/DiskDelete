--[[
INSTALLATION:
- put the file in the VLC subdir /lua/extensions, by default:
* Windows (all users): %ProgramFiles%\VideoLAN\VLC\lua\extensions\
* Windows (current user): %APPDATA%\VLC\lua\extensions\
* Linux (all users): /usr/share/vlc/lua/extensions/
* Linux (current user): ~/.local/share/vlc/lua/extensions/
* Mac OS X (all users): /Applications/VLC.app/Contents/MacOS/share/lua/extensions/
(create directories if they don't exist)
Restart the VLC.
]]--

--[[ Extension description ]]

function descriptor()
  return { title = "Diskdelete" ;
    version = "alpha" ;
    author = "Mark MorschhГ¤user" ;
    shortdesc = "DELETE current playing FILE FROM DISK";
    description = "<h1>Diskdelete</h1>"
		  .. "When you're playing a file, use Diskdelete to "
		  .. "easily delete this file <b>from your disk</b> with one click."
		  .. "<br>This will NOT change your playlist, it will <b>ERASE the file</b> itself!"
		  .. "<br>It will not use the Recycle Bin, the file will be gone immediately!"
		  .. "<br>This extension has been tested on GNU Linux with VLC 2.0.3."
		  .. "<br>The author is not responsible for damage caused by this extension.";
   }
end

--[[ Hooks ]]

-- Activation hook
function activate()
	vlc.msg.dbg("[Diskdelete] Activated")
	start()
end

-- Deactivation hook
function deactivate()
	vlc.msg.dbg("[Diskdelete] Deactivated")
end

--[[ Start ]]

function start()
  d = vlc.dialog("Diskdelete")
  d:add_label("<b>Clicking</b> this button will <b>delete</b> the currently playing file <b>from disk</b>.<br>You have to <b>be sure</b> as <b>you won't be asked</b> again!<br>You are responsible for your own actions, consider yourself warned.")
  d:add_button("DELETE CURRENT FILE PERMANENTLY FROM DISK WITHOUT ASKING", delete)
  d:show()
end

function delete()
  item = vlc.input.item()
  uri = item:uri()
  filename = vlc.strings.decode_uri(uri)
  filename = string.sub(filename,8)
  vlc.msg.dbg("[Diskdelete] selected for deletion: " .. filename)
  os.remove(filename)
end

function meta_changed()
end