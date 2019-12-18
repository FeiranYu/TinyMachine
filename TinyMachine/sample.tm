*TINY Compilation to TM Code
*File: test.tm
*Standard prelude:
  0:     LD  5,0(0) 	load gp with maxaddress
  1:    LDA  6,0(5) 	copy gp to mp
  2:     ST  0,0(0) 	clear location 0
*End of standard prelude.
*-> Function (main)
  4:     ST  1,-2(5) 	func: store the location of func. entry
*func: unconditional jump to next declaration belongs here
*func: function body starts here
  3:    LDC  1,6(0) 	func: load function location
  6:     ST  0,-1(6) 	func: store return address
*->compound
*-> assign
*-> Id (i)
  7:    LDC  0,-2(0) 	id: load varOffset
  8:     ADD   0,6,0	id: calculate the address
  9:    LDA  0,0(0) 	load id address
*<- Id
 10:     ST  0,-3(6) 	assign: push left (address)
*-> Const
 11:    LDC  0,0(0) 	load const
*<- Const
 12:     LD  1,-3(6) 	assign: load left (address)
 13:     ST  0,0(1) 	assign: store value
*<- assign
*-> iter.
*while: jump after body comes back here
*-> Op
*-> Id (i)
 14:    LDC  0,-2(0) 	id: load varOffset
 15:     ADD   0,6,0	id: calculate the address
 16:     LD  0,0(0) 	load id value
*<- Id
 17:     ST  0,-3(6) 	op: push left
*-> Const
 18:    LDC  0,1(0) 	load const
*<- Const
 19:     LD  1,-3(6) 	op: load left
 20:     SUB   0,1,0	op <
 21:    JLT  0,2(7) 	br if true
 22:    LDC  0,0(0) 	false case
 23:    LDA  7,1(7) 	unconditional jmp
 24:    LDC  0,1(0) 	true case
*<- Op
*while: jump to end belongs here
*->compound
*-> assign
*-> Id (i)
 26:    LDC  0,0(0) 	id: load varOffset
 27:     ADD   0,5,0	id: calculate the address
 28:    LDA  0,0(0) 	load id address
*<- Id
 29:     ST  0,-3(6) 	assign: push left (address)
*-> Const
 30:    LDC  0,1(0) 	load const
*<- Const
 31:     LD  1,-3(6) 	assign: load left (address)
 32:     ST  0,0(1) 	assign: store value
*<- assign
*<-compound
 33:     LDA 7,-20(7)	while: jmp back to test
 25:     JEQ 0,8(7)	while: jmp to end
*<- iter.
*<-compound
 34:     LD  7,-1(6) 	func: load pc with return address
  5:     LDA 7,29(7)	func: unconditional jump to next declaration
*-> Function (main)
 35:    LDC  0,-1(0) 	init: load globalOffset
 36:     ADD   6,6,0	init: initialize mp with globalOffset
*-> Call
 37:     ST  6,0(6) 	call: store current mp
 38:    LDA  6,0(6) 	call: push new frame
 39:    LDA  0,1(7) 	call: save return in ac
 40:    LDC  7,6(0) 	call: unconditional jump to main() entry
 41:     LD  6,0(6) 	call: pop current frame
*<- Call
*End of execution.
 42:    HALT   0,0,0	
