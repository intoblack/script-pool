'�����ǵݹ���Һ���
Function digui(path)
Set folder = fs.getfolder(path)
Set subfolders = folder.subfolders
Set Files = folder.Files
For Each i In Files

if Right(i.name,3)="mp3" or	Right(i.name,3)="wma" then
savefile.WriteLine i.path
end if

��FileName=FileName & i.name& vbNewLine '�ҵ���׷�ӵ�����FileName��
Next
For Each j In subfolders
digui (j.path) '�ݹ������Ŀ¼
Next
End Function

function playMusic(path)
wmp.url = path
do until wmp.playstate = 1
wscript.sleep	1000
loop

end function