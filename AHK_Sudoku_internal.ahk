F10::

;===============================常量========================================

;系统延时
delayer := 50

;鼠标速度
SetDefaultMouseSpeed, 0

PixelSearch, left_x, top_y, 0, 0, 1920, 1080, 0xF3C87A, 0, fast ;整张数独的左上角
If (left_x > 0 And top_y > 0) {
} else {
    MsgBox, Make sure a new game was started!
    Reload
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

blocktable := {}
for row in nine {
    for column in nine {    
    blocktable[row, column] := new Block(row, column)
    }
}

fillednum := [0,0,0,0,0,0,0,0,0]


第一步:
notemode() ;进入note模式

for r in nine {
    for c in nine {  
        PixelGetColor, Getcolor, blocktable[r, c].x, blocktable[r, c].y
        If (Getcolor = white or Getcolor = yellow) { 
;            MouseMove, blocktable[r, c].x, blocktable[r, c].y, 0 
;            Click
;            SendInput 123456789
        } else {
            blocktable[r, c].notes := [0,0,0,0,0,0,0,0,0]
        }
    }
}

clear_selection()


第二步:
For number in nine {
    MouseMove, (number - 1) * blocksize + firstnum_x, firstnum_y
    Click
    sleep, delayer
    delnote_number(number)
}

notemode() ;解除note模式


第三步:
filled := 0 ;已放数字个数计数器

For r in nine { ;全行判断
    For c in nine { ;一行判断
        If (blocktable[r, c].num = 0) { 
;            MouseMove, x_of_c(c), y_of_r(r)
            colornum := 0
            for i, note in blocktable[r, c].notes {
                if (note != 0) {
                    colornum := colornum + 1
                    goodcolor := i 
                }
            }

            If (colornum = 1) { 
                clear_selection()
                MouseMove, (goodcolor - 1) * blocksize + firstnum_x, firstnum_y
                Click
                fill_and_delnote(r, c, goodcolor)
                filled := filled + 1
                step4_single_number(goodcolor)
            }
            
        }
       
    }

}

If (filled != 0) {
    Goto, 第四步
}


第四步:
For number in nine {
    MouseMove, (number - 1) * blocksize + firstnum_x, firstnum_y
    Click
    sleep, delayer
    step4_single_number(number)
}

Goto, 第三步



;===============================子过程======================================

class Block {
    __New(r, c) {
        this.x := x_of_c(c)
        this.y := y_of_r(r)
        this.num := 0
        this.notes := [1,2,3,4,5,6,7,8,9]
    }
}

notemode() { ;开关note模式
    global
    SendInput n
    sleep, delayer * 2
}


clear_selection() {   ;点击空白处消除数字选中
    global 
    MouseMove, right_x + halfsize, bottom_y
    Click
    sleep, delayer
}

delnote(r, c, number) { ;某点判断颜色消除note
    global
    If (blocktable[r, c].notes[number] != 0) { 
;        MouseMove, x_of_c(c), y_of_r(r)
        blocktable[r, c].notes[number] := 0
;        Click
;        sleep, delayer // 5
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

relative(n) { ;定位行或列n的相对行或列
    global
    relative := mod(n, 3)
    If (relative = 0) { 
        relative := 3
    }
    return relative
}

delnote_related(r, c, number) { ;传入方块，删除同行同列同九宫格的note
    local x1, x2, y1, y2, row, column

    ;一行消除标记
    For column in nine {
        delnote(r, column, number)
    }

    ;一列消除标记
    For row in nine {
        delnote(row, c, number)
    }

    ;九宫格点击
    If (relative(c) = 1) { 
        x1 := 1
        x2 := 2
    }
    If (relative(c) = 2) {
        x1 := - 1
        x2 := 1
    }
    If (relative(c) = 3) {
        x1 := - 2
        x2 := - 1
    }

    If (relative(r) = 1) { 
        y1 := 1
        y2 := 2
    }
    If (relative(r) = 2) {
        y1 := - 1
        y2 := 1
    }
    If (relative(r) = 3) {
        y1 := - 2
        y2 := - 1
    }
    
    delnote(r + y1, c + x1, number)
    delnote(r + y1, c + x2, number)
    delnote(r + y2, c + x1, number)
    delnote(r + y2, c + x2, number)

}

delnote_number(number) { ;删除一页中所有冲突的标记
    local intX, intY, r, c
    intY := top_y
    While (intY <= bottom_y and intY >= top_y) {
        PixelSearch, intX, intY, left_x, intY, right_x, bottom_y, blue, 0, fast
        If (intX > 0 And intY > 0) { 
            r := localize_r(intY + halfsize)
            c := localize_c(intX)
            If (blocktable[r, c].num != number) {
                blocktable[r, c].num := number
                fillednum[number] := fillednum[number] + 1
            }
            blocktable[r, c].notes := [0,0,0,0,0,0,0,0,0]
            delnote_related(r, c, number)
        }
        intY := intY + blocksize
    }
}

fill_and_delnote(r, c, number) { ;填充数字并删除冲突标记（填充模式进，填充模式出）
    global
    MouseMove, x_of_c(c), y_of_r(r) 	;填充数字
    blocktable[r, c].num := number
    fillednum[number] := fillednum[number] + 1
    blocktable[r, c].notes := [0,0,0,0,0,0,0,0,0]
    Click
    notemode()  
    delnote_related(r, c, number)
    notemode()  ;解除note模式
}

step4_single_number(number) { ;第三步的每个number循环节
    local c, r, x, y, already, area_c, area_r, small_c, small_r, colornum, goodcolor, goodcolor_c, goodcolor_c
    开头:
    If (fillednum[number] < 9) { 
        ;每行
        For r in nine {
;            MouseMove, left_x - halfsize, y_of_r(r)  ;展示进度
            colornum := 0
            already := 0
            For c in nine {
                If (blocktable[r, c].notes[number] != 0) { 
                    colornum := colornum + 1 	; 一行中的紫色方块个数计数器
                    goodcolor := c 		;一行中最后的一个紫色方块
                }
                If (blocktable[r, c].num = number) {
                    already := 1
                }
            }
            If (colornum = 1 and already = 0) {
                fill_and_delnote(r, goodcolor, number)
                Goto, 开头     ;这个数字从头开始
            }
        }

        ;每列
        For c in nine {
;            MouseMove, x_of_c(c), top_y - halfsize  ;展示进度
            colornum := 0
            already := 0
            For r in nine {
                If (blocktable[r, c].notes[number] != 0) { 
                    colornum := colornum + 1 	; 一列中的紫色方块个数计数器
                    goodcolor := r 		;一列中最后的一个紫色方块
                }
                If (blocktable[r, c].num = number) {
                    already := 1
                }

            }
            If (colornum = 1 and already = 0) { 
                fill_and_delnote(goodcolor, c, number)
                Goto, 开头     ;这个数字从头开始
            }
        }

        ;每九宫格
        For area_r in three {
            For area_c in three {
;                MouseMove, x_of_c((area_c - 1) * 3 + 2), y_of_r((area_r - 1) * 3 + 2)  ;展示进度
                colornum := 0
                already := 0
                For small_r in three {
                    For small_c in three {
                        c := (area_c - 1) * 3 + small_c
                        r := (area_r - 1) * 3 + small_r
                        If (blocktable[r, c].notes[number] != 0) {
                            colornum := colornum + 1
                            goodcolor_c := c
                            goodcolor_r := r
                        }
                        If (blocktable[r, c].num = number) {
                            already := 1
                        }
                    }
                }
                If (colornum = 1 and already = 0) { 
                    fill_and_delnote(goodcolor_r, goodcolor_c, number)
                    Goto, 开头     ;这个数字从头开始
                }
            }
        }
    }
}


;=================================END=======================================

return

F11:: pause
F12:: Reload 
