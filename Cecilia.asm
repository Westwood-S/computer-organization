               .data
buffer:        .space  1024
Success:       .asciiz " Success! Location: "
Fail:          .asciiz " Fail!\n"
endline:       .ascii "\n"               
                      
               .text
main:          la $a0,buffer  # $a0�滺������ַ
               li $a1,512     # $a1�����Զ�ȡ���ַ���
               li $v0,8       # �����ַ���
               syscall

Loop:          li $v0,12      # ��ȡ�ַ�
               syscall
               move $t3,$v0   # ��һ��ϵͳ���� ��������ַ�����$t3

               li $v0,4         # ����ַ���
               la $a0,endline   # ����һ��
               syscall
               move $v0,$t3     # ������ַ����$v0

               beq $v0,'?',End     # �ַ�Ϊ ����������
               la $t0,buffer          # $t0���뻺�����׵�ַ
               li $t1,1            # $t1֮����������ҵ����ַ���λ��

Find:          lb $t2,($t0)     # ���ַ����׵�ַ��ʼ�Ƚ� ��������ַ���β0 ��������ʧ��
               beq $t2,0,NotFound    # ����0 �ַ������� δ�ҵ�
               beq $t2,$v0 Found  # �ҵ�
               add $t1,$t1,1       # ����Ѱ�� λ�ü�1
               add $t0,$t0,1       # �ַ���λ������1
               b Find
               
Found:         li $v0,4           # ����ַ���
               la $a0,Success     # $a0�������ַ������׵�ַ Success
               syscall
               li $v0,1           # �������
               move $a0,$t1       # $a0��Ŵ�������ַ����е�λ��
               syscall
               li $v0,4      
               la $a0,endline
               syscall
               b Loop

NotFound:      li $v0,4       # ʧ����
               la $a0,Fail
               syscall
               b Loop

End:           li $v0,10      # exit
               syscall
               