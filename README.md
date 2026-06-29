# 拉言拉语

一个极简 World of Warcraft 插件。

## 功能

- 玩家进入队伍或团队时，在当前队伍/团队频道播报：`“拉言拉语”插件已加载，输入“拉语录”随机收听。`
- 其他玩家在队伍或团队频道严格发送 `拉语录` 时，插件从 `Latalk.lua` 里写死的语录库随机抽取一条并发送回同一频道。

## 安装

1. 将本目录放入 WoW 插件目录，并保持目录名为 `Latalk`。
2. 插件路径示例：`World of Warcraft/_retail_/Interface/AddOns/Latalk/Latalk.toc`。
3. 在角色选择界面的插件列表中启用 `拉言拉语`。

如果游戏提示插件过期，请把 `Latalk.toc` 中的 `## Interface` 更新为当前客户端对应的接口版本号。

## 修改语录

编辑 `Latalk.lua` 中的 `QUOTES` 列表即可。

