local ADDON_NAME = ...

local TRIGGER_TEXT = "拉语录"
local LOAD_MESSAGE = "“拉言拉语”插件已加载，输入“拉语录”随机收听。"
local QUOTE_SUFFIX = "   ——lalalavida"

local QUOTES = {
    "今天Farm吗？",
    "高考结束了，我志愿填的安静，希望能上。",
    "没办法，我的天性就是team boy。",
    "这个群里除了我就没纯绿玩了吗？",
    "这是什么意思？",
    "还是发点涩图吧",
    "主要我从不RMT。好想RMT。",
    "主要我被草太久了",
    "那更好了，我就喜欢人7",
    "问一个专业问题",
    "“我认真工作也要被你们霸凌？”“已经彻底拿捏12.1奥法的手法了”",
    "“我又不是变态”“下次我日安静的时候，你可以一起”",
    "所以我喜欢在上面，下面太危险",
    "他浑身颤抖，可以理解身体地震",
    "rinima了",
    "我只想说我的狂战风行也是一绝",
    "“这奶茶真难喝”“你请我喝奶茶吧”",
    "那你顺着网线过来打死我吧",
    "能让我硬起来的就是女的",
    "小时候爹妈打麻将不管我，我就拿着零花钱去打街机，现在想想我能这么优秀也是很神奇"
}

local frame = CreateFrame("Frame")
local wasInGroup = false

local function GetPlayerFullName()
    local name, realm = UnitFullName("player")
    if realm and realm ~= "" then
        return name .. "-" .. realm
    end
    return name
end

local function IsPlayerMessage(sender)
    if not sender or sender == "" then
        return false
    end

    return Ambiguate(sender, "none") == GetPlayerFullName()
        or Ambiguate(sender, "short") == UnitName("player")
end

local function GetCurrentGroupChannel()
    if IsInRaid() then
        return "RAID"
    end

    if IsInGroup() then
        return "PARTY"
    end

    return nil
end

local function AnnounceLoadedIfNeeded()
    local channel = GetCurrentGroupChannel()
    local isInGroup = channel ~= nil

    if isInGroup and not wasInGroup then
        C_ChatInfo.SendChatMessage(LOAD_MESSAGE, channel)
    end

    wasInGroup = isInGroup
end

local function ReplyWithRandomQuote(channel)
    if #QUOTES == 0 then
        return
    end

    C_ChatInfo.SendChatMessage(QUOTES[math.random(#QUOTES)] .. QUOTE_SUFFIX, channel)
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("CHAT_MSG_PARTY")
frame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
frame:RegisterEvent("CHAT_MSG_RAID")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")

frame:SetScript("OnEvent", function(_, event, message, sender)
    if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
        AnnounceLoadedIfNeeded()
        return
    end

    if message ~= TRIGGER_TEXT or IsPlayerMessage(sender) then
        return
    end

    if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
        ReplyWithRandomQuote("RAID")
        return
    end

    ReplyWithRandomQuote("PARTY")
end)
