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

blocksize = 58
halfsize = blocksize / 2
white = "FFFFFF"
purple = "FBE2E4"
blue = "93691E"  //选中一个区块的时候，区块边缘的深蓝色
deleyer = 50

//数版位置坐标
topleft_x = 565
topleft_y = 112
botright_x = 1089
botright_y = 635

//笔记按钮坐标
notebutton_x = 496
notebutton_y = 672

//第一个方块的坐标
firstblock_x = topleft_x + blocksize / 8
firstblock_y = topleft_y + halfsize

//第一个数字的坐标
firstnum_x = 596
firstnum_y = 671



//=================================END=======================================




//===============================子过程======================================

Sub notemode	//开关note模式
    MoveTo notebutton_x, notebutton_y
    LeftClick 1
    Delay delayer
End Sub

Sub Color_Click(x, y, col) //某点判断颜色点击
    If GetPixelColor(x, y) = col Then 
        MoveTo x, y
        LeftClick 1
        Delay delayer
    End If 
End Sub


Sub OneRow_CheckClick(r, col)	//某行判断颜色点击
    Dim c, x, y
    For c=0 to 8
        x = c * blocksize + firstblock_x
        y = r * blocksize + firstblock_y
        Call Color_Click(x, y, col)
    Next
End Sub



Sub OneY_CheckClick(y, col)	//某y坐标判断颜色点击 临时
    Dim c, x
    For c=0 to 8
        x = c * blocksize + firstblock_x
        Call Color_Click(x, y, col)
    Next
End Sub

Sub OneX_CheckClick(x, col)	//某x坐标判断颜色点击 临时
    Dim c, y
    For c=0 to 8
        y = c * blocksize + firstblock_y
        Call Color_Click(x, y, col)
    Next
End Sub




Sub OneBoard_CheckClick(col)	//整版判断颜色点击
    Dim r
    For r=0 to 8
        Call OneRow_CheckClick(r, white)
    Next
End Sub
        
Sub AllBoards_CheckClick(col)	//所有数版判断颜色点击
    Dim number
    For number = 0 To 8
        MoveTo number * blocksize + firstnum_x, firstnum_y
        LeftClick 1
        Delay delayer
        Call OneBoard_CheckClick(col)
    Next
End Sub


Function x_of_c(c)  //根据列找x坐标
    x_of_c = c * blocksize + firstblock_x
End Function

Function y_of_r(r)  //根据行找y坐标
    y_of_r = r * blocksize + firstblock_y
End Function

Function localize_c(x)	//定位x的列
    localize_c = (x + halfsize - topleft_x) \ blocksize + 1
End Function

Function localize_r(y)	//定位y的行
    localize_r = (y + halfsize - topleft_y) \ blocksize + 1
End Function

Function relative_c(x)	//定位x的相对行
    relative_c = localize_c(x) mod 3
End Function

Function relative_r(y)	//定位y的相对行
    relative_r = localize_r(y) mod 3
End Function

Sub delnote_related(x, y)//传入方块坐标，删除同行同列同九宫格的note
    Dim x1, x2, y1, y2

    //一行消除标记
    Call OneY_CheckClick(y, purple)

    //一列消除标记
    Call OneX_CheckClick(x, purple)

    //九宫格点击
    If relative_c(x) = 1 Then 
        x1 = 1
        x2 = 2
    ElseIf relative_c(x) = 2 Then
        x1 = - 1
        x2 = 1
    Else 
        x1 = - 2
        x2 = - 1
    End If

    If relative_r(y) = 1 Then 
        y1 = 1
        x2 = 2
    ElseIf relative_r(y) = 2 Then
        y1 = - 1
        y2 = 1
    Else 
        y1 = - 2
        y2 = - 1
    End If

    Call Color_Click(x - 20 + blocksize * x1, y + blocksize * y1, purple)   // 中心向左移动20是取颜色的安全点 
    Call Color_Click(x - 20 + blocksize * x2, y + blocksize * y1, purple)
    Call Color_Click(x - 20 + blocksize * x1, y + blocksize * y2, purple)
    Call Color_Click(x - 20 + blocksize * x2, y + blocksize * y2, purple)

End Sub

Sub delnote_number	//删除一页中所有冲突的标记
    Dim intX, intY
    intY = topleft_y
    Do While intY < botright_y
        FindColor topleft_x, intY, botright_x, botright_y, blue, intX, intY  //这里为什么是intY而不是topleft_y？

        If intX > 0 And intY > 0 Then 
            Call delnote_related(intX + halfsize, intY + halfsize)
        End if
        intY = intY + blocksize
    Loop
End Sub

Sub fill_and_delnote(x, y)  //填充数字并删除冲突标记（填充模式进，填充模式出）
    MoveTo x, y 	//填充数字
    LeftClick 1
    Delay delayer
    Call notemode  
    Call delnote_related(x, y) 
    Call notemode  //解除note模式
End Sub

Sub step3_single_number
    Dim c, r, x, y, area_c, area_r, small_c, small_r, colornum, goodcolor
    //每行
    For r = 0 To 8
        MoveTo topleft_x - halfsize, y_of_r(r)  //展示进度
        colornum = 0
        For c=0 to 8
            x = x_of_c(c)
            y = y_of_r(r)
            If GetPixelColor(x, y) = purple Then 
                colornum = colornum + 1 	// 一行中的紫色方块个数计数器
                goodcolor = c 		//一行中最后的一个紫色方块
            End If
        Next
        
        If colornum = 1 Then 
            Call fill_and_delnote(x_of_c(goodcolor), y_of_r(r))
            Call step3_single_number      //这个数字从头开始
        End If
    Next

    //每列
    For c = 0 To 8
        MoveTo x_of_c(c), topleft_y - halfsize  //展示进度
        colornum = 0
        For r=0 to 8
            x = x_of_c(c)
            y = y_of_r(r)
            If GetPixelColor(x, y) = purple Then 
                colornum = colornum + 1 	// 一列中的紫色方块个数计数器
                goodcolor = r 		//一列中最后的一个紫色方块
            End If
        Next
        
        If colornum = 1 Then 
            Call fill_and_delnote(x_of_c(c), y_of_r(goodcolor))
            Call step3_single_number       //这个数字从头开始
        End If
    Next

    //每九宫格
    For area_r = 1 To 3
        For area_c = 1 To 3
            MoveTo x_of_c((area_c - 1) * 3 + 2), y_of_r((area_r - 1) * 3 + 2)
            colornum = 0
            For small_r = 1 To 3
                For small_c = 1 To 3
                    c = (area_c - 1) * 3 + small_c
                    r = (area_r - 1) * 3 + small_r
                    If GetPixelColor(x_of_c(c), y_of_r(r)) = purple Then
                        colornum = colornum + 1
                        goodcolor_c = c
                        goodcolor_r = r
                    End If
                Next
            Next
            If colornum = 1 Then 
                Call fill_and_delnote(x_of_c(c), y_of_r(goodcolor))
                Call step3_single_number       //这个数字从头开始
            End If
        Next
    Next

End Sub


//=================================END=======================================





//第一步：全部标满

Call notemode	//进入note模式
Call AllBoards_CheckClick(white)


//第二步：取消冲突标记
For number = 0 to 8
    MoveTo number * blocksize + firstnum_x, firstnum_y
    LeftClick 1
    Delay delayer
    Call delnote_number
Next


Call notemode    //解除note模式


Rem 第三步
//第三步：填充每行列缺少的个数为一的数字

For number = 0 to 8
    MoveTo number * blocksize + firstnum_x, firstnum_y  //展示进度
    LeftClick 1
    Delay delayer
    Call step3_single_number
Next


//第四步：放数字
MoveTo 1173, 369   //点击空白处消除数字选中
LeftClick 1
Delay delayer
Y = topleft_y
X = topleft_x

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

        pointx = pointc * blocksize + firstblock_x
        pointy= pointr*blocksize+firstblock_y
        GetColor = GetPixelColor(pointx, pointy)

        If getcolor = white Then 
            intX2 = pointx-2    //兼容后面的代码
            intY2 = pointy-halfsize
	 

            colornum = 0
	





            For number=0 to 8
                MoveTo number * blocksize + firstnum_x, firstnum_y  //选数字
                LeftClick 1
                Delay delayer
                getcolor = GetPixelColor(intX2+2, intY2+halfsize)  //判断该格颜色

                If getcolor = purple Then 
                    colornum = colornum + 1
                    goodcolor=number
                End If
            Next

            If  colornum = 1  Then 


                number = goodcolor
                
                MoveTo 1173, 369    //点击空白处消除数字选中
                LeftClick 1
                Delay delayer
                MoveTo number * blocksize + firstnum_x, firstnum_y
                LeftClick 1
                Delay delayer

                MoveTo intX2 + 5, intY2 + halfsize
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
                    pointx = pointc * blocksize + firstblock_x
                    pointy= intY+halfsize
                    GetColor = GetPixelColor(pointx, pointy)

                    If getcolor = purple Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                next

                //一列判断点击
                For pointr=0 to 8
                    pointx = intX+halfsize
                    pointy= pointr*blocksize+ 137
                    GetColor = GetPixelColor(pointx, pointy)
                    If getcolor = purple Then 
                        MoveTo pointx, pointy
                        LeftClick 1
                        Delay delayer
                    End If
                Next


                //九宫格点击
                If intX + halfsize > topleft_x and intX + halfsize < topleft_x + blocksize or intX + halfsize > topleft_x + blocksize * 3 and intX + halfsize < topleft_x + blocksize * 4 or intX + halfsize > topleft_x + blocksize * 6 and intX + halfsize < topleft_x + blocksize * 7 Then 
                    //一列
                    x1 = 1
                    x2 = 2
                    If intY + halfsize > topleft_y and intY + halfsize < topleft_y + blocksize or intY + halfsize > topleft_y + blocksize * 3 and intY + halfsize < topleft_y + blocksize * 4 or intY + halfsize > topleft_y + blocksize * 6 and intY + halfsize < topleft_y + blocksize * 7 Then 
                        //一列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //一列二行
                    If intY + halfsize > topleft_y+blocksize and intY + halfsize < topleft_y + blocksize*2 or intY + halfsize > topleft_y + blocksize * 4 and intY + halfsize < topleft_y + blocksize * 5 or intY + halfsize > topleft_y + blocksize * 7 and intY + halfsize < topleft_y + blocksize * 8 Then 
                        y1 = -1
                        y2 = 1
                    End If
                    //一列三行
                    If intY + halfsize > topleft_y+blocksize*2 and intY + halfsize < topleft_y + blocksize*3 or intY + halfsize > topleft_y + blocksize * 5 and intY + halfsize < topleft_y + blocksize * 6 or intY + halfsize > topleft_y + blocksize * 8 and intY + halfsize < topleft_y + blocksize * 9 Then 
                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If







                If intX + halfsize > topleft_x+blocksize and intX + halfsize < topleft_x + blocksize*2 or intX + halfsize > topleft_x + blocksize * 4 and intX + halfsize < topleft_x + blocksize * 5 or intX + halfsize > topleft_x + blocksize * 7 and intX + halfsize < topleft_x + blocksize * 8 Then 
                    //二列
                    x1 = -1
                    x2 = 1
                    If intY + halfsize > topleft_y and intY + halfsize < topleft_y + blocksize or intY + halfsize > topleft_y + blocksize * 3 and intY + halfsize < topleft_y + blocksize * 4 or intY + halfsize > topleft_y + blocksize * 6 and intY + halfsize < topleft_y + blocksize * 7 Then 
                        //二列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //二列二行
                    If intY + halfsize > topleft_y+blocksize and intY + halfsize < topleft_y + blocksize*2 or intY + halfsize > topleft_y + blocksize * 4 and intY + halfsize < topleft_y + blocksize * 5 or intY + halfsize > topleft_y + blocksize * 7 and intY + halfsize < topleft_y + blocksize * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //二列三行
                    If intY + halfsize > topleft_y+blocksize*2 and intY + halfsize < topleft_y + blocksize*3 or intY + halfsize > topleft_y + blocksize * 5 and intY + halfsize < topleft_y + blocksize * 6 or intY + halfsize > topleft_y + blocksize * 8 and intY + halfsize < topleft_y + blocksize * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If



                If intX + halfsize > topleft_x+blocksize*2 and intX + halfsize < topleft_x + blocksize*3 or intX + halfsize > topleft_x + blocksize * 5 and intX + halfsize < topleft_x + blocksize * 6 or intX + halfsize > topleft_x + blocksize * 8 and intX + halfsize < topleft_x + blocksize * 9 Then 
                    //三列
                    x1 = -2
                    x2 = -1
                    If intY + halfsize > topleft_y and intY + halfsize < topleft_y + blocksize or intY + halfsize > topleft_y + blocksize * 3 and intY + halfsize < topleft_y + blocksize * 4 or intY + halfsize > topleft_y + blocksize * 6 and intY + halfsize < topleft_y + blocksize * 7 Then 
                        //三列一行
                        y1 = 1
                        y2 = 2
                    End If
                    //三列二行
                    If intY + halfsize > topleft_y+blocksize and intY + halfsize < topleft_y + blocksize*2 or intY + halfsize > topleft_y + blocksize * 4 and intY + halfsize < topleft_y + blocksize * 5 or intY + halfsize > topleft_y + blocksize * 7 and intY + halfsize < topleft_y + blocksize * 8 Then 

                        y1 = -1
                        y2 = 1
                    End If
                    //三列三行
                    If intY + halfsize > topleft_y+blocksize*2 and intY + halfsize < topleft_y + blocksize*3 or intY + halfsize > topleft_y + blocksize * 5 and intY + halfsize < topleft_y + blocksize * 6 or intY + halfsize > topleft_y + blocksize * 8 and intY + halfsize < topleft_y + blocksize * 9 Then 

                        y1 = - 2 
                        y2 = - 1 
                    End If

                End If




  

                GetColor = GetPixelColor(intX+blocksize*x1, intY+blocksize*y1+halfsize)
                If getcolor = purple Then 
                    MoveTo intX+blocksize*x1, intY+blocksize*y1+halfsize
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+blocksize*x2, intY+blocksize*y1+halfsize)
                If getcolor = purple Then 
                    MoveTo intX+blocksize*x2, intY+blocksize*y1+halfsize
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+blocksize*x1, intY+blocksize*y2+halfsize)
                If getcolor = purple Then 
                    MoveTo intX+blocksize*x1, intY+blocksize*y2+halfsize
                    LeftClick 1
                    Delay delayer
                End If

                GetColor = GetPixelColor(intX+blocksize*x2, intY+blocksize*y2+halfsize)
                If getcolor = purple Then 
                    MoveTo intX+blocksize*x2, intY+blocksize*y2+halfsize
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