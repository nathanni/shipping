<%
'
' Barcode Generator (c) 2003, Lake Avenue Church, www.lakeave.org
'
' This program will generate the simpler Code39 (or Code 3-for-9) barcodes.
' You'll find these barcodes on staff and student ID badges, video rental
' cards and so on.
'
' Basically, the code starts and ends with an asterisk.
' Inbetween the *'s, you can use - , $ / + %, space, A-Z and 0-9.
'
' Code39 works with alternating bands of black and white. Each character
' is represented by 7 bands. The band is either wide or narrow. Inbetween
' each character there is a band of white the same width as the narrow band.
'
' This code looks for the string strBarCode, which is not defined in this
' code. It's assumed that you would define the variable and then call the
' program as an include.
'
' Height and Width are defined by the variables numWidth and numHeight,
' allowing you to customize as needed.
'
' The code could probably be optimized and cleaned up; this was just a quick
' program to solve a need we had here. If you find the code useful, I'd
' love to hear from you. James Lamb, jamesl@lakeave.org
'
%>
<%
redim a(44)
a(1)="1wnnwnnnnw"
a(2)="2nnwwnnnnw"
a(3)="3wnwwnnnnn"
a(4)="4nnnwwnnnw"
a(5)="5wnnwwnnnn"
a(6)="6nnwwwnnnn"
a(7)="7nnnwnnwnw"
a(8)="8wnnwnnwnn"
a(9)="9nnwwnnwnn"
a(10)="0nnnwwnwnn"
a(11)="Awnnnnwnnw"
a(12)="Bnnwnnwnnw"
a(13)="Cwnwnnwnnn"
a(14)="Dnnnnwwnnw"
a(15)="Ewnnnwwnnn"
a(16)="Fnnwnwwnnn"
a(17)="Gnnnnnwwnw"
a(18)="Hwnnnnwwnn"
a(19)="Innwnnwwnn"
a(20)="Jnnnnwwwnn"
a(21)="Kwnnnnnnww"
a(22)="Lnnwnnnnww"
a(23)="Mwnwnnnnwn"
a(24)="Nnnnnwnnww"
a(25)="Ownnnwnnwn"
a(26)="Pnnwnwnnwn"
a(27)="Qnnnnnnwww"
a(28)="Rwnnnnnwwn"
a(29)="Snnwnnnwwn"
a(30)="Tnnnnwnwwn"
a(31)="Uwwnnnnnnw"
a(32)="Vnwwnnnnnw"
a(33)="Wwwwnnnnnn"
a(34)="Xnwnnwnnnw"
a(35)="Ywwnnwnnnn"
a(36)="Znwwnwnnnn"
a(37)="-nwnnnnwnw"
a(38)=".wwnnnnwnn"
a(39)=" nwwnnnwnn"
a(40)="*nwnnwnwnn"
a(41)="$nwnwnwnnn"
a(42)="/nwnwnnnwn"
a(43)="+nwnnnwnwn"
a(44)="%nnnwnwnwn"

numNarrow=2
numHeight=30

strBarCode="*" & strBarCode & "*"
strConv=""
' response.write strBarCode

for t=1 to len(strBarCode)
	for s=1 to 44
		if mid(strBarCode,t,1)=left(a(s),1) then
			strConv=strConv & right(a(s),9)&"s"
		end if
	next
next

' response.write strconv & "<p>"

b=1

for t=1 to len(strConv)
	if mid(strConv,t,1)="n" then
		if b=1 then response.write "<img src=images/shim_black.gif width=" & numNarrow & " height=" & numHeight & ">"
		if b=0 then response.write "<img src=images/shim.gif width=" & numNarrow & " height=" & numHeight & ">"
		b=b+1
		if b=2 then b=0
	end if

	if mid(strConv,t,1)="w" then
		if b=1 then response.write "<img src=images/shim_black.gif width=" & numNarrow*2 & " height=" & numHeight & ">"
		if b=0 then response.write "<img src=images/shim.gif width=" & numNarrow*2 & " height=" & numHeight & ">"
		b=b+1
		if b=2 then b=0
	end if

	if mid(strconv,t,1)="s" then
		response.write "<img src=images/shim.gif width=" & numNarrow & " height=" & numHeight & ">"
		b=1
	end if
next
%>
