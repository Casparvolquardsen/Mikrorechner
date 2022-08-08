# Microrechner
Implementierung eines RISC Prozessors mit VHDL im Rahmen des Projekt-Moduls

# Befehlssatz (Instruction-Set-Architecture)

| **Mnemonic** | **31-26** | **25-22** | **21-18** | **17-14** | **13-0** | **Bedeutung** |
|--------------|-----------|-----------|-----------|-----------|----------|---------------|
| mov          | 0000 00   | xxxx      | ---       | zzzz      | ---      | Z = X         |
| addu         | 0000 01   | xxxx      | yyyy      | zzzz      | ---      | Z = X + Y     |
| addc         | 0000 10   | xxxx      | yyyy      | zzzz      | ---      | Z = X + Y + C |
| subu         | 0000 11   | xxxx      | yyyy      | zzzz      | ---      | Z = X $-$ Y   |
| and          | 0001 00   | xxxx      | yyyy      | zzzz      | ---      | Z = X AND Y   |
| or           | 0001 01   | xxxx      | yyyy      | zzzz      | ---      | Z = X OR Y    |
| xor          | 0001 10   | xxxx      | yyyy      | zzzz      | ---      | Z = X XOR Y   |
| not          | 0001 11   | xxxx      | ---       | zzzz      | ---      | Z = NOT X     |
| nand         | 0010 00   | xxxx      | yyyy      | zzzz      | ---      | Z = X NAND Y  |
| nor          | 0010 01   | xxxx      | yyyy      | zzzz      | ---      | Z = X NOR Y   |
| nxor         | 0010 10   | xxxx      | yyyy      | zzzz      | ---      | Z = X NXOR Y  |
| max          | 0010 11   | xxxx      | yyyy      | zzzz      | ---      | Z = max(X, Y) |
| min          | 0011 00   | xxxx      | yyyy      | zzzz      | ---      | Z = min(X, Y) |

Die Tabelle zeigt die Definitionen unserer ALU-Befehle. Dabei stehen die Buchstaben x, y und z für je ein Bit der Adressen der entsprechenden Register X, Y und Z. Das Symbol --- steht für die passende Anzahl an Don't Care Bits, welche keinen Einfluss auf die Ausführung des Befehls haben. Die Operation addc nimmt als dritten Input den Carry-Bit vom vorherigen Takt. Die Operationen schreiben den Überlauf in den Carry-Bit.
Die ALU-Befehle sind alle arithmetischen Befehle (mov, addu, addc, subu, max, min) und alle bitweise logischen Operationen (and, or, xor, not, nand, nor, nxor), mit je einem oder zwei Operanden X und Y. Dabei ist das Register, in welchem das Ergebnis gespeichert wird, immer ein beliebiges Register Z.

| **Mnemonic** | **31-26** | **25-22** | **21-18** | **17-14** | **13-0** | **Bedeutung**     |
|--------------|-----------|-----------|-----------|-----------|----------|-------------------|
| lsl16        | 0011 11   | xxxx      | ---       | zzzz      | ---      | Z = X \(\ll\) 16  |
| lsr16        | 0100 00   | xxxx      | ---       | zzzz      | ---      | Z = X \(\ggg\) 16 |
| asr16        | 0100 01   | xxxx      | ---       | zzzz      | ---      | Z = X \(\gg\) 16  |
| lsl4         | 0100 10   | xxxx      | ---       | zzzz      | ---      | Z = X \(\ll\) 4   |
| lsr4         | 0100 11   | xxxx      | ---       | zzzz      | ---      | Z = X \(\ggg\) 4  |
| asr4         | 0101 00   | xxxx      | ---       | zzzz      | ---      | Z = X \(\gg\) 4   |
| lsl1         | 0101 01   | xxxx      | ---       | zzzz      | ---      | Z = X \(\ll\) 1   |
| lsr1         | 0101 10   | xxxx      | ---       | zzzz      | ---      | Z = X \(\ggg\) 1  |
| asr1         | 0101 11   | xxxx      | ---       | zzzz      | ---      | Z = X \(\gg\) 1   |

Die Tabelle zeigt die Definitionen unserer Shift-Befehle. Dabei stehen die Buchstaben x und z für je ein Bit der Adressen der entsprechenden Register X und Z. Das Symbol --- steht für die passende Anzahl an Don't Care Bits, welche keinen Einfluss auf die Ausführung des Befehls haben.
Die Shift-Befehle fassen die Befehle lsl16, lsr16, asr16, lsl4, lsr4, asr4, lsl1, lsr1 und asr1 zusammen. Jeweils wird ein Register X als Operand angegeben, auf welchen die Shift-Operation angewandt werden soll. lsl16, lsr16 und asr16 shiften den Operanden um jeweils 16 Bit; lsl4, lsr4 und asr4 jeweils um 4 Bit; und lsl1, lsr1 und asr1 jeweils um 1 Bit. Dabei ist das Register, in welchem das Ergebnis gespeichert wird, immer ein beliebiges Register Z.

| **Mnemonic** | **31-26** | **25-22** | **21-18** | **17-0** | **Bedeutung**    |
|--------------|-----------|-----------|-----------|----------|------------------|
| cmpe         | 0110 00   | xxxx      | yyyy      | ---      | C = (X == Y)     |
| cmpne        | 0110 01   | xxxx      | yyyy      | ---      | C = (X $\neq$ Y) |
| cmpgt        | 0110 10   | xxxx      | yyyy      | ---      | C = (X $>$ Y)    |
| cmplt        | 0110 11   | xxxx      | yyyy      | ---      | C = (X $<$ Y)    |
| cmpgte       | 0111 00   | xxxx      | yyyy      | ---      | C = (X $\geq$ Y) |
| cmplte       | 0111 01   | xxxx      | yyyy      | ---      | C = (X $\leq$ Y) |

Die Tabelle zeigt die Definitionen unserer Vergleichs-Befehle. Dabei stehen die Buchstaben x und y für je ein Bit der Adressen der entsprechenden Register X und Y. Das Symbol --- steht für die passende Anzahl an Don't Care Bits, welche keinen Einfluss auf die Ausführung des Befehls haben. Das Ergebnis der Operationen wird in das Carry-Bit C geschrieben.
Die Vergleichs-Befehle (cmpe, cmpne, cmpgt, cmplt, cmpgte, cmplte) führen eine Verglichsoperation mit zwei Operanden Register X und Register Y aus. Das Ergebnis der Operation wird nicht in einem Register gespeichert, sondern in dem Carry-Bit.

| **Mnemonic** | **31-26** | **25-22** | **21-0** | **Bedeutung**        |
|--------------|-----------|-----------|----------|----------------------|
| movi         | 1000 00   | zzzz      | 22-Bit I | Z = I                |
| addi         | 1000 01   | zzzz      | 22-Bit I | Z = Z + I            |
| subi         | 1000 10   | zzzz      | 22-Bit I | Z = Z $-$ I          |
| andi         | 1000 11   | zzzz      | 22-Bit I | Z = Z AND I          |
| lsli         | 1001 00   | zzzz      | 22-Bit I | Z = Z $\ll$ I        |
| lsri         | 1001 01   | zzzz      | 22-Bit I | Z = Z $\ggg$ I       |
| bseti        | 1001 10   | zzzz      | 22-Bit I | Z = Z | (1 $\ll$ I)  |
| bclri        | 1001 11   | zzzz      | 22-Bit I | Z = Z & !(1 $\ll$ I) |

Die Tabelle zeigt die Definitionen unserer Immediate-Befehle. Dabei stehen die Buchstaben z für je ein Bit der Adressen des entsprechenden Registers X. Zusätzlich zum Befehl und dem Register Z werden die übrigen 22-Bit des Befehls zur Definition eines Immediate Wertes I verwendet, welcher Teil der Operationen ist.
Die Immediate-Befehle haben neben der Register-Adresse einen Operanden direkt in den Befehl codiert, mit den 22-Bit, welche nach der 6-Bit Befehls-Codierung und der 4-Bit Register-Adresse übrig bleiben. Das Ergebnis der Immediate-Operationen wird immer in dem angegebenen Register Z gespeichert, dessen Inhalt auch Operand der Befehle sein kann.

| **Mnemonic** | **31-26** | **25-22** | **21-18** | **17-0** | **Bedeutung** |
|--------------|-----------|-----------|-----------|----------|---------------|
| ldw          | 1100 00   | xxxx      | zzzz      | ---      | Z = MEM(X)    |
| stw          | 1100 01   | xxxx      | yyyy      | ---      | MEM(X) = Y    |

Die Tabelle zeigt die Definitionen unserer Speicher-Befehle. Dabei stehen die Buchstaben x, y und z für je ein Bit der Adressen der entsprechenden Register X, Y und Z. MEM(X) steht für den 32-Bit Wert, der im Speicher an der Adresse X steht.
Die beiden Speicher-Befehle dienen zum Laden von Werten aus dem Speicher in die Register und zum Speichern von Werten aus den Registern in den Speicher. \textbf{ldw X Z} lädt den Wert von der Speicher-Adresse, die in Register X steht in das Register Z. \textbf{stw X Y} lädt den Wert von Register Y in den Speicher an die Adresse, die in Register X steht.

| **Mnemonic** | **31-26** | **25-22**                     | **21-0**                        | **Bedeutung**                   |
|--------------|-----------|-------------------------------|---------------------------------|---------------------------------|
| br           | 1110 00   | 26-Bit I                      |                                 | PC = PC+1+I                     |
| jsr          | 1110 01   | 26-Bit I                      |                                 | R[15] = PC + 1; PC = PC+1+I     |
| bt           | 1110 10   | 26-Bit I                      |                                 | (C=1) ? PC = PC+1+I : PC = PC+1 |
| bf           | 1110 11   | 26-Bit I                      |                                 | (C=0) ? PC = PC+1+I : PC = PC+1 |
| jmp          | 1111 00   | xxxx                          | ---                             | PC = X                          |
| halt         | 1111 10   | ---                           | ---                             | halt                            |
| nop          | 1111 11   | ---                           | ---                             | No operation                    |

Die Tabelle zeigt die Definitionen unserer Kontrollfluss-Befehle. Dabei stehen die Buchstaben x für je ein Bit der Adressen des entsprechenden Registers X. Bei einigen Operationen werden die übrigen 26-Bit des Befehls zur Definition eines Immediate Wertes I verwendet, welcher Teil der Operationen ist. PC steht f\"ur den Programm-Counter. R[15] steht für das 16. Register, in welchem der Programm-Counter bei der Operation Jump-to-Subroutine (jsr) gespeichert wird. C steht für das Carry-Bit des vorherigen Taktes
Die Kontrollfluss-Befehle dienen zur Steuerung der zeitlichen Abfolge der Befehlsausführung. Dies passiert durch den Programm-Counter (PC), welcher angibt, welche Befehle aus dem Speicher geladen werden, um ausgeführt zu werden. Durch die Kontrollfluss-Befehle kann der PC so verändert werden, dass Verzweigungen und Schleifen implementiert werden können. Der Befehl \textbf{halt} stoppt die weitere Ausführung von Befehlen.

# Assembler 

Für die effizientere Programmierung unseres Mikrocomputers haben wir einen Assembler in Python implementiert, welcher unsere Assemblersprache in den Maschinencode umwandelt, welchen wir auf das FPGA-Board laden können, um ihn auszuführen. Unsere Assemblersprache besteht im Allgemeinen aus den Mnemonics unserer Befehle, welche in Tabelle \ref{tab:ALU} bis \ref{tab:Kontroll} zu finden sind. Jeder Befehl benötigt eine Zeile und die Parameter des Befehls werden mit einem Leerzeichen getrennt und als Dezimalzahl angegeben. Die Syntax für die Assemblerbefehle ist im Allgemeinen:

Opcode X Y Z I

Wobei der Opcode der entsprechende Mnemomic aus der Tabelle \ref{tab:ALU} bis \ref{tab:Kontroll} ist und X, Y und Z die ensprechenden Register von 0 bis 15 sind. Bei dem Parameter I handelt es sich um den Immediate-Wert, welcher je nach Befehl nur einer 22 oder 26-Bit Zahl entsprechen darf. Benötigt der Befehl nicht alle drei Register, oder keinen Immediate-Wert, wird diese Angabe einfach weggelassen.

Beispiele:
addu 0 1 2  Addiere Register 0 und Register 1 und schreibe das Ergebnis in Register 2.
movi 0 42   Überschreibe Register 0 mit dem Wert 42.
cmpe 0 1    Überprüfe, ob Register 0 und Register 1 den gleichen Wert gepeichert haben; Schreibe das Ergebnis ins Carry-Bit. 
bt 1        Wenn das Carry-Bit gleich 1 ist, dann erhöhe den Program-Counter um 2, sonst nur um 1. 


# Architektur

![Architektur-Übersicht](/imgs/Architektur.jpg)

Im folgenden sind die sechs Schritte unserer Pipeline-Ausführung im Detail beschrieben.

Prefetch: Aktuellen Programm-Zähler (PC) laden (Entweder PC um eins erhöhen, PC aus Immediate-Wert laden, oder PC aus Register-X laden). Neue Befehlsadresse (PC) liegt am Speicher an.

Fetch:    Befehl aus dem Speicher ins Befehls-Register laden.

Decode:   Registeradressen X und Y liegen an der Registerbank an. Registeradresse Z liegt beim Z-Register1 an. Wirte-Enable-Z liegt beim Wirte-Enable-Z-Register1 an. Opcode lieght am Opcode-Register1 an. Immediate liegt am Immediate-Register an.

Execute:  Die Register X und Y werden aus der Registerbank geladen. Die Operanden X, Y, der Immediate-Wert, der Opcode und der Carry-Bit der vorherigen Operation liegen bei der Arithmetisch-Logischen-Einheit (ALU) an und die Operation wird ausgeführt. Das Ergebnis und das neue Carry-Bit werden in einem Register zwischengespeichert. Außerdem liegen der Carry-Bit der vorherigen Operation, das Register X, der Opcode und der Immediate-Wert an dem Programm-Zähler an.
    Gleichzeitig liegen die Werte X und Y an dem Speicher an und write-enable (wren) wird anhand des Opcodes bestimmt.
    Registeradresse Z liegt beim Z-Register2 an. Wirte-Enable-Z liegt beim Wirte-Enable-Z-Register2 an. Opcode lieght am Opcode-Register2 an.

Write-Back: Der aus dem Speicher geladene Wert, PC-Save, und das Ergebnis der ALU liegen am Multiplexer an und je nach Opcode wird einer der drei Werte ausgewählt, um in der Registerbank an der Adresse Z gespeichert zu werden. Der im Multiplexer ausgewählte Wert wird in das Register Z geladen, wenn Write-Enable-Z den Wert 1 hat.

![Architektur-Übersicht](/imgs/Architektur-Pipeline-Farben.jpg)

Hier ist die Architektur unseres Mikrorechners zu sehen, wie auch in der ersten Abbildung. Hier sind nun aber alle Signal-Leitungen, welche zu einem Bestimmen Pipeline-Schritt gehören in je einer anderen Farbe dargestellt, um einen leichteren Überblick zu ermöglichen. Die Farb-Zugehörigkeiten sind: Prefetch=Orange, Fetch=Grün, Decode=Gelb, Execute=Rot, Write-Back=Blau.