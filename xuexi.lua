-- 扩展包基础信息
local extension = Package:new("jiudianbo")
extension.extensionName = "神话再临·神刘备"
extension.assetsPath = "assets" -- 资源路径基准

-- 武将类定义
local General = class("General")

function General:initialize(package, id, kingdom, hp, skillNames)
    self.package = package
    self.id = id
    self.kingdom = kingdom
    self.hp = hp
    self.skills = self:loadSkills(skillNames) -- 加载技能
    self:loadTranslations() -- 加载翻译
end

-- 加载技能：根据技能名列表动态加载对应的 Lua 文件
function General:loadSkills(skillNames)
    local skills = {}
    for _, skillName in ipairs(skillNames) do
        -- 技能文件路径：assets/skills/{技能名}.lua
        local skillPath = string.format("%s/skills/%s.lua", self.package.assetsPath, skillName)
        local skill = require(skillPath) -- 导入技能文件
        if skill then table.insert(skills, skill) end
    end
    return skills
end

-- 加载翻译表（示例）
function General:loadTranslations()
    Fk:loadTranslationTable({
        [self.id] = "神刘备",
        ["skill:" .. self.id] = table.concat(self.skills, ", "),
    })
end

-- 创建神刘备实例，指定技能名列表（需与技能文件名一致）
local shenLiubei = General:new(
    extension,
    "shen_liubei",
    "god",
    5,
    {"wushuang", "huangtian"} -- 技能名对应 assets/skills/ 下的文件名
)

return extension
