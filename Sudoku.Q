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
Enable=0
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


//===============================常量========================================

sidelength = 58
white = "FFFFFF"
deleyer = 50

//笔记按钮坐标
notebutton_x = 496
notebutton_y = 672

//第一个数字的坐标
firstnum_x = 596
firstnum_y = 671

firstblock_x = 572
firstblock_y = 141

//=================================END=======================================




//===============================子过程======================================

Sub notemode  //切换note模式
    MoveTo notebutton_x, notebutton_y
    LeftClick 1
    Delay delayer
End sub

Sub OneRow_CheckClick(r)//一行判断点击
    Dim c
    Dim x
    Dim y
    For c=0 to 8
        x = c * sidelength + firstblock_x
        y = r * sidelength + firstblock_y
        If GetPixelColor(x, y) = white Then 
            MoveTo x, y
            LeftClick 1
            Delay delayer
        End If 
    Next
End Sub

Sub OneBoard_CheckClick//一列判断点击
    Dim r
    For r=0 to 8
        Call OneRow_CheckClick(r)
    Next
End Sub
        
Sub AllBoards_CheckClick//整版判断点击
    Dim number
    For number = 0 To 8
        MoveTo number * sidelength + firstnum_x, firstnum_y
        LeftClick 1
        Delay delayer
        Call OneBoard_CheckClick
    Next
End Sub
//=================================END=======================================






//第一步：全部标满

Call notemode

Call AllBoards_CheckClick




//第二步：取消标记
number=0
Do While number < 9
    MoveTo number * sidelength + 596, 671
	
    LeftClick 1

    Delay delayer

    For pointc=0 to 8
        pointx = pointc * sidelength + 572
        pointy= pointr*sidelength+141
        GetColor = GetPixelColor(pointx, pointy)




	
	
        intY = 112

        Do 
            FindColor 565,intY,1089,635,"93691E",intX,intY 
            If intX > 0 And intY > 0 Then 

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * sidelength + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)

                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX+29
                    pointy= pointr*sidelength+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + sidelength or intX + 29 > 565 + sidelength * 3 and intX + 29 < 565 + sidelength * 4 or intX + 29 > 565 + sidelength * 6 and intX + 29 < 565 + sidelength * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+sidelength and intX + 29 < 565 + sidelength*2 or intX + 29 > 565 + sidelength * 4 and intX + 29 < 565 + sidelength * 5 or intX + 29 > 565 + sidelength * 7 and intX + 29 < 565 + sidelength * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+sidelength*2 and intX + 29 < 565 + sidelength*3 or intX + 29 > 565 + sidelength * 5 and intX + 29 < 565 + sidelength * 6 or intX + 29 > 565 + sidelength * 8 and intX + 29 < 565 + sidelength * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                GetColor = GetPixelColor(intX+sidelength*x1, intY+sidelength*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+sidelength*x2, intY+sidelength*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+sidelength*x1, intY+sidelength*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+sidelength*x2, intY+sidelength*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer



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



Call notemode    //解除note模式





Rem 第三步
//第三步：填充每行列缺少的个数为一的数字

number=0
Do While number < 9
    MoveTo number * sidelength + 596, 671
	
    LeftClick 1

    Delay delayer
        
    Rem 从这个数字开头开始
    //每行


    For pointr = 0 To 8
        MoveTo 550,pointr * sidelength + 141  //展示进度
        colornum=0
        For pointc=0 to 8
            pointx = pointc * sidelength + 572
            pointy= pointr*sidelength+141
            GetColor = GetPixelColor(pointx, pointy)

            If getcolor = "FBE2E4" Then 
                colornum=colornum+1
                goodcolor=pointc
            End If
        Next
        
        
        If colornum = 1 Then 
   
            FindColor 565,pointr * sidelength + 141,089,pointr * sidelength + 141,"93691E",intX3,intY3
            If intX3 > 0 And intY3 > 0 Then 
        
            Else 
                MoveTo goodcolor * sidelength + 572+29, pointr * sidelength + 141  //填充数字
                LeftClick 1
                Delay delayer
                    
                  
                Call notemode
               
  
                intX2 = goodcolor * sidelength + 572
                intY2 =  pointr * sidelength + 141-29
                //重复第二步
                //--------------------------------


                intX = intX2 + 5
                intY = intY2

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * sidelength + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX
                    pointy= pointr*sidelength+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + sidelength or intX + 29 > 565 + sidelength * 3 and intX + 29 < 565 + sidelength * 4 or intX + 29 > 565 + sidelength * 6 and intX + 29 < 565 + sidelength * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+sidelength and intX + 29 < 565 + sidelength*2 or intX + 29 > 565 + sidelength * 4 and intX + 29 < 565 + sidelength * 5 or intX + 29 > 565 + sidelength * 7 and intX + 29 < 565 + sidelength * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+sidelength*2 and intX + 29 < 565 + sidelength*3 or intX + 29 > 565 + sidelength * 5 and intX + 29 < 565 + sidelength * 6 or intX + 29 > 565 + sidelength * 8 and intX + 29 < 565 + sidelength * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX + sidelength * x1, intY + sidelength * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX + sidelength * x2, intY + sidelength * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX + sidelength * x1, intY + sidelength * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX + sidelength * x2, intY + sidelength * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer



                End If


                //重复结束---------------------------------------------

                
                Call notemode  //解除note模式
                
                Goto 从这个数字开头开始
                
            End If
        	
        End If

    Next

    //每列
    For pointc = 0 To 8
        MoveTo pointc * sidelength + 572+29 ,90 //展示进度
        colornum=0
        For pointr=0 to 8
            pointx = pointc * sidelength + 572
            pointy= pointr*sidelength+141
            GetColor = GetPixelColor(pointx, pointy)

            If getcolor = "FBE2E4" Then 
                colornum=colornum+1
                goodcolor=pointr
            End If
        Next
        
        If colornum = 1 Then 
   
            FindColor pointc*sidelength+572,112,pointc*sidelength+572,635,"93691E",intX3,intY3
            If intX3 > 0 And intY3 > 0 Then 
        
            Else 
                MoveTo pointc * sidelength + 572+29, goodcolor * sidelength + 141  //填充数字
                LeftClick 1
                Delay delayer
                
              
                Call notemode
               
                intX2 = pointc * sidelength + 572
                intY2 =goodcolor * sidelength + 141-29
                //重复第二步
                //--------------------------------


                intX = intX2 + 5
                intY = intY2

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * sidelength + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX
                    pointy= pointr*sidelength+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + sidelength or intX + 29 > 565 + sidelength * 3 and intX + 29 < 565 + sidelength * 4 or intX + 29 > 565 + sidelength * 6 and intX + 29 < 565 + sidelength * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+sidelength and intX + 29 < 565 + sidelength*2 or intX + 29 > 565 + sidelength * 4 and intX + 29 < 565 + sidelength * 5 or intX + 29 > 565 + sidelength * 7 and intX + 29 < 565 + sidelength * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+sidelength*2 and intX + 29 < 565 + sidelength*3 or intX + 29 > 565 + sidelength * 5 and intX + 29 < 565 + sidelength * 6 or intX + 29 > 565 + sidelength * 8 and intX + 29 < 565 + sidelength * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX + sidelength * x1, intY + sidelength * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX + sidelength * x2, intY + sidelength * y1 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX + sidelength * x1, intY + sidelength * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX + sidelength * x2, intY + sidelength * y2 + 29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer



                End If


                //重复结束---------------------------------------------

                Call notemode  //解除note模式
                
                Goto 从这个数字开头开始
            End If
        	
        End If

    Next
    //每九宫格
    For y2 = 1 To 3
        For x2 = 1 To 3
            MoveTo 652 + sidelength * 3 * (x2 - 1), 199 + sidelength * 3 * (y2 - 1)
            colornum = 0
            For y = 1 To 3
                For x = 1 To 3
                    GetColor = GetPixelColor(sidelength * x + sidelength * 3 * (x2 - 1) + 514, sidelength * y + 83 + sidelength * 3 * (y2 - 1))
                    If getcolor = "FBE2E4" Then
                        colornum = colornum + 1
                        goodcolorx = x
                        goodcolory = y
                    End If
                Next	
            Next

            If colornum = 1 Then 
                FindColor 594+ sidelength * 3 * (x2 - 1), 141+ sidelength * 3 * (y2 - 1), 710+ sidelength * 3 * (x2 - 1), 257+ sidelength * 3 * (y2 - 1), "93691E", intX, intY
                If intX > 0 And intY > 0 Then
                Else
                    MoveTo sidelength * goodcolorx + 514+ sidelength * 3 * (x2 - 1), sidelength * goodcolory + 83+ sidelength * 3 * (y2 - 1)
                    LeftClick 1
                    Delay delayer
                    
                    Call notemode
                    
                    intX2 = sidelength * goodcolorx + 514+ sidelength * 3 * (x2 - 1)-29
                    intY2 = sidelength * goodcolory + 83+ sidelength * 3 * (y2 - 1)-29
                    //重复第二步
                    //--------------------------------


                    intX = intX2 + 5
                    intY = intY2

                    //一行判断点击
                    For pointc=0 to 8
                        pointx = pointc * sidelength + 572
                        pointy= intY+29
                        GetColor = GetPixelColor(pointx, pointy)
                        If getcolor = "FBE2E4" Then 
                            MoveTo pointx, pointy
                            LeftClick 1
                            Delay delayer
                        End If
                    next

                    //一列判断点击
                    For pointr=0 to 8
                        pointx = intX
                        pointy= pointr*sidelength+ 137
                        GetColor = GetPixelColor(pointx, pointy)
                        If getcolor = "FBE2E4" Then 
                            MoveTo pointx, pointy
                            LeftClick 1
                            Delay delayer
                        End If
                    Next


                    //九宫格点击
                    If intX + 29 > 565 and intX + 29 < 565 + sidelength or intX + 29 > 565 + sidelength * 3 and intX + 29 < 565 + sidelength * 4 or intX + 29 > 565 + sidelength * 6 and intX + 29 < 565 + sidelength * 7 Then 
                        //一列
                        x1 = 1
                        x2 = 2
                        If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                            //一列一行
                            y1 = 1
                            y2 = 2
                        End If
                        //一列二行
                        If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 
                            y1 = -1
                            y2 = 1
                        End If
                        //一列三行
                        If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 
                            y1 = - 2 
                            y2 = - 1 
                        End If

                    End If







                    If intX + 29 > 565+sidelength and intX + 29 < 565 + sidelength*2 or intX + 29 > 565 + sidelength * 4 and intX + 29 < 565 + sidelength * 5 or intX + 29 > 565 + sidelength * 7 and intX + 29 < 565 + sidelength * 8 Then 
                        //二列
                        x1 = -1
                        x2 = 1
                        If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                            //二列一行
                            y1 = 1
                            y2 = 2
                        End If
                        //二列二行
                        If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                            y1 = -1
                            y2 = 1
                        End If
                        //二列三行
                        If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                            y1 = - 2 
                            y2 = - 1 
                        End If

                    End If



                    If intX + 29 > 565+sidelength*2 and intX + 29 < 565 + sidelength*3 or intX + 29 > 565 + sidelength * 5 and intX + 29 < 565 + sidelength * 6 or intX + 29 > 565 + sidelength * 8 and intX + 29 < 565 + sidelength * 9 Then 
                        //三列
                        x1 = -2
                        x2 = -1
                        If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                            //三列一行
                            y1 = 1
                            y2 = 2
                        End If
                        //三列二行
                        If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                            y1 = -1
                            y2 = 1
                        End If
                        //三列三行
                        If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                            y1 = - 2 
                            y2 = - 1 
                        End If

                    End If




  

                    GetColor = GetPixelColor(intX + sidelength * x1, intY + sidelength * y1 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+sidelength*x1, intY+sidelength*y1+29
                        LeftClick 1
                        Delay delayer
                    End If

                    GetColor = GetPixelColor(intX + sidelength * x2, intY + sidelength * y1 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+sidelength*x2, intY+sidelength*y1+29
                        LeftClick 1
                        Delay delayer
                    End If

                    GetColor = GetPixelColor(intX + sidelength * x1, intY + sidelength * y2 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+sidelength*x1, intY+sidelength*y2+29
                        LeftClick 1
                        Delay delayer
                    End If

                    GetColor = GetPixelColor(intX + sidelength * x2, intY + sidelength * y2 + 29)
                    If getcolor = "FBE2E4" Then 
                        MoveTo intX+sidelength*x2, intY+sidelength*y2+29
                        LeftClick 1
                        Delay delayer



                    End If


                    //重复结束---------------------------------------------

                    Call notemode  //解除note模式
                
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
Delay delayer
Y = 112
X = 565

Rem 重新开始
MoveTo 1173, 369    //点击空白处消除数字选中
LeftClick 1
Delay delayer



//全行判断
For pointr = 0 To 8
    //一行判断
    For pointc = 0 To 8

        MoveTo 1173, 369    //点击空白处消除数字选中
        LeftClick 1
        Delay delayer

        pointx = pointc * sidelength + 572
        pointy= pointr*sidelength+141
        GetColor = GetPixelColor(pointx, pointy)

        If getcolor = white Then 
            intX2 = pointx-2    //兼容后面的代码
            intY2 = pointy-29
	 

            colornum = 0
	





            For number=0 to 8
                MoveTo number * sidelength + 596, 671  //选数字
                LeftClick 1
                Delay delayer
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
                Delay delayer
                MoveTo number * sidelength + 596, 671
                LeftClick 1
                Delay delayer

                MoveTo intX2 + 5, intY2 + 29
                LeftClick 1
                Delay delayer
                Call notemode//解除note模式
                
                
                //重复第二步
                //--------------------------------


                GetColor = GetPixelColor(pointx, pointy)


                intX = intX2 + 5
                intY = intY2

                //一行判断点击
                For pointc=0 to 8
                    pointx = pointc * sidelength + 572
                    pointy= intY+29
                    GetColor = GetPixelColor(pointx, pointy)

                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX+29
                    pointy= pointr*sidelength+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = "FBE2E4" Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                Next


                //九宫格点击
                If intX + 29 > 565 and intX + 29 < 565 + sidelength or intX + 29 > 565 + sidelength * 3 and intX + 29 < 565 + sidelength * 4 or intX + 29 > 565 + sidelength * 6 and intX + 29 < 565 + sidelength * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + 29 > 565+sidelength and intX + 29 < 565 + sidelength*2 or intX + 29 > 565 + sidelength * 4 and intX + 29 < 565 + sidelength * 5 or intX + 29 > 565 + sidelength * 7 and intX + 29 < 565 + sidelength * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + 29 > 565+sidelength*2 and intX + 29 < 565 + sidelength*3 or intX + 29 > 565 + sidelength * 5 and intX + 29 < 565 + sidelength * 6 or intX + 29 > 565 + sidelength * 8 and intX + 29 < 565 + sidelength * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + 29 > 112 and intY + 29 < 112 + sidelength or intY + 29 > 112 + sidelength * 3 and intY + 29 < 112 + sidelength * 4 or intY + 29 > 112 + sidelength * 6 and intY + 29 < 112 + sidelength * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + 29 > 112+sidelength and intY + 29 < 112 + sidelength*2 or intY + 29 > 112 + sidelength * 4 and intY + 29 < 112 + sidelength * 5 or intY + 29 > 112 + sidelength * 7 and intY + 29 < 112 + sidelength * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + 29 > 112+sidelength*2 and intY + 29 < 112 + sidelength*3 or intY + 29 > 112 + sidelength * 5 and intY + 29 < 112 + sidelength * 6 or intY + 29 > 112 + sidelength * 8 and intY + 29 < 112 + sidelength * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX+sidelength*x1, intY+sidelength*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+sidelength*x2, intY+sidelength*y1+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y1+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+sidelength*x1, intY+sidelength*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x1, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+sidelength*x2, intY+sidelength*y2+29)
                If getcolor = "FBE2E4" Then 
                    MoveTo intX+sidelength*x2, intY+sidelength*y2+29
                    LeftClick 1
                    Delay delayer



                End If


                //重复结束---------------------------------------------

                Call notemode  //解除note模式
              


                Goto 重新开始

            End If
            
        End If
       
    Next

Next

Goto 第三步