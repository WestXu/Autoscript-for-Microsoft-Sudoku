[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=459e373f-a1e2-4493-ba78-6f89fe389e58
Description=Sudoku
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
//第一步：全部标满
MoveTo 496, 672  //进入note模式
LeftClick 1
Delay 50

For number = 0 To 8
	
    MoveTo number * 59 + 596, 671  //选择最下面的数字
    LeftClick 1
    Delay 50
    //全部判断点击
    For pointr=0 to 8
        //一行判断点击
        For pointc=0 to 8
            pointx = pointc * 58 + 572
            pointy= pointr*58+141
            GetColor = GetPixelColor(pointx, pointy)

            If getcolor = "FFFFFF" Then 
                MoveTo pointx, pointy
                LeftClick 1
                Delay 50
            End If

            
        Next

    Next

Next







//第二步：取消标记
number=0
Do While number < 9
    MoveTo number * 59 + 596, 671
	
    LeftClick 1

    Delay 50

    For pointc=0 to 8
        pointx = pointc * 58 + 572
        pointy= pointr*58+141
        GetColor = GetPixelColor(pointx, pointy)




	
	
        intY = 112

        Do 
            FindColor 565,intY,1089,635,"93691E",intX,intY 
            If intX > 0 And intY > 0 Then 

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * 58 + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)

                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX+29
                    pointy= pointr*58+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + 58 or intX + 29 > 565 + 58 * 3 and intX + 29 < 565 + 58 * 4 or intX + 29 > 565 + 58 * 6 and intX + 29 < 565 + 58 * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+58 and intX + 29 < 565 + 58*2 or intX + 29 > 565 + 58 * 4 and intX + 29 < 565 + 58 * 5 or intX + 29 > 565 + 58 * 7 and intX + 29 < 565 + 58 * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+58*2 and intX + 29 < 565 + 58*3 or intX + 29 > 565 + 58 * 5 and intX + 29 < 565 + 58 * 6 or intX + 29 > 565 + 58 * 8 and intX + 29 < 565 + 58 * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                GetColor = GetPixelColor(intX+58*x1, intY+58*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y1+29
                    LeftClick 1
                    delay 50
                End If

                GetColor = GetPixelColor(intX+58*x2, intY+58*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y1+29
                    LeftClick 1
                    delay 50
                End If

                GetColor = GetPixelColor(intX+58*x1, intY+58*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y2+29
                    LeftClick 1
                    delay 50
                End If

                GetColor = GetPixelColor(intX+58*x2, intY+58*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y2+29
                    LeftClick 1
                    delay 50



                End If
            Else
                Goto 找不到就跳出
            End if
            intY = intY + 55

        Loop
        Rem 找不到就跳出

    Next
    number=number+1
Loop



MoveTo 496, 672 //解除note模式
LeftClick 1
Delay 50





Rem 第三步
//第三步：填充每行列缺少的个数为一的数字

number=0
Do While number < 9
    MoveTo number * 59 + 596, 671
	
    LeftClick 1

    Delay 50
        
    Rem 从这个数字开头开始
    //每行


    For pointr = 0 To 8
        MoveTo 550,pointr * 58 + 141  //展示进度
        colornum=0
        For pointc=0 to 8
            pointx = pointc * 58 + 572
            pointy= pointr*58+141
            GetColor = GetPixelColor(pointx, pointy)

            If getcolor = "FBE2E4" Then 
                colornum=colornum+1
                goodcolor=pointc
            End If
        Next
        
        
        If colornum = 1 Then 
   
            FindColor 565,pointr * 58 + 141,089,pointr * 58 + 141,"93691E",intX3,intY3
            If intX3 > 0 And intY3 > 0 Then 
        
            Else 
                MoveTo goodcolor * 58 + 572+29, pointr * 58 + 141  //填充数字
                LeftClick 1
                Delay 50
                    
                  
                MoveTo 496, 672
                LeftClick 1
                Delay 50
  
                intX2 = goodcolor * 58 + 572
                intY2 =  pointr * 58 + 141-29
                //重复第二步
                //--------------------------------


                intX = intX2 + 5
                intY = intY2

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * 58 + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX
                    pointy= pointr*58+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + 58 or intX + 29 > 565 + 58 * 3 and intX + 29 < 565 + 58 * 4 or intX + 29 > 565 + 58 * 6 and intX + 29 < 565 + 58 * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+58 and intX + 29 < 565 + 58*2 or intX + 29 > 565 + 58 * 4 and intX + 29 < 565 + 58 * 5 or intX + 29 > 565 + 58 * 7 and intX + 29 < 565 + 58 * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+58*2 and intX + 29 < 565 + 58*3 or intX + 29 > 565 + 58 * 5 and intX + 29 < 565 + 58 * 6 or intX + 29 > 565 + 58 * 8 and intX + 29 < 565 + 58 * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX + 58 * x1, intY + 58 * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y1+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX + 58 * x2, intY + 58 * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y1+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX + 58 * x1, intY + 58 * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y2+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX + 58 * x2, intY + 58 * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y2+29
                    LeftClick 1
                    Delay 50



                End If


                //重复结束---------------------------------------------

                MoveTo 496, 672 //解除note模式
                LeftClick 1
                Delay 50
                
                Goto 从这个数字开头开始
                
            End If
        	
        End If

    Next

    //每列
    For pointc = 0 To 8
        MoveTo pointc * 58 + 572+29 ,90 //展示进度
        colornum=0
        For pointr=0 to 8
            pointx = pointc * 58 + 572
            pointy= pointr*58+141
            GetColor = GetPixelColor(pointx, pointy)

            If getcolor = "FBE2E4" Then 
                colornum=colornum+1
                goodcolor=pointr
            End If
        Next
        
        If colornum = 1 Then 
   
            FindColor pointc*58+572,112,pointc*58+572,635,"93691E",intX3,intY3
            If intX3 > 0 And intY3 > 0 Then 
        
            Else 
                MoveTo pointc * 58 + 572+29, goodcolor * 58 + 141  //填充数字
                LeftClick 1
                Delay 50
                
              
                MoveTo 496, 672
                LeftClick 1
                Delay 50
                intX2 = pointc * 58 + 572
                intY2 =goodcolor * 58 + 141-29
                //重复第二步
                //--------------------------------


                intX = intX2 + 5
                intY = intY2

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * 58 + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX
                    pointy= pointr*58+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + 58 or intX + 29 > 565 + 58 * 3 and intX + 29 < 565 + 58 * 4 or intX + 29 > 565 + 58 * 6 and intX + 29 < 565 + 58 * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+58 and intX + 29 < 565 + 58*2 or intX + 29 > 565 + 58 * 4 and intX + 29 < 565 + 58 * 5 or intX + 29 > 565 + 58 * 7 and intX + 29 < 565 + 58 * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+58*2 and intX + 29 < 565 + 58*3 or intX + 29 > 565 + 58 * 5 and intX + 29 < 565 + 58 * 6 or intX + 29 > 565 + 58 * 8 and intX + 29 < 565 + 58 * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX + 58 * x1, intY + 58 * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y1+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX + 58 * x2, intY + 58 * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y1+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX + 58 * x1, intY + 58 * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y2+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX + 58 * x2, intY + 58 * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y2+29
                    LeftClick 1
                    Delay 50



                End If


                //重复结束---------------------------------------------

                MoveTo 496, 672 //解除note模式
                LeftClick 1
                Delay 50
                
                Goto 从这个数字开头开始
            End If
        	
        End If

    Next
    //每九宫格
    For y2 = 1 To 3
        For x2 = 1 To 3
            MoveTo 652 + 58 * 3 * (x2 - 1), 199 + 58 * 3 * (y2 - 1)
            colornum = 0
            For y = 1 To 3
                For x = 1 To 3
                    GetColor = GetPixelColor(58 * x + 58 * 3 * (x2 - 1) + 514, 58 * y + 83 + 58 * 3 * (y2 - 1))
                    If getcolor = "FBE2E4" Then
                        colornum = colornum + 1
                        goodcolorx = x
                        goodcolory = y
                    End If
                Next	
            Next

            If colornum = 1 Then 
                FindColor 594+ 58 * 3 * (x2 - 1), 141+ 58 * 3 * (y2 - 1), 710+ 58 * 3 * (x2 - 1), 257+ 58 * 3 * (y2 - 1), "93691E", intX, intY
                If intX > 0 And intY > 0 Then
                Else
                    MoveTo 58 * goodcolorx + 514+ 58 * 3 * (x2 - 1), 58 * goodcolory + 83+ 58 * 3 * (y2 - 1)
                    LeftClick 1
                    Delay 50
                    MoveTo 496, 672
                    LeftClick 1
                    Delay 50
  
                    intX2 = 58 * goodcolorx + 514+ 58 * 3 * (x2 - 1)-29
                    intY2 = 58 * goodcolory + 83+ 58 * 3 * (y2 - 1)-29
                    //重复第二步
                    //--------------------------------


                    intX = intX2 + 5
                    intY = intY2

                    //一行判断点击
                    For pointc=0 to 8
                        pointx = pointc * 58 + 572
                        pointy= intY+29
                        GetColor = GetPixelColor(pointx, pointy)
                        If getcolor = "FBE2E4" Then 
                            MoveTo pointx, pointy
                            LeftClick 1
                            Delay 50
                        End If
                    next

                    //一列判断点击
                    For pointr=0 to 8
                        pointx = intX
                        pointy= pointr*58+ 137
                        GetColor = GetPixelColor(pointx, pointy)
                        If getcolor = "FBE2E4" Then 
                            MoveTo pointx, pointy
                            LeftClick 1
                            Delay 50
                        End If
                    Next


                    //九宫格点击
                    If intX + 29 > 565 and intX + 29 < 565 + 58 or intX + 29 > 565 + 58 * 3 and intX + 29 < 565 + 58 * 4 or intX + 29 > 565 + 58 * 6 and intX + 29 < 565 + 58 * 7 Then 
                        //一列
                        x1 = 1
                        x2 = 2
                        If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                            //一列一行
                            y1 = 1
                            y2 = 2
                        End If
                        //一列二行
                        If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 
                            y1 = -1
                            y2 = 1
                        End If
                        //一列三行
                        If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 
                            y1 = - 2 
                            y2 = - 1 
                        End If

                    End If







                    If intX + 29 > 565+58 and intX + 29 < 565 + 58*2 or intX + 29 > 565 + 58 * 4 and intX + 29 < 565 + 58 * 5 or intX + 29 > 565 + 58 * 7 and intX + 29 < 565 + 58 * 8 Then 
                        //二列
                        x1 = -1
                        x2 = 1
                        If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                            //二列一行
                            y1 = 1
                            y2 = 2
                        End If
                        //二列二行
                        If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                            y1 = -1
                            y2 = 1
                        End If
                        //二列三行
                        If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                            y1 = - 2 
                            y2 = - 1 
                        End If

                    End If



                    If intX + 29 > 565+58*2 and intX + 29 < 565 + 58*3 or intX + 29 > 565 + 58 * 5 and intX + 29 < 565 + 58 * 6 or intX + 29 > 565 + 58 * 8 and intX + 29 < 565 + 58 * 9 Then 
                        //三列
                        x1 = -2
                        x2 = -1
                        If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                            //三列一行
                            y1 = 1
                            y2 = 2
                        End If
                        //三列二行
                        If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                            y1 = -1
                            y2 = 1
                        End If
                        //三列三行
                        If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                            y1 = - 2 
                            y2 = - 1 
                        End If

                    End If




  

                    GetColor = GetPixelColor(intX + 58 * x1, intY + 58 * y1 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+58*x1, intY+58*y1+29
                        LeftClick 1
                        Delay 50
                    End If

                    GetColor = GetPixelColor(intX + 58 * x2, intY + 58 * y1 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+58*x2, intY+58*y1+29
                        LeftClick 1
                        Delay 50
                    End If

                    GetColor = GetPixelColor(intX + 58 * x1, intY + 58 * y2 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+58*x1, intY+58*y2+29
                        LeftClick 1
                        Delay 50
                    End If

                    GetColor = GetPixelColor(intX + 58 * x2, intY + 58 * y2 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+58*x2, intY+58*y2+29
                        LeftClick 1
                        Delay 50



                    End If


                    //重复结束---------------------------------------------

                    MoveTo 496, 672 //解除note模式
                    LeftClick 1
                    Delay 50
                
                    Goto 从这个数字开头开始
                End If    
            End If
        Next
    Next
    number = number + 1
loop




//第四步：放数字
MoveTo 1173, 369   //点击空白处消除数字选中
LeftClick 1
Delay 50
Y = 112
X = 565

Rem 重新开始
MoveTo 1173, 369    //点击空白处消除数字选中
LeftClick 1
Delay 50



//全行判断
For pointr = 0 To 8
    //一行判断
    For pointc = 0 To 8

        MoveTo 1173, 369    //点击空白处消除数字选中
        LeftClick 1
        Delay 50

        pointx = pointc * 58 + 572
        pointy= pointr*58+141
        GetColor = GetPixelColor(pointx, pointy)

        If getcolor = "FFFFFF" Then 
            intX2 = pointx-2    //兼容后面的代码
            intY2 = pointy-29
	 

            colornum = 0
	





            For number=0 to 8
                MoveTo number * 59 + 596, 671  //选数字
                LeftClick 1
                Delay 50
                getcolor = GetPixelColor(intX2+2, intY2+29)  //判断该格颜色

                If getcolor = "FBE2E4" Then 
                    colornum = colornum + 1
                    goodcolor=number
                End If
            Next

            If  colornum = 1  Then 


                number = goodcolor
                
                MoveTo 1173, 369    //点击空白处消除数字选中
                LeftClick 1
                Delay 50
                MoveTo number * 59 + 596, 671
                LeftClick 1
                Delay 50

                MoveTo intX2 + 5, intY2 + 29
                LeftClick 1
                Delay 50
                MoveTo 496, 672
                LeftClick 1
                Delay 50

                //重复第二步
                //--------------------------------


                GetColor = GetPixelColor(pointx, pointy)


                intX = intX2 + 5
                intY = intY2

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * 58 + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)

                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX+29
                    pointy= pointr*58+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay 50
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + 58 or intX + 29 > 565 + 58 * 3 and intX + 29 < 565 + 58 * 4 or intX + 29 > 565 + 58 * 6 and intX + 29 < 565 + 58 * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+58 and intX + 29 < 565 + 58*2 or intX + 29 > 565 + 58 * 4 and intX + 29 < 565 + 58 * 5 or intX + 29 > 565 + 58 * 7 and intX + 29 < 565 + 58 * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+58*2 and intX + 29 < 565 + 58*3 or intX + 29 > 565 + 58 * 5 and intX + 29 < 565 + 58 * 6 or intX + 29 > 565 + 58 * 8 and intX + 29 < 565 + 58 * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + 58 or intY + 29 > 112 + 58 * 3 and intY + 29 < 112 + 58 * 4 or intY + 29 > 112 + 58 * 6 and intY + 29 < 112 + 58 * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+58 and intY + 29 < 112 + 58*2 or intY + 29 > 112 + 58 * 4 and intY + 29 < 112 + 58 * 5 or intY + 29 > 112 + 58 * 7 and intY + 29 < 112 + 58 * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+58*2 and intY + 29 < 112 + 58*3 or intY + 29 > 112 + 58 * 5 and intY + 29 < 112 + 58 * 6 or intY + 29 > 112 + 58 * 8 and intY + 29 < 112 + 58 * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX+58*x1, intY+58*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y1+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX+58*x2, intY+58*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y1+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX+58*x1, intY+58*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x1, intY+58*y2+29
                    LeftClick 1
                    Delay 50
                End If

                GetColor = GetPixelColor(intX+58*x2, intY+58*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+58*x2, intY+58*y2+29
                    LeftClick 1
                    Delay 50



                End If


                //重复结束---------------------------------------------

                MoveTo 496, 672 //解除note模式
                LeftClick 1
                Delay 50	
              


                Goto 重新开始

            End If
            
        End If
       
    Next

Next

Goto 第三步