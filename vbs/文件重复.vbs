path1=inputbox("���������Ҫ����·��:")
path2=inputbox("�������������ظ����ļ���")
Set fs = CreateObject("scripting.filesystemobject")
set floder1=fs.getfolder(path2)
set folder1=fs.getfolder(path1)
set file1=folder1.Files
set file2=folder1.Files
dim msg
for Each i In file1
	for	Each j In file2
	if j.name=i.name then
		msg=msg&j.name&"�ظ�"&folder1&vbNewLine
	     end if
	next

next
msgbox msg