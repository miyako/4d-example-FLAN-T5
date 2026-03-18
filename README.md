## [google/flan-t5-large](https://huggingface.co/google/flan-t5-large)

```4d
var $OpenAI : cs.AIKit.OpenAI

var $customHeaders : Object
$customHeaders:={}

var $ChatCompletionsParameters : Object
$ChatCompletionsParameters:={}
$ChatCompletionsParameters.prompt:="translate English to French: The cat sat on the mat"

/*
	
	over-ride AI Kit behaviour
	
*/

$ChatCompletionsParameters.body:=Formula from string("$0:={messages: Null; prompt: This.prompt}")

$OpenAI:=cs.AIKit.OpenAI.new({customHeaders: $customHeaders})
$OpenAI.baseURL:="http://127.0.0.1:8080/v1"
var $ChatCompletionsResult : cs.AIKit.OpenAIChatCompletionsResult
$ChatCompletionsResult:=$OpenAI.chat.completions.create(Null; $ChatCompletionsParameters)

var $results : Collection
$results:=$ChatCompletionsResult.request.response.body.results

If ($results#Null)
	var $text : Text
	$text:=$results.at(0).text
	ALERT($text)
End if 
```

<img width="480" height="159" alt="Screenshot 2026-03-18 at 22 32 58" src="https://github.com/user-attachments/assets/e35de587-f332-4234-83b9-1562695731aa" />
