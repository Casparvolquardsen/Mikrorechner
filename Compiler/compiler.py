import argparse

def get_binary(n, bit_length, line_number):
    n = int(n)
    if n >= (2 ** bit_length):
        raise ValueError(f"To big register index in line {line_number + 1}.")
    elif n < 0:
        raise ValueError(f"To small register index in line {line_number + 1}")

    return format(n, "b").zfill(bit_length)

def append_command(path, word_number, binary_command, num_noops):
    f = open(path, "a")
    f.write(f"{word_number} : {binary_command};\n")
    word_number += 1

    for i in range(num_noops):
        f.write(f"{word_number} : 111111{'0' * 26};\n") # write noops
        word_number += 1

    f.close()
    return word_number

def trim_comments(line):
    command = line.split('#')[0]

    return command

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Python script to compile commands to 32bit binary code.")
    parser.add_argument("-p", "--path", required=True, help="Specify path to source code.")
    parser.add_argument("-sp", "--saving_path", required=True, help="Specify path to save compiled code.")
    args = parser.parse_args()

    path = args.path
    saving_path = args.saving_path

    opcodes = {
        "mov":      "000000",
        "addu": 	"000001",
        "addc": 	"000010",
        "subu": 	"000011",
        "and":  	"000100",
        "or":       "000101",
        "xor":	    "000110",
        "not":	    "000111",
        "nand":	    "001000",
        "nor":	    "001001",
        "nxor":	    "001010",
        "max":	    "001011",
        "min":	    "001100",
        "lsl16":	"001111",
        "lsr16":	"010000",
        "asr16":	"010001",
        "lsl4":	    "010010",
        "lsr4":	    "010011",
        "asr4":	    "010100",
        "lsl1":	    "010101",
        "lsr1":	    "010110",
        "asr1":	    "010111",
        "cmpe":	    "011000",
        "cmpne":	"011001",
        "cmpgt":	"011010",
        "cmplt":	"011011",
        "cmpgte":	"011100",
        "cmplte":	"011101",
        "movi":	    "100000",
        "addi":	    "100001",
        "subi":	    "100010",
        "andi":	    "100011",
        "lsli":	    "100100",
        "lsri":	    "100101",
        "bseti":	"100111",
        "bclri":	"101000",
        "ldw":	    "110000",
        "stw":	    "110001",
        "br":       "111000",
        "jsr":	    "111001",
        "bt":       "111010",
        "bf":       "111011",
        "jmp":      "111100",	
        "halt":	    "111110",
        "nop":	    "111111"
        }
        
    xyz_registers = [
        "addu", 
        "addc",
        "subu",
        "and",
        "or",
        "xor",
        "nand",
        "nor",
        "nxor",
        "max",
        "min" 
    ]

    xz_registers = [
        "mov", 
        "not",
        "lsl16",
        "lsr16",
        "asr16",
        "lsl4",
        "lsr4",
        "asr4",
        "lsl1",
        "lsr1",
        "asr1"      
    ]

    xy_registers = [
        "cmpe",
        "cmpne",
        "cmpgt",
        "cmplt",
        "cmpgte",
        "cmplte"
    ]
    
    zc_registers = [
        "movi",
        "addi",
        "subi",
        "andi",
        "lsli",
        "lsri",
        "bseti",
        "bclri"
    ]

    x_c_registers = [
        "ldw",
        "stw"
    ]

    x_registers = [
        "jmp"
    ]     
    
    i_registers = [
        "br",
        "jsr",
        "bt",
        "bf"
    ]    
    
    no_registers = [
        "halt",
        "nop"
    ]
        
    f = open(saving_path, "w")
    f.write("DEPTH = 65536;				-- # words\nWIDTH = 32;				    -- # bits/word\nADDRESS_RADIX = DEC;		-- address format\nDATA_RADIX = BIN;			-- data format\nCONTENT\nBEGIN\n0 : 11111100000000000000000000000000;\n")
    f.close()
    
    file = open(path, "r")
    command_number = 1
    for line_number, line in enumerate(file):
        without_comments = trim_comments(line)

        command_list = without_comments.strip().split()
        if len(command_list) == 0:
            continue
        
        opcode = command_list[0]
    
        if opcode in xyz_registers:
            if len(command_list) > 4:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            register_x = get_binary(command_list[1], 4, line_number)
            register_y = get_binary(command_list[2], 4, line_number)
            register_z = get_binary(command_list[3], 4, line_number)

            command_string = f"{opcodes[opcode]}{register_x}{register_y}{register_z}{'0' * 14}"

        elif opcode in xz_registers: 
            if len(command_list) > 3:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            register_x = get_binary(command_list[1], 4, line_number)
            register_z = get_binary(command_list[2], 4, line_number)

            command_string = f"{opcodes[opcode]}{register_x}0000{register_z}{'0' * 14}"
        
        elif opcode in xy_registers: 
            if len(command_list) > 3:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            register_x = get_binary(command_list[1], 4, line_number)
            register_y = get_binary(command_list[2], 4, line_number)

            command_string = f"{opcodes[opcode]}{register_x}{register_y}{'0' * 18}"
                    
        elif opcode in zc_registers: 
            if len(command_list) > 3:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            register_z = get_binary(command_list[1], 4, line_number)
            immediate = get_binary(command_list[2], 22, line_number)

            command_string = f"{opcodes[opcode]}{register_z}{immediate}"
        
        elif opcode in x_c_registers: 
            if len(command_list) > 3:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            register_x = get_binary(command_list[1], 4, line_number)
            register__ = get_binary(command_list[2], 4, line_number)
            

            command_string = f"{opcodes[opcode]}{register_x}{register__}{'0'*18}"
            
        elif opcode in x_registers: 
            if len(command_list) > 2:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            register_x = get_binary(command_list[1], 4, line_number)

            command_string = f"{opcodes[opcode]}{register_x}{'0' * 22}"

        elif opcode in i_registers: 
            if len(command_list) > 2:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            immediate = get_binary(command_list[1], 26, line_number)
            command_string = f"{opcodes[opcode]}{immediate}"
        elif opcode in no_registers:
            if len(command_list) > 1:
                raise ValueError(f"Wrong amount of operands in line number {line_number + 1}")

            command_string = f"{opcodes[opcode]}{'0' * 26}"
        
        else:
            raise ValueError(f"Wrong command in line {line_number + 1}")
            
        if opcode == "halt":
            num_noops = 3
        else:
            num_noops = 0

        command_number = append_command(saving_path, command_number, command_string, num_noops)

    f = open(saving_path, "a")
    f.write("END;\n")
    f.close()

    file.close()