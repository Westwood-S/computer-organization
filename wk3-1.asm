               .data
Capital:       .asciiz 
               " Alpha\n"," Bravo\n"," China\n"," Delta\n"," Echo\n"," Foxtrot\n"," Golf\n"," Hotel\n"," India\n"," Juliet\n"," Kilo\n",
               " Lima\n"," Mary\n"," November\n"," Oscar\n"," Paper\n"," Quebec\n"," Reserach\n"," Sierra\n"," Tango\n", " Uniform\n",
               " Victor\n"," Whisky\n"," X-ray\n"," Yankee\n"," Zulu\n"
Lower:         .asciiz 
               " alpha\n"," bravo\n"," china\n"," delta\n"," echo\n"," foxtrot\n"," golf\n"," hotel\n"," india\n"," juliet\n"," kilo\n",
               " lima\n"," mary\n"," november\n"," oscar\n"," paper\n"," quebec\n"," research\n"," sierra\n"," tango\n"," uniform\n",
               " victor\n"," whisky\n"," x-ray\n"," yankee\n"," zulu\n"
Number:        .asciiz 
               " zero\n", " First\n", " Second\n", " Third\n", " Fourth\n"," Fifth\n", " Sixth\n", " Seventh\n"," Eighth\n"," Ninth\n"
Word_offset:   .word
               0,8,16,24,32,39,49,56,64,72,81,88,95,102,113,121,129,138,149,158,166,176,185,194,202,211   
Number_offset: .word
               0,7,15,24,32,41,49,57,67,76  
endline:       .ascii "\n"               
                      
               .text
main:     
Loop:          li $v0,12      # 读入一个字符
               syscall        
               move $t0,$v0   # 下面又要system call 先把读入的字符存起来

               la $a0,endline     # 另起一行
               li $v0,4           # 输出字符串
               syscall         
               move $v0,$t0       # 读入字符存回$v0备用

               sub $t0,$v0,'?'
               beqz $t0,End        # 若为 ？ 结束程序
               blt $v0,'0',Others  # < 0
               ble $v0,'9',Num     # 0 - 9
               blt $v0,'A',Others  # 9 - A 之间 开区间
               ble $v0,'Z',Cap     # A - Z
               blt $v0,'a',Others  # Z - a 之间 开区间
               ble $v0,'z',Low     # a - z
               b Others
               
Num:           sub $t0,$v0,'0      
               sll $t0,$t0,2         # 一个字占4个字节 左移2位
               la $t1,Number_offset  # $t1存 Number_offset 的地址
               add $t0,$t0,$t1       # $t0定位到哪一位偏移量
               lw $t0,($t0)          # $t0存对应字符串的偏移量
               la $t1,Number         # $t1存Number的地址
               add $a0,$t0,$t1       # $a0存待输出字符串的地址
               li $v0,4              # 输出字符串
               syscall
               b Loop
               
Cap:           sub $t0,$v0,'A'
               sll $t0,$t0,2          
               la $t1,Word_offset  
               add $t0,$t0,$t1        
               lw $t0,($t0)    
               la $t1,Capital  
               add $a0,$t0,$t1       
               li $v0,4    
               syscall
               b Loop
               
Low:           sub $t0,$v0,'a'
               sll $t0,$t0,2          
               la $t1,Word_offset  
               add $t0,$t0,$t1        
               lw $t0,($t0)    
               la $t1,Lower 
               add $a0,$t0,$t1       
               li $v0,4    
               syscall
               b Loop        
               
Others:        li $a0,'*'     # 其他字符输出 *
               li $v0,11      # 输出字符
               syscall

               la $a0,endline     
               li $v0,4       # print \n
               syscall

               b Loop

End:           li $v0,10      # 退出程序
               syscall                              
               
                 
                     
               
               
               
               
               
               
