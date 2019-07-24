               .data
buffer:        .space  1024
Success:       .asciiz " Success! Location: "
Fail:          .asciiz " Fail!\n"
endline:       .ascii "\n"               
                      
               .text
main:          la $a0,buffer  # $a0存缓冲区地址
               li $a1,512     # $a1最大可以读取的字符数
               li $v0,8       # 读入字符串
               syscall

Loop:          li $v0,12      # 读取字符
               syscall
               move $t3,$v0   # 又一次系统调用 将读入的字符存入$t3

               li $v0,4         # 输出字符串
               la $a0,endline   # 另起一行
               syscall
               move $v0,$t3     # 读入的字符存回$v0

               beq $v0,'?',End     # 字符为 ？结束程序
               la $t0,buffer          # $t0存入缓冲区首地址
               li $t1,1            # $t1之后用来存放找到的字符的位置

Find:          lb $t2,($t0)     # 从字符串首地址开始比较 如果到达字符串尾0 表明查找失败
               beq $t2,0,NotFound    # 读到0 字符串结束 未找到
               beq $t2,$v0 Found  # 找到
               add $t1,$t1,1       # 继续寻找 位置加1
               add $t0,$t0,1       # 字符串位置向后加1
               b Find
               
Found:         li $v0,4           # 输出字符串
               la $a0,Success     # $a0存放输出字符串的首地址 Success
               syscall
               li $v0,1           # 输出整数
               move $a0,$t1       # $a0存放待输出的字符串中的位置
               syscall
               li $v0,4      
               la $a0,endline
               syscall
               b Loop

NotFound:      li $v0,4       # 失败咧
               la $a0,Fail
               syscall
               b Loop

End:           li $v0,10      # exit
               syscall
               