dim FileName,fs,foldername
foldername = InputBox("��������Ҫ���ĸ��ļ��в���", "VBS�����ļ�")
If foldername = "" Then
wscript.quit
End If
Set fs = CreateObject("scripting.filesystemobject")
set savefile=fs.createtextfile("musicname.txt",True)
msgbox	"Ŀ¼������..."
digui (foldername)'���õݹ麯�����в���
msgbox "Ŀ¼������..."
savefile.close

Set wmp = CreateObject("WMPlayer.OCX") 
set fs=nothing
Set Fsys=CreateObject("Scripting.FileSystemObject")
set fso=Fsys.opentextfile("musicname.txt",1)
do while fso.atendofstream<>true
txt = fso.readline
playMusic(txt)
loop
