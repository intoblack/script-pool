dim sign                                                                        '--! 1------
sign=true                                                                       '--! 2------
set fs=CreateObject("Scripting.FileSystemObject")                               '--! 3------
do while sign                                                                   '--! 4------
choice=inputbox("1.�鿴���м�¼		 "&vbNewLine&"2.���Ӽ�¼"&vbNewLine&"3.ɾ���ƶ��ļ�¼	"&vbnewline&"4. ���¼�¼"&vbnewline&"5.��ԭ����"&vbnewline&"6.�������"&vbnewline&"0. �뿪")                                                                   '--! 5------
if choice ="" then
wscript.quit
end if
if choice =0  then                                              '--! 6------
sign =false                                                                     '--! 7------
elseif choice =1 then                                                           '--! 8------
                                                                                '--! 9------
		 LookAllSave()	                                                          '--! 10-----
	elseif choice = 2 then                                                         '--! 11-----
  		addSave()	                                                                  '--! 12-----
			                                                                             '--! 13-----
	elseif choice=3 then		                                                         '--! 14-----
		delSave()		                                                                   '--! 15-----
		
	elseif choice = 4 then                                                         '--! 16-----
   	 refreshSave()                                                              '--! 17-----
	
	elseif choice =5 then                                                          '--! 18-----
	changeSave()
	elseif choice =6 then	                                                                  '--! 19-----
	delall()
end if                                                                          '--! 20-----
                                                                                '--! 21-----
loop                                                                            '--! 22-----
                                                                                '--! 23-----
                                                                                '--! 24-----
                                                                                '--! 25-----
                                                                                '--! 26-----
function LookAllSave()                                                          '--! 27-----
                                                                                '--! 28-----
dim fileSign                                                                    '--! 29-----
if fs.fileexists("c:\saveHabit.txt") then                                          '--! 30-----
                                                                                '--! 31-----
else                                                                            '--! 32-----
                                                                                '--! 33-----
msgbox "��û�м�¼"                                                                  '--! 34-----
LookAllSave=false                                                               '--! 35-----
exit function                                                                   '--! 36-----
                                                                                '--! 37-----
end if                                                                          '--! 38-----
set file = fs.OpenTextFile("c:\saveHabit.txt",1,true)                              '--! 39-----
dim fileLine,save                                                               '--! 40-----
save=""                                                                         '--! 41-----
fileLine=1                                                                      '--! 42-----
do while file.AtEndOfStream<>true                                               '--! 43-----
txt=file.readline                                                               '--! 44-----
te=file.readline                                                                '--! 45-----
save = save &"��  "&fileLine&"  ��¼  :"&txt&RTimeDiff(te)                         '--! 46-----
fileline=fileline+1                                                             '--! 47-----
loop                                                                            '--! 48-----
 msgbox save                                                                    '--! 49-----
file.close()                                                                    '--! 50-----
LookAllSave = true                                                              '--! 51-----
end function                                                                    '--! 52-----
                                                                                '--! 53-----
                                                                                '--! 54-----
function RTimeDiff(OTime)                                                       '--! 55-----
dim msgTime                                                                     '--! 56-----
ss=dateDiff("s",OTime,Now)
msgS=ss mod 60
msgH=ss/360 mod 24                                             '--! 57-----
                                             '--! 58-----
msgM=ss/60 mod 60                                             '--! 59-----

msgTime = "		�ѹ�ȥ��ʱ��Ϊ   :"&dateDiff("d",OTime,Now)&"��  "&msgH&"  Сʱ"&msgM&"  ��"&msgS&"  ��"&vbnewline&vbnewline                                             '--! 60-----
RTimeDiff =msgTime                                                              '--! 61-----
end function                                                                    '--! 62-----
                                                                                '--! 63-----
                                                                                '--! 64-----
function addSave()                                                              '--! 65-----
                                                                                '--! 66-----
                                                                                '--! 67-----
add=inputbox("��Ҫ��¼������ :")                                                       '--! 68-----
if add = "" then                                                                '--! 69-----
else                                                                            '--! 70-----
saveall()
set file = fs.opentextfile("c:\saveHabit.txt",8,true)                              '--! 71-----
t=Now                                                                           '--! 72-----
                                                                                '--! 73-----
file.writeline add                                                              '--! 74-----
file.writeline t                                                                '--! 75-----
msgbox "�����Ӽ�¼:"&add&"    "&t                                                    '--! 76-----
                                                                                '--! 77-----
file.close                                                                      '--! 78-----
end if                                                                          '--! 79-----
end function                                                                    '--! 80-----
                                                                                '--! 81-----
                                                                                '--! 82-----
                                                                                '--! 83-----
function delSave()                                                              '--! 84-----
msgbox "���ס��Ҫɾ���ļ�¼�����"                                                          '--! 85-----
if LookAllSave() then                                                           '--! 86-----
dim numofSave                                                                   '--! 87-----
numOfSave = inputbox("����������Ҫɾ������� (Ҫ���ֵ�Ŷ~!):")                                  '--! 88-----
if IsNumeric(numOfSave) then                                                    '--! 89-----
                                                                                '--! 90-----
set del =fs.opentextfile("c:\saveHabit.txt",1,false)                               '--! 91-----
set tmp = fs.createtextfile("86tmp.txt",true)                                   '--! 92-----
dim numOfLine                                                                   '--! 93-----
numOfline=1                                                                     '--! 94-----
do while del.AtEndOfStream<>true                                                '--! 95-----
if numOfLine = cInt(numOfSave) then                                             '--! 96-----
                                                                                '--! 97-----
	st=del.readline                                                                 '--! 98-----
	tt=del.readline                                                                 '--! 99-----
	msign=msgbox("���ҵ���Ҫɾ����ѡ��Ϊ     :"&st,vbOKCancel)                                 '--! 100----
	if msign<>vbok then                                                             '--! 101----
                                                                                '--! 102----
	tmp.writeline st                                                                '--! 103----
	tmp.writeline tt                                                                '--! 104----
	msgbox "������˲���!!!!"                                                             '--! 105----
	end if                                                                          '--! 106----
else                                                                            '--! 107----
	tmp.writeline del.readline                                                      '--! 108----
	tmp.writeline del.readline                                                      '--! 109----
end if                                                                          '--! 110----
numOfline=numOfline+1                                                           '--! 111----
                                                                                '--! 112----
loop                                                                            '--! 113----
del.close                                                                       '--! 114----
tmp.close                                                                       '--! 115----
saveall()
fs.deletefile("c:\saveHabit.txt")                                 '--! 116----

set del2 =fs.opentextfile("c:\saveHabit.txt",2,true)                                '--! 117----
set tmp2 = fs.opentextfile("86tmp.txt",1)                                        '--! 118----
                                                                                '--! 119----
do while tmp2.AtEndOfStream<>true                                                '--! 120----
del2.writeline tmp2.readline                                                      '--! 121----
loop                                                                            '--! 122----
del2.close                                                                       '--! 123----
tmp2.close                                                                       '--! 124----
fs.deletefile("86tmp.txt")                                                      '--! 125----
  else                                                                            '--! 126----
	msgbox "������Ĳ�������"                                                               '--! 127----
  end if                                                                          '--! 128----
                                                                                '--! 129----
	end if                                                                          '--! 130----
msgbox "ɾ���ɹ�!!!!!!!"                                                            '--! 131----
end function                                                                    '--! 132----
                                                                                '--! 133----
                                                                                '--! 134----
function refreshSave()                                                          '--! 135----                                                                                '--! 136----                              
msgbox "���ס��Ҫ���µļ�¼�����"                                                          '--! 85-----
if LookAllSave() then                                                           '--! 86-----
dim numofSave                                                                   '--! 87-----
numOfSave = inputbox("����������Ҫ���µ���� (Ҫ���ֵ�Ŷ~!):")                                  '--! 88-----
if IsNumeric(numOfSave) then                                                    '--! 89-----
                                                                                '--! 90-----
set del =fs.opentextfile("c:\saveHabit.txt",1,false)                               '--! 91-----
set tmp = fs.createtextfile("86tmp.txt",true)                                   '--! 92-----
dim numOfLine                                                                   '--! 93-----
numOfline=1                                                                     '--! 94-----
do while del.AtEndOfStream<>true                                                '--! 95-----
if numOfLine = cInt(numOfSave) then                                             '--! 96-----
                                                                                '--! 97-----
	st=del.readline                                                                 '--! 98-----
	tt=del.readline                                                                 '--! 99-----
	msign=msgbox("���ҵ���Ҫ���µ�ѡ��Ϊ     :"&st,vbOKCancel)                                 '--! 100----
	if msign=vbok then                                                             '--! 101----
                                                                                '--! 102----
	tmp.writeline st                                                                '--! 103----
	tmp.writeline Now                                                                '--! 104----
	else	
	msgbox "������˲���!!!!"                                                             '--! 105----
	end if                                                                          '--! 106----
else                                                                            '--! 107----
	tmp.writeline del.readline                                                      '--! 108----
	tmp.writeline del.readline                                                      '--! 109----
end if                                                                          '--! 110----
numOfline=numOfline+1                                                           '--! 111----
                                                                                '--! 112----
loop                                                                            '--! 113----
del.close                                                                       '--! 114----
tmp.close                                                                       '--! 115----
saveall()
fs.deletefile("c:\saveHabit.txt")                                 '--! 116----

set del1 =fs.opentextfile("c:\saveHabit.txt",2,true)                                '--! 117----
set tmp1 = fs.opentextfile("86tmp.txt",1)                                        '--! 118----
                                                                                '--! 119----
do while tmp1.AtEndOfStream<>true                                                '--! 120----
del1.writeline tmp1.readline                                                      '--! 121----
loop                                                                            '--! 122----
del1.close                                                                       '--! 123----
tmp1.close                                                                       '--! 124----
fs.deletefile("86tmp.txt")                                                      '--! 125----
  else                                                                            '--! 126----
	msgbox "������Ĳ�������"                                                               '--! 127----
  end if                                                                          '--! 128----
                                                                                '--! 129----
	end if                                                                          '--! 130----
msgbox "���³ɹ�!!!!!!!"                                                            '--! 131----
end function                                                           '--! 186----
function changeSave()                                                           '--! 187----
if fs.FileExists("c:\saveHabit.txt") and fs.FileExists("c:\oldHabit.txt") then    '--! 188----
                                                                                '--! 189----
ss=msgbox("��ȷ����Ҫ���ϵ����ݻ�ԭ����",vbokcancel)                                          '--! 190----
if	ss=vbok then                                                                 '--! 191----
fs.deletefile("c:\saveHabit.txt")                                                  '--! 192----
fs.movefile "c:\oldHabit.txt","c:\saveHabit.txt"                                  '--! 193----
saveall()
else                                                                            '--! 194----
msgbox "������˲���!!!"                                                              '--! 195----
end if                                                                          '--! 196----
else                                                                            '--! 197----
msgbox "�ļ������� ���޷�����!"                                                           '--! 198----
end if                                                                          '--! 199----
end function                                                                    '--! 200----
function saveall()
set ofile = fs.createtextfile("c:\oldHabit.txt",true)
set nfile= fs.opentextfile("c:\saveHabit.txt",1,true)
do while nfile.AtEndOfStream<>true 
ofile.writeline nfile.readline
loop
end function
function delall()
if	fs.FileExists("c:\saveHabit.txt") then
fs.deletefile("c:\saveHabit.txt")
msgbox "��������ݣ������մ���,��ʹ�ù���5�ָ����ݣ�"
else
msgbox "û�����ݿ������!!!"
end if

end function