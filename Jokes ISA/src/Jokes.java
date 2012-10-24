import java.io.IOException;

public class Jokes extends Assembler
{
	
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
	String generateCode(Instruction instruction)
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	void updateProgramCounter(Instruction instruction)
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	void initialization() throws IOException
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	void replaceInstructionLabel(Instruction instruction)
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	void replaceMemoryLabel()
	{
		// TODO Auto-generated method stub
		
	}
	
	public static void main(String[] args) throws IOException
	{
		String[] arg = { "C:/Users/Kevin/Documents/workspace/CSE141/src/Fibonacci.s", "Fib" } ;
		Jokes assembler = new Jokes(arg);
        assembler.AssembleCode(arg); 
        
		//System.out.println("Hello");
	}

}
