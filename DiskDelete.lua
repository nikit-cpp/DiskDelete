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
    author = "Mark Morschhäuser" ;
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
  item = vlc.input.item()
  uri = item:uri()
  filename = vlc.strings.decode_uri(uri)
  filename = string.sub(filename,8)
  vlc.msg.dbg("[Diskdelete] selected for deletion: " .. filename)
  id = vlc.playlist.current()
  
  vlc.playlist.next()
  id2 = vlc.playlist.current()
  os.remove(filename)
  vlc.playlist.delete(id)
  id3 = id2 + 1
  vlc.playlist.gotoitem(id3)
  vlc.deactivate()
end

function meta_changed()
end