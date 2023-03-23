import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get settings => '设置';

  @override
  String get theme => '主题';

  @override
  String get chooseTheme => '选择主题';

  @override
  String get light => '亮色模式';

  @override
  String get dark => '暗色模式';

  @override
  String get systemDefault => '系统默认';

  @override
  String get language => '语言';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get cancel => '取消';

  @override
  String get settingsReset => '重置';

  @override
  String get about => '关于';

  @override
  String get prompt => '提示';

  @override
  String get confirm => '确定';

  @override
  String get remove => '移除';

  @override
  String get removeKeyNotice => '这个API key将立即被移除。';

  @override
  String createdDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '创建于: $dateString';
  }

  @override
  String get default_ => '默认';

  @override
  String get duplicateApiKey => '重复的 API key！';

  @override
  String get appDescription => '一个非官方的开源 ChatGPT 应用';

  @override
  String get resetToDefault => '重置为默认值';

  @override
  String get haoChatIsPoweredByOpenAI => 'HaoChat由OpenAI驱动';

  @override
  String get storeAPIkeyNotice => '请提供OpenAI API key。此密钥仅在您的应用程序缓存中存储。';

  @override
  String get enterYourOpenAiApiKey => '输入你的 OpenAI API key';

  @override
  String get done => '完成';

  @override
  String get navigateTo => '导航到';

  @override
  String get logInAndClick => '登录后，点击 \"+ Create new secret key\"';

  @override
  String get newChat => '新对话';

  @override
  String get deleteConversations => '删除对话';

  @override
  String get confirmDelete => '确认删除';

  @override
  String get selectAll => '全选';

  @override
  String get delete => '删除';

  @override
  String get home => '主页';

  @override
  String get shortcuts => '快捷键';

  @override
  String sendWith(String shortcut) {
    return '使用 $shortcut 发送';
  }

  @override
  String get httpProxy => 'HTTP代理';

  @override
  String get enableProxy => '启用代理';

  @override
  String get hostName => '主机名';

  @override
  String get portNumber => '端口号';

  @override
  String get resume => '继续';

  @override
  String get systemPrompt => '系统提示';

  @override
  String get retry => '重试';

  @override
  String get copied => '已复制';

  @override
  String get defaultSystemPrompt => '你是一个乐于助人的助手。';

  @override
  String get systemPromptRecords => '系统提示记录';

  @override
  String get haoChat => 'HaoChat';

  @override
  String get openAI => 'OpenAI';

  @override
  String get chatGPT => 'ChatGPT';

  @override
  String get gpt35turbo => 'GPT-3.5-Turbo';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';

  @override
  String get gpt3 => 'GPT-3';

  @override
  String get model => 'Model';

  @override
  String get temperature => 'Temperature';

  @override
  String get maximumLength => 'Maximum length';

  @override
  String get topP => 'Top P';

  @override
  String get frequencyPenalty => 'Frequency penalty';

  @override
  String get presencePenalty => 'Presence penalty';
}
