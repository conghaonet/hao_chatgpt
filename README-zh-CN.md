[English](README.md) | 简体中文

# hao_chatgpt

一款用Flutter开发的非官方的 ChatGPT 应用。

<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/flutter_logo.png" height="40"/>&emsp;&emsp;<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/openai_logo.png" height="40"/>

## 支持的模型：
* [gpt-3.5-turbo](https://platform.openai.com/docs/models/gpt-3-5)
* text-davinci-003
* text-curie-001
* text-babbage-001
* text-ada-001

## 支持的平台：
* iOS
* Android
* macOS
* Windows
* Linux (未测试)

## 开发中的特性
- [x] GPT-4
- [ ] 生成代码 (Codex)

## 设置你自己的 OpenAI API key

在工程根目录下创建文件 **openai.yaml**，并填入你自己的 [**OpenAI API key**](https://beta.openai.com/account/api-keys)。
```yaml
# 默认 API key
api_key: 'YOUR-API-KEY'
```
出于安全原因, 我不能上传 **openai.yaml**。

注：_注册OpenAI账号需要科学上网，并有境外手机号用于接收短信验证码，如没有境外手机号，建议通过短信接码平台接收短信，以完成注册。_

## 小提示
Set the task or role of the AI in this **SYSTEM** input box.  
For example: You are a helpful assistant that translates Chinese to English to.

![](https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/en/setsystem01.jpg) ![](https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/en/setsystem02.jp)

## 截图
<Table>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/screenshot04.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/screenshot03.jpg"/>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/screenshot01.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/screenshot02.jpg"/>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/home.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/leftmenu02.jpg"/>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/screenshot05.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/screenshot06.jpg"/>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/gpt35turbo.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/nokey.jpg"/>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/settings.jpg"/>
        </td>
        <td width="50%">
            <img src="https://github.com/conghaonet/hao_chatgpt/blob/master/screenshots/zh/leftmenu01.jpg"/>
        </td>
    </tr>
</Table>
