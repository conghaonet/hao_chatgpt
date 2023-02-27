[English](README.md) | 简体中文

# hao_chatgpt

一款用Flutter开发的非官方的 ChatGPT 应用。

<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/flutter_logo.png" height="40"/>&emsp;&emsp;<img src="https://github.com/conghaonet/hao_chatgpt/raw/master/screenshots/openai_logo.png" height="40"/>

## 支持的平台：
* iOS
* Android
* macOS
* Windows
* Linux (未测试)

## 开发中的特性
- [x] 聊天记录
- [ ] 生成代码 (Codex)

## 设置你自己的 OpenAI API key

在工程根目录下创建文件 **openai.yaml**，并填入你自己的 [**OpenAI API key**](https://beta.openai.com/account/api-keys)。
```yaml
# 默认 API key
api_key: 'YOUR-API-KEY'
```
出于安全原因, 我不能上传 **openai.yaml**。

注：_注册OpenAI账号需要科学上网，并有境外手机号用于接收短信验证码，如没有境外手机号，建议通过短信接码平台接收短信，以完成注册。_

## 中国大陆用户
本应用通过调用OpenAI官方API接入，无需科学上网即可使用。

## 截图
<Table>
    <tr align="center">
        <td width="50%"><br/><b>对话</b></td>
        <td width="50%"><br/><b>产生</b></td>
    </tr>
    <tr>
        <td width="50%">
            <a href="https://smms.app/image/7Xc4yUhg2LVqQvE" target="_blank"><img src="https://s2.loli.net/2023/01/10/7Xc4yUhg2LVqQvE.jpg"/></a>
        </td>
        <td width="50%">
            <a href="https://smms.app/image/ITAut7XkFPcHO1C" target="_blank"><img src="https://s2.loli.net/2023/01/10/ITAut7XkFPcHO1C.jpg"/></a>
        </td>
    </tr>
    <tr align="center">
        <td width="50%"><br/><b>提高分类器的效率</b></td>
        <td width="50%"><br/><b>转换</b></td>
    </tr>
    <tr>
        <td width="50%">
            <a href="https://smms.app/image/lwjDFrsJGBUpZCP" target="_blank"><img src="https://s2.loli.net/2023/01/10/lwjDFrsJGBUpZCP.jpg"/></a>
        </td>
        <td width="50%">
            <a href="https://smms.app/image/4RsOKU2PYbB5AFj" target="_blank"><img src="https://s2.loli.net/2023/01/10/4RsOKU2PYbB5AFj.jpg"/></a>
        </td>
    </tr>
    <tr align="center">
        <td width="50%"><br/><b>摘要</b></td>
        <td width="50%"><br/><b>翻译</b></td>
    </tr>
    <tr>
        <td width="50%">
            <a href="https://smms.app/image/Z4QVfdXaLUrC6Ag" target="_blank"><img src="https://s2.loli.net/2023/01/10/Z4QVfdXaLUrC6Ag.jpg"/></a>
        </td>
        <td width="50%">
            <a href="https://smms.app/image/LTydQhFDKOlAPag" target="_blank"><img src="https://s2.loli.net/2023/01/10/LTydQhFDKOlAPag.jpg"/></a>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <a href="https://smms.app/image/wkgEdCA4rlt5zVD" target="_blank"><img src="https://s2.loli.net/2023/01/10/wkgEdCA4rlt5zVD.jpg"/></a>
        </td>
        <td width="50%">
            <a href="https://smms.app/image/bAyWgLhaMijnpEV" target="_blank"><img src="https://s2.loli.net/2023/01/11/bAyWgLhaMijnpEV.jpg"/></a>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <a href="https://smms.app/image/ZdVT492vCJBhupg" target="_blank"><img src="https://s2.loli.net/2023/01/10/ZdVT492vCJBhupg.jpg"/></a>
        </td>
        <td width="50%">
            <a href="https://smms.app/image/RslaB3bxeHZ9TJV" target="_blank"><img src="https://s2.loli.net/2023/01/10/RslaB3bxeHZ9TJV.jpg"/></a>
        </td>
    </tr>
</Table>
