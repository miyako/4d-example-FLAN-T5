property text : Text
property reasoning_content : Text
property tool_calls : Collection

Class constructor
	
Function response($ChatCompletionsResult : cs:C1710.AIKit.OpenAIChatCompletionsResult)
	
	If (Form:C1466=Null:C1517)
		return 
	End if 
	
	If ($ChatCompletionsResult.errors#Null:C1517) && ($ChatCompletionsResult.errors.length#0)
		Form:C1466.error:=$ChatCompletionsResult.errors.extract("message").join("\r")
		return 
	End if 
	
	If ($ChatCompletionsResult.success)
		If ($ChatCompletionsResult.terminated)
			//complete
		Else 
			//stream
			var $results : Collection
			$results:=$ChatCompletionsResult["data"].results
			If ($results#Null:C1517)
				var $result : Object
				For each ($result; $results)
					Form:C1466.text+=$result.delta
				End for each 
			End if 
		End if 
	End if 
	
Function demo()
	
	Form:C1466.error:=""
	
	var $OpenAI : cs:C1710.AIKit.OpenAI
	
	var $customHeaders : Object
	$customHeaders:={}
	
	var $ChatCompletionsParameters : Object
	$ChatCompletionsParameters:={}
	$ChatCompletionsParameters.prompt:=[Form:C1466.prompt]
	$ChatCompletionsParameters.formula:=Form:C1466.response
	$ChatCompletionsParameters.stream:=True:C214
	$ChatCompletionsParameters.max_decoding_length:=1024
	
/*
	
over-ride AI Kit behaviour
	
*/
	
	$ChatCompletionsParameters.body:=Formula:C1597(body)
	
	Form:C1466.text:=""
	
	$OpenAI:=cs:C1710.AIKit.OpenAI.new({customHeaders: $customHeaders})
	$OpenAI.baseURL:="http://127.0.0.1:8080/v1"
	$OpenAI.chat.completions.create(Null:C1517; $ChatCompletionsParameters)