English | [简体中文](README-zh-CN.md)

# hao_chatgpt

An unofficial ChatGPT application developed with Flutter.

<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/flutter_logo.png" height="40"/>&emsp;&emsp;<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/openai_logo.png" height="40"/>

## Supported models
* [gpt-3.5-turbo](https://platform.openai.com/docs/models/gpt-3-5)
* text-davinci-003
* text-curie-001
* text-babbage-001
* text-ada-001

## Supported platforms
* iOS
* Android
* macOS
* Windows
* Linux (untested)

## Under development
- [x] GPT4
- [x] Chat history
- [ ] Code completion (Codex)

## Setup your OpenAI API key

Create a file named **openai.yaml** in the root directory of the project and fill it with your [**OpenAI API key**](https://beta.openai.com/account/api-keys).
```yaml
# default API key
api_key: 'YOUR-API-KEY'
```
For security reasons, I cannot upload my **openai.yaml**.

## Tips
Set the task or role of the AI in this **SYSTEM** input box.  
For example: You are a helpful assistant that translates Chinese to English to.

![](https://github.com/conghaonet/hao_chatgpt/blob/readme/screenshots/en/setsystem01.jpg)

![](https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/en/setsystem02.jpg)

## Screenshots
<Table>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/en/screenshot04.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/en/screenshot03.jpg"/>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Set the task or role of the AI in this <b>SYSTEM</b> input box. <br/>
For example: You are a helpful assistant that translates Chinese to English to.<br/>
<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/en/setsystem01.jpg"/>
<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/en/setsystem02.jpg"/>
        </td>
    </tr>
</Table>
