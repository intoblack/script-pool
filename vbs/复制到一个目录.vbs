path1=inputbox("������·��:")                                                        '--! 1------
path2=inputbox("���Ƶ���·��")                                                        '--! 2------
houzhui=inputbox("Ҫ���Ƶĺ�׺(.txt...)")                                             '--! 3------
Set fs = CreateObject("scripting.filesystemobject")                             '--! 4------
                                                                                '--! 5------
findFile path1,houzhui                                                          '--! 6------
msgbox("��ɶ�"&path1&"��"&houzui&"����!")                                                                                '--! 7------
function findFile(path,houzhui)                                                 '--! 8------
set folder=fs.getfolder(path)                                                   '--! 9------
set subfolder=folder.subfolders                                                 '--! 10-----
set file=folder.files                                                           '--! 11-----
                                                                                '--! 12-----
for Each i In file                                                              '--! 13-----
if right(i.name,3)=houzhui then                                                 '--! 14-----
fs.copyfile i,path2                                                             '--! 15-----
                                                                      '--! 16-----
fs.deletefile i
end if                                                                          '--! 17-----
                                                                                '--! 18-----
                                                                                '--! 19-----
next                                                                            '--! 20-----
for Each j In subfolder                                                         '--! 21-----
findFile j.path,houzhui                                                                 '--! 22-----
next                                                                            '--! 23-----
                                                                                '--! 24-----
                                                                                '--! 25-----
                                                                                '--! 26-----
end function                                                                    '--! 27-----
