wmplay()                    '--! 1------
function wmplay()                    '--! 2------
Set wmp = CreateObject("WMPlayer.OCX")                     '--! 3------
                    '--! 4------
dim time                    '--! 5------
time = inputbox("����������Լ����ʱ��(s):")                    '--! 6------
wscript.sleep time*1000                    '--! 7------
wmp.URL = "F:\KwDownload\song\S.H.E-������.mp3"                     '--! 8------
Do Until wmp.playState = 1                     '--! 9------
WScript.Sleep 1000                     '--! 10-----
Loop                    '--! 11-----
wscript.quit                    '--! 12-----
                    '--! 13-----
end function                    '--! 14-----
                    '--! 15-----
function wsplay()                    '--! 16-----
set ws=wscript.createobject("wscript.shell")                    '--! 17-----
dim time                    '--! 18-----
time=inputbox("�������������ʾ��ʱ��(s):")                    '--! 19-----
wscript.sleep time*1000                    '--! 20-----
ws.run "F:\KwDownload\song\S.H.E-������.mp3"                    '--! 21-----
end function                    '--! 22-----
