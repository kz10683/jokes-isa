/*
 * 
 */

import java.io.IOException;
import java.util.HashMap;

public class Jokes extends Assembler
{
	HashMap<String, Integer> map = new HashMap<String, Integer>();
	
	public Jokes(String[] args) throws IOException
	{
		super(args);
	}
	
	@Override
	void processLabel(String sourceCode)
	{
		// TODO Auto-generated method stub
	}
	
	@Override
	void processLabel(String sourceCode, int programCounter)
	{
		map.put(sourceCode, programCounter);
		System.out.println("PC: " + sourceCode + " " + programCounter);
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
        
        /*
        if (instruction.operands[0].getOperandType().equals("label"))
        {
            op1 = Integer.toBinaryString(map.get(instruction.operands[0].name));
            op1 = "000000000" + op1;
            op1 = op1.substring(op1.length() - 9, op1.length());
        }
        */
        
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
                default: break;
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
                default: break;
            }    
        }   
        
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
            case "cmp":  opcode = "011"; func_code = "10"; break;
            case "lw":   opcode = "100"; func_code = "00"; reset = "0"; break;
            case "sw":   opcode = "100"; func_code = "01"; reset = "0"; break;
            case "li":   opcode = "100"; func_code = "10"; break;
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
            default: break;
        }
        
        //System.out.println("opcode: " + opcode + " op1: " + op1 + " op2: " + op2 + " reset: " + reset + " func_code " + func_code);
        
        if (operator.equals("jr"))
            op2 = "0000";
        
        if (operator.equals("lr") || operator.startsWith("b") || operator.equals("j") || operator.equals("jal"))
            str = opcode + op1 + op2 + func_code;
        else
            str = opcode + op1 + op2 + reset + func_code;
        
        System.out.print(instruction.line_number + "\t" + str + "\t\t");
        instruction.print();
        return str;
	}

	@Override
	void updateProgramCounter(Instruction instruction)
	{
		if (instruction.operator.equals("sloi"))
			this.programCounter += 2;
		else
			this.programCounter++;
	}

	@Override
	void initialization() throws IOException
	{
		// TODO Auto-generated method stub
		
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
			
			/*
			instruction.operands[0].name = Integer.toBinaryString(map.get(instruction.operands[0].name));
			instruction.operands[0].name = "000000000" + instruction.operands[0].name;
			instruction.operands[0].name = instruction.operands[0].name.substring(instruction.operands[0].name.length() - 9, instruction.operands[0].name.length());
			*/
		} 
	}

	@Override
	void replaceMemoryLabel()
	{
		// TODO Auto-generated method stub
		
	}
	
	public static void main(String[] args) throws IOException
	{
		Jokes assembler = new Jokes(args);
		assembler.AssembleCode(args);
		
        //assembler.AssembleCode(args); 
		//System.out.println("Hello");
	}

}
