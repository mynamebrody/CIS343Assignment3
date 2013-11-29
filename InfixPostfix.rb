# Brody Berson
# Ruby 1.8.7
# InfixPostfix class contains methods for infix to postfix conversion and
# postfix expression evaluation.
#
class InfixPostfix
  
  # converts the infix expression string to postfix expression and returns it
  def infixToPostfix(exprStr)
  	stack = Array.new
  	resultstr = ""
    infix = exprStr.split
    infix.each do |sym|
    	if leftParen?(sym)
    		stack.push sym
    	end
    	if operand?(sym)
    		resultstr += sym
    		resultstr += " "
    	end
    	if operator?(sym)
    		finished = false
			until finished or stack.empty?
				if stackPrecedence(stack.last) >= inputPrecedence(sym)
					resultstr += stack.pop
					resultstr += " "
				else
					finished = true
				end
			end
    		stack.push sym
    	end
    	
    	if rightParen?(sym)
    		while stack.last != "("
				resultstr += stack.pop
				resultstr += " "
			end
			stack.pop
		end
	end
	while !stack.empty?
		resultstr += stack.pop
		resultstr += " "
	end
	return resultstr.rstrip	
  end

  # evaluate the postfix string and returns the result
  def evaluatePostfix(exprStr)
	stack = Array.new
  	postfix = exprStr.split
    postfix.each do |sym|    
		if operand?(sym)
			stack.push(sym)
		elsif operator?(sym)
			y = stack.pop.to_i            
			x = stack.pop.to_i  
			stack.push(applyOperator(x, y, sym))
		end
	end
	return stack.pop.to_i
  end

  private # subsequent methods are private methods

  # returns true if the input is an operator and false otherwise
  def operator?(str)
  	ops = ["+","*","/","-","%","^"]
  	ops.include? str
  end

  # returns true if the input is an operand and false otherwise
  def operand?(str)
  	str.to_i.to_s == str
  end

  # returns true if the input is a left parenthesis and false otherwise
  def leftParen?(str)
	str == "("
  end

  # returns true if the input is a right parenthesis and false otherwise
  def rightParen?(str)
	str == ")"
  end

  # returns the stack precedence of the input operator
  def stackPrecedence(operator)
  	case operator
  		when "^"
  			3
  		when "*","/","%"
  			2
  		when "+","-"
  			1
  		when "("
  			-1
  	end
  end

  # returns the input precedence of the input operator
  def inputPrecedence(operator)
	  case operator
	  	when "("
  			5
  		when "^"
  			4
  		when "*","/","%"
  			2
  		when "+","-"
  			1
  	end
  end

  # applies the operators to num1 and num2 and returns the result
  def applyOperator(num1, num2, operator)
  	case operator
  		when "^"
  			num1 ** num2
  		when "%"
  			num1 % num2
  		when "/"
  			num1 / num2
  		when "*"
  			num1 * num2
  		when "+"
  			num1 + num2
  		when "-"
  			num1 - num2
  	end
  end
  
end # end InfixPostfix class
