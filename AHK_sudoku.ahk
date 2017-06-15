F10::

;===============================常量========================================

;系统延时
delayer := 30

;鼠标速度
SetDefaultMouseSpeed, 0

PixelSearch, left_x, top_y, 0, 0, 1920, 1080, 0xF3C87A, 0, fast ;整张数独的左上角
If (left_x > 0 And top_y > 0) {
} else {
    MsgBox, Make sure a new game was started!
}

PixelSearch, ax, ay, 0, 0, 1920, 1080, 0x5E4416, 0, fast ;第三个方块的右上角颜色
blocksize := (ax - left_x) // 3 + 1
right_x := left_x + blocksize * 9
bottom_y := top_y + blocksize * 9
halfsize := blocksize // 2

;颜色常量
white := 0xFFFFFF
yellow := 0xE0FDFF
purple := 0xFBE2E4
blue := 0x93691E ;选中一个区块的时候，区块左上角边缘处的深蓝色

;用于循环的数组
nine := [1,2,3,4,5,6,7,8,9]
three := [1,2,3]

;第一个方块的坐标
firstblock_x := left_x + blocksize // 8
firstblock_y := top_y + blocksize // 8

;下方第一个数字的坐标
firstnum_x := left_x + halfsize 
firstnum_y := bottom_y + halfsize

;=================================END=======================================



;第一步：全部标满

notemode() ;进入note模式

For r in nine {
    For c in nine {
        PixelGetColor, Getcolor, x_of_c(c), y_of_r(r)
        If (Getcolor = white or Getcolor = yellow) { 
            MouseMove, x_of_c(c), y_of_r(r)
            Click
            SendInput 123456789
        }
    }
}

clear_selection()

;第二步：取消冲突标记
For number in nine {
    MouseMove, (number - 1) * blocksize + firstnum_x, firstnum_y
    Click
    sleep, delayer
    delnote_number()
}


notemode()    ;解除note模式


第三步:
;第三步：填充每行列缺少的个数为一的数字

For number in nine {
    MouseMove, (number - 1) * blocksize + firstnum_x, firstnum_y
    Click
    sleep, delayer
    step3_single_number()
}


第四步:
;第四步：放数字
filled := 0 ;已放数字个数计数器
;全行判断
For pointr in nine {
    ;一行判断
    For pointc in nine {
        clear_selection()
        pointx := x_of_c(pointc)
        pointy := y_of_r(pointr)
        PixelGetColor, Getcolor, pointx, pointy
        If (Getcolor = white) { 
            colornum := 0

            For number in nine {
                MouseMove, (number - 1) * blocksize + firstnum_x, firstnum_y  ;选数字
                Click
                sleep, delayer

                PixelGetColor, Getcolor, pointx, pointy
                If (Getcolor = purple) {   ;判断该格颜色
                    colornum := colornum + 1
                    goodcolor := number
                }
            }

            If (colornum = 1) { 
            
                clear_selection()
                MouseMove, (goodcolor - 1) * blocksize + firstnum_x, firstnum_y
                Click
                sleep, delayer
                fill_and_delnote(pointx, pointy)
                filled := filled + 1
                step3_single_number()
            }
            
        }
       
    }

}

If (filled = 0) { 
    Goto, 第三步
} else {
    Goto, 第四步
}




;===============================子过程======================================

notemode() { ;开关note模式
    global
    SendInput n
    sleep, delayer
}


clear_selection() {   ;点击空白处消除数字选中
    global 
    MouseMove, right_x + halfsize, bottom_y
    Click
    sleep, delayer
}

Color_Click(x, y, col) { ;某点判断颜色点击
    global
    PixelGetColor, Getcolor, x, y
    If (Getcolor = col) { 
        MouseMove, x, y
        Click
;        sleep, delayer // 2
    }
}


OneY_CheckClick(y, col) { ;某y坐标判断颜色点击
    global
    For c in nine {
        Color_Click(x_of_c(c), y, col)
    }
}

OneX_CheckClick(x, col)	{ ;某x坐标判断颜色点击
    global
    For r in nine {
        Color_Click(x, y_of_r(r), col)
    }
}


x_of_c(c) { ; 根据列找x坐标
    global
    return (c - 1) * blocksize + firstblock_x
}

y_of_r(r) { ; 根据行找y坐标
    global
    return (r - 1) * blocksize + firstblock_y
}

localize_c(x) { ;定位x的列
    global
    return (x - left_x) // blocksize + 1
}

localize_r(y) { ;定位y的行
    global
    return (y - top_y) // blocksize + 1
}

relative_c(x) { ;定位x的相对列
    global
    relative_c := mod(localize_c(x), 3)
    If (relative_c = 0) { 
        relative_c := 3
    }
    return relative_c
}

relative_r(y) { ;定位y的相对行
    global
    relative_r := mod(localize_r(y), 3)
    If (relative_r = 0) { 
        relative_r := 3
    }
    return relative_r
}

delnote_related(x, y) { ;传入方块坐标，删除同行同列同九宫格的note
    global

    ;一行消除标记
    OneY_CheckClick(y, purple)

    ;一列消除标记
    OneX_CheckClick(x, purple)

    ;九宫格点击
    If (relative_c(x) = 1) { 
        x1 := 1
        x2 := 2
    }
    If (relative_c(x) = 2) {
        x1 := - 1
        x2 := 1
    }
    If (relative_c(x) = 3) {
        x1 := - 2
        x2 := - 1
    }

    If (relative_r(y) = 1) { 
        y1 := 1
        y2 := 2
    }
    If (relative_r(y) = 2) {
        y1 := - 1
        y2 := 1
    }
    If (relative_r(y) = 3) {
        y1 := - 2
        y2 := - 1
    }
    
    Color_Click(x + blocksize * x1, y + blocksize * y1, purple)
    Color_Click(x + blocksize * x2, y + blocksize * y1, purple)
    Color_Click(x + blocksize * x1, y + blocksize * y2, purple)
    Color_Click(x + blocksize * x2, y + blocksize * y2, purple)

}

delnote_number() { ;删除一页中所有冲突的标记
    global
    intY := top_y
    While (intY <= bottom_y and intY >= top_y) {
        PixelSearch, intX, intY, left_x, intY, right_x, bottom_y, blue, 0, fast
        If (intX > 0 And intY > 0) { 
            delnote_related(intX, intY + halfsize)
        }
        intY := intY + blocksize
    }
}

fill_and_delnote(x, y) { ;填充数字并删除冲突标记（填充模式进，填充模式出）
    global
    MouseMove, x, y 	;填充数字
    Click
    notemode()  
    delnote_related(x, y) 
    notemode()  ;解除note模式
}

step3_single_number() { ;第三步的每个number循环节
    global delayer, left_x, right_x, top_y, bottom_y, firstnum_x, firstnum_y, blocksize, halfsize, nine, three, purple, blue, top_y, halfsize
    开头:
    MouseMove, right_x + halfsize, bottom_y ;移开鼠标
    sleep, delayer * 2
    PixelSearch, intX, intY, firstnum_x, firstnum_y - blocksize, firstnum_x + blocksize * 8, firstnum_y, 0x7A591C, 8, fast ;95%的相似度就是13/255 ; 当该数字没有填完时进行，否则跳过
    If (intX > 0 and intY > 0) { 
        ;每行
        For r in nine {
            MouseMove, left_x - halfsize, y_of_r(r)  ;展示进度
            colornum := 0
            For c in nine {
                PixelGetColor, Getcolor, x_of_c(c), y_of_r(r)
                If (Getcolor = purple) { 
                    colornum := colornum + 1 	; 一行中的紫色方块个数计数器
                    goodcolor := c 		;一行中最后的一个紫色方块
                }
            }
        
            If (colornum = 1) {
                PixelSearch, intX, intY, left_x, y_of_r(r), right_x, y_of_r(r), blue, 0, fast
                If (intX > 0 And intY > 0) { 
                } else {
                    fill_and_delnote(x_of_c(goodcolor), y_of_r(r))
                    Goto, 开头     ;这个数字从头开始
                }
            }
        }

        ;每列
        For c in nine {
            MouseMove, x_of_c(c), top_y - halfsize  ;展示进度
            colornum := 0
            For r in nine {
                x := x_of_c(c)
                y := y_of_r(r)
                PixelGetColor, Getcolor, x, y
                If (Getcolor = purple) { 
                    colornum := colornum + 1 	; 一列中的紫色方块个数计数器
                    goodcolor := r 		;一列中最后的一个紫色方块
                }
            }
        
            If (colornum = 1) { 
                PixelSearch, intX, intY, x_of_c(c), top_y, x_of_c(c), bottom_y, blue, 0, fast
                If (intX > 0 And intY > 0) { 
                } else {
                    fill_and_delnote(x_of_c(c), y_of_r(goodcolor))
                    Goto, 开头     ;这个数字从头开始
                }
            }
        }

        ;每九宫格
        For area_r in three {
            For area_c in three {
                MouseMove, x_of_c((area_c - 1) * 3 + 2), y_of_r((area_r - 1) * 3 + 2)  ;展示进度
                colornum := 0
                For small_r in three {
                    For small_c in three {
                        c := (area_c - 1) * 3 + small_c
                        r := (area_r - 1) * 3 + small_r
                        PixelGetColor, Getcolor, x_of_c(c), y_of_r(r)
                        If (Getcolor = purple) {
                            colornum := colornum + 1
                            goodcolor_c := c
                            goodcolor_r := r
                        }
                    }
                }
                If (colornum = 1) { 
                    PixelSearch, intX, intY, x_of_c((area_c - 1) * 3 + 1), y_of_r((area_r - 1) * 3 + 1), x_of_c((area_c - 1) * 3 + 3), y_of_r((area_r - 1) * 3 + 3), blue, 0, fast
                    If (intX > 0 And intY > 0) { 
                    } else {
                        fill_and_delnote(x_of_c(goodcolor_c), y_of_r(goodcolor_r))
                        Goto, 开头     ;这个数字从头开始
                    }
                }
            }
        }
    }
    
}


;=================================END=======================================

return

F11:: pause
F12:: ExitApp 
