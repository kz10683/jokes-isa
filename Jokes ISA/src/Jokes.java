import java.io.IOException;
import java.util.HashMap;

public class Jokes extends Assembler
{
	HashMap<String, Integer> map;
	HashMap<String, Integer> data_map;
	
	public Jokes(String[] args) throws IOException
	{
		super(args);
	}
		
	@Override
	void processLabel(String sourceCode)
	{
		if (currentCodeSection == 0)
		{
			map.put(sourceCode, programCounter);
			System.out.println("PC: " + sourceCode + " " + programCounter);
		}
		else
		{
			data_map.put(sourceCode, dataMemoryAddress);
			System.out.println("Data: " + sourceCode + " " + dataMemoryAddress);
		}
	}

	@Override
	String generateCode(Instruction instruction) 
    {
		String opcode = "";
        String func_code = "";
        String op1 = instruction.operands[0].name;
        String op2 = "";
        String reset = "0";        
        String operator = instruction.operator;     
        String str = "";

        if (operator.equals("la"))
        {
            String name = instruction.operands[1].name;
            if (map.get(name) == null && data_map.get(name) == null) 
            {
                System.out.println("Label " + name + " does not exist!");
                return "";
            }
            
            op2 = (map.get(name) != null) ? Integer.toBinaryString(map.get(name)) : Integer.toBinaryString(data_map.get(name));
            
            while (op2.length() < 34)
            {
                op2 = "0" + op2;
            }
            
            String first = op2.substring(0, 9);
            String second = op2.substring(9, 18);
            String third = op2.substring(18, 27);
            String fourth = op2.substring(27, 34);
            
            first = Integer.toString(Integer.parseInt(first, 2));
            second = Integer.toString(Integer.parseInt(second, 2));
            third = Integer.toString(Integer.parseInt(third, 2));
            fourth = Integer.toString(Integer.parseInt(fourth, 2));
            
            Operand lr_1 = new Operand(first, 0);
            Operand[] op_lr1 = {lr_1};          
            Instruction ins_lr_1 = new Instruction("lr", op_lr1);
            
            Operand sloi_0 = new Operand(op1, 0);
            Operand sloi_1 = new Operand("0", 0);
            Operand[] op_sloi = {sloi_0, sloi_1}; 
            Instruction ins_sloi_1 = new Instruction("sloi", op_sloi);
            
            Operand lr_2 = new Operand(second, 0);
            Operand[] op_lr2 = {lr_2};          
            Instruction ins_lr_2 = new Instruction("lr", op_lr2);
            
            sloi_0 = new Operand(op1, 0);
            sloi_1 = new Operand("9", 0);
            Operand[] op_sloi2 = {sloi_0, sloi_1}; 
            Instruction ins_sloi_2 = new Instruction("sloi", op_sloi2);
            
            Operand lr_3 = new Operand(third, 0);
            Operand[] op_lr3 = {lr_3};          
            Instruction ins_lr_3 = new Instruction("lr", op_lr3);
            
            sloi_0 = new Operand(op1, 0);
            sloi_1 = new Operand("9", 0);
            Operand[] op_sloi3 = {sloi_0, sloi_1}; 
            Instruction ins_sloi_3 = new Instruction("sloi", op_sloi3);
            
            Operand lr_4 = new Operand(fourth, 0);
            Operand[] op_lr4 = {lr_4};          
            Instruction ins_lr_4 = new Instruction("lr", op_lr4);
            
            sloi_0 = new Operand(op1, 0);
            sloi_1 = new Operand("7", 0);
            Operand[] op_sloi4 = {sloi_0, sloi_1}; 
            Instruction ins_sloi_4 = new Instruction("sloi", op_sloi4);
            
            // System.out.println(first + "\t" + second + "\t" + third + "\t" + fourth);
            
            String ret_str = generateCode(ins_lr_1) + "\n" + generateCode(ins_sloi_1) + "\n" + generateCode(ins_lr_2) + "\n" + generateCode(ins_sloi_2)
                            + "\n" + generateCode(ins_lr_3) + "\n" + generateCode(ins_sloi_3) + "\n" + generateCode(ins_lr_4) + "\n" + generateCode(ins_sloi_4);
                    
            return ret_str;
        }
        
        if (instruction.operands[0].getOperandType().equals("immediate") && instruction.operator.equals("ba") || instruction.operator.equals("lr"))
        {
            op1 = Long.toBinaryString(instruction.operands[0].extractImmediate());
            op1 = "000000000" + op1;
            op1 = op1.substring(op1.length() - 9, op1.length());
        }
        
        if (instruction.operands.length == 2)
        {
            op2 = instruction.operands[1].name;
            
            if (instruction.operands[1].getOperandType().equals("immediate"))
            {
                op2 = Long.toBinaryString(instruction.operands[1].extractImmediate());
                op2 = "0000" + op2;
                op2 = op2.substring(op2.length() - 4, op2.length());
            }
        }
        
        if (instruction.operands[0].getOperandType().equals("register"))
        {
            switch (op1)
            {
                case "$sp": op1 = "0000"; break;
                case "$ra": op1 = "0001"; break;
                case "$ir": op1 = "0010"; break;
                case "$v0": op1 = "0011"; break;
                case "$a0": op1 = "0100"; break;
                case "$a1": op1 = "0101"; break;
                case "$t0": op1 = "0110"; break;
                case "$t1": op1 = "0111"; break;                                            
                case "$t2": op1 = "1000"; break;
                case "$t3": op1 = "1001"; break;
                case "$s0": op1 = "1010"; break;    
                case "$s1": op1 = "1011"; break;
                case "$s2": op1 = "1100"; break;         
                case "$s3": op1 = "1101"; break;
                case "$c0": op1 = "1110"; break;
                case "$c1": op1 = "1111"; break;
                default: System.out.println("Register " + op1 + " is not a valid register!"); return "";
            }
        }
        
        if (!op2.equals("") && instruction.operands[1].getOperandType().equals("register"))
        {
            switch (op2)
            {
                case "$sp": op2 = "0000"; break;
                case "$ra": op2 = "0001"; break;
                case "$ir": op2 = "0010"; break;
                case "$v0": op2 = "0011"; break;
                case "$a0": op2 = "0100"; break;
                case "$a1": op2 = "0101"; break;
                case "$t0": op2 = "0110"; break;
                case "$t1": op2 = "0111"; break;                                            
                case "$t2": op2 = "1000"; break;
                case "$t3": op2 = "1001"; break;
                case "$s0": op2 = "1010"; break;    
                case "$s1": op2 = "1011"; break;
                case "$s2": op2 = "1100"; break;         
                case "$s3": op2 = "1101"; break;
                case "$c0": op2 = "1110"; break;
                case "$c1": op2 = "1111"; break;
                default: System.out.println("Register " + op2 + " is not a valid register!"); return "";
            }    
        }   
        
        // for cmp, if 2nd value is a register, then reset bit is set to 1. else, reset bit is 0 (that means it's an immediate);
        switch (operator)
        {
            case "add":  opcode = "000"; func_code = "00"; break;
            case "addi": opcode = "000"; func_code = "01"; break;
            case "sub":  opcode = "000"; func_code = "10"; break;
            case "subi": opcode = "000"; func_code = "11"; break;
            case "sll":  opcode = "001"; func_code = "00"; break;
            case "slli": opcode = "001"; func_code = "01"; break;
            case "srl":  opcode = "001"; func_code = "10"; break;
            case "srli": opcode = "001"; func_code = "11"; break;
            case "and":  opcode = "010"; func_code = "00"; break;
            case "andi": opcode = "010"; func_code = "01"; break;
            case "or":   opcode = "010"; func_code = "10"; break;
            case "ori":  opcode = "010"; func_code = "11"; break;
            case "xor":  opcode = "011"; func_code = "00"; break; 
            case "nor":  opcode = "011"; func_code = "01"; break;
            case "cmp":  opcode = "011"; func_code = "10"; if (instruction.operands[1].getOperandType().equals("register")) reset = "1"; break;
            case "lw":   opcode = "100"; func_code = "00"; reset = "0"; break;
            case "sw":   opcode = "100"; func_code = "01"; reset = "0"; break;
            case "lior": opcode = "100"; func_code = "10"; if (instruction.operands[1].getOperandType().equals("register")) reset = "1"; break;
            case "lr":   opcode = "100"; func_code = "11"; break;    
            case "in":   opcode = "101"; func_code = "00"; break; 
            case "out":  opcode = "101"; func_code = "01"; break;
            case "halt": opcode = "101"; func_code = "10"; break;
            case "sloi": opcode = "101"; func_code = "11"; break;
            case "ba":   opcode = "110"; func_code = "00"; break;
            case "j":    opcode = "110"; func_code = "01"; break;
            case "jal":  opcode = "110"; func_code = "10"; break;
            case "jr":   opcode = "110"; func_code = "11"; break;
            case "bgt":  opcode = "111"; func_code = "00"; reset = "0"; break;
            case "blt":  opcode = "111"; func_code = "01"; reset = "0"; break;
            case "beq":  opcode = "111"; func_code = "10"; reset = "0"; break;
            case "bne":  opcode = "111"; func_code = "11"; reset = "0"; break;
            default: System.out.println("Instruction " + operator + " is not a valid instruction!"); return "";
        }
        
        //System.out.println("opcode: " + opcode + " op1: " + op1 + " op2: " + op2 + " reset: " + reset + " func_code " + func_code);
        
        if (operator.equals("jr"))
            op2 = "0000";
        
        if (operator.startsWith("b") || operator.equals("j") || operator.equals("jal") || operator.equals("lr"))
            str = opcode + op1 + func_code;
        else            
            str = opcode + op1 + op2 + reset + func_code;
        
        if (str.length() != 14) return str + " is not a valid instruction! ";
        
        System.out.print(instruction.line_number + "\t" + str + "\t\t");
        instruction.print();
        
        return "000" + str;
    }

	@Override
	void updateProgramCounter(Instruction instruction)
	{
		this.programCounter++;
	}

	@Override
	void initialization() throws IOException
	{
		map = new HashMap<String, Integer>();
		data_map = new HashMap<String, Integer>();
	}
 
	@Override
	void replaceInstructionLabel(Instruction instruction)
	{
		if (instruction.operands[0].getOperandType().equals("label"))
		{
			//System.out.println(instruction.operands[0].name + " " + map.get(instruction.operands[0].name));
			String name = instruction.operands[0].name;
			name = Integer.toBinaryString(map.get(name));
			name = "000000000" + name;
			instruction.operands[0].name = name.substring(name.length() - 9, name.length());
		} 
	}

	@Override
	void replaceMemoryLabel()
	{
		System.out.println("--replaceMemoryLabel--");
		for (int i = 0; i < memory.entries.length; i++)
		{
			int address = memory.entries[i].address;
			String data = memory.entries[i].data;
			if (data != null)
			{
				System.out.println(address + ": " + data);
				if (!data.startsWith("0x") || isNumeric(data))
				{					
					memory.entries[i].data = "0x" + Integer.toHexString(data_map.get(data));
					System.out.println(">>Replaced label " + data  + " with address " + data_map.get(data));
				}
			}
		}
		System.out.println("--end replaceMemoryLabel--");
	}
	
	public static void main(String[] args) throws IOException
	{
		Jokes assembler = new Jokes(args);
		assembler.AssembleCode(args);
		
        //assembler.AssembleCode(args); 
		//System.out.println("Hello");
	}

}
