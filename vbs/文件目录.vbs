
set fs=createobject("scripting.filesystemobject")                               '--! 1------
set orderFile=fs.createtextfile("Ŀ¼�ļ�.txt",true)                                '--! 2------
dim sumOfFile                                                                   '--! 3------
folderPath=inputbox("���������ļ���·��:")                                               '--! 4------
                                                                                '--! 5------
findFile folderPath,3                                                           '--! 6------
orderFile.writeline	"                     �ļ���Ŀ�ܹ�Ϊ :"&sumOfFile                  '--! 7------
orderFile.close 
msgbox "����ɶ�"&folderPath&"����"&vbnewLine                                                               '--! 8------
set fs=nothing                                                                     '--! 9------
set orderFile=nothing                                                               '--! 10-----
function findFile(path,n)                                                       '--! 11-----
set folder=fs.getfolder(path)                                                   '--! 12-----
set subfolder=folder.subfolders                                                 '--! 13-----
set file=folder.files                                                           '--! 14-----
orderFile.writeline string(n," ")&folder                                        '--! 15-----
for Each i In file                                                              '--! 16-----
                                                                                '--! 17-----
orderFile.writeline string(n+6," ")&i.path                                      '--! 18-----
sumOfFile=sumOfFile+1                                                           '--! 19-----
next                                                                            '--! 20-----
for Each j In subfolder                                                         '--! 21-----
findFile j,n+3                                                                  '--! 22-----
next                                                                            '--! 23-----
                                                                                '--! 24-----
                                                                                '--! 25-----
                                                                                '--! 26-----
end function                                                                    '--! 27-----