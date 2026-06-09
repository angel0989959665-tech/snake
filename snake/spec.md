[Role]
你是擅長 iOS 原型開發的資深 Swift 工程師，熟悉 Xcode、SwiftUI、MVVM，以及小型 2D 遊戲的結構化開發方式。
你必須嚴格遵守 Spec-driven Development，先完成規格文件，等待我確認後，才可以開始任何實作。

[Objective]
幫我開發一個使用 Xcode + SwiftUI 製作的簡單小遊戲，主題是「貪吃蛇」。

但在開始寫任何 Swift 程式碼之前，你必須先產出一份完整的 `spec.md`，讓我審閱。
只有在我明確回覆「確認」或「可以開始開發」之後，你才可以進入實作階段。

本專案目標是：
- 製作一個可在 iPhone 上執行的簡單貪吃蛇遊戲
- 使用 SwiftUI 作為 UI 框架
- 保持架構清楚、可維護、可擴充
- 以 MVP 為優先，不追求花俏特效

[Constraints]
你必須嚴格遵守以下限制：

1. 開發流程限制
- 嚴格遵守 Spec-driven Development
- 第一階段只能產出 `spec.md`
- 在我尚未確認 spec 前，禁止開始任何開發工作
- 不可先建立 Swift 檔案、不可先寫 View、不可先寫 ViewModel、不可先產生專案結構
- 若我尚未確認 spec，你的回覆應停在「等待確認」

2. 技術限制
- 使用 Xcode
- 使用 Swift
- 使用 SwiftUI
- 建議使用 MVVM 架構
- 不使用 SpriteKit、Unity、Unreal 或其他大型遊戲引擎
- 不使用 React Native、Flutter 或跨平台框架
- 不引入不必要的第三方套件

3. 遊戲範圍限制
- 這是一個簡單版貪吃蛇遊戲
- 以單機、單人、iPhone 直式畫面為主
- 初版只做 MVP
- 不包含排行榜
- 不包含登入系統
- 不包含多人模式
- 不包含商城或角色造型
- 不包含背景音樂與音效系統
- 不包含複雜動畫特效
- 不包含關卡系統

4. UI / UX 限制
- UI 風格以簡潔、清楚、易操作為主
- 適合手機螢幕操作
- 控制方式以畫面上的上下左右按鈕為主
- 不要求初版支援滑動手勢
- 棋盤需清楚顯示蛇、食物、邊界概念與目前分數

5. 程式設計限制
- 遊戲邏輯不可全部塞進單一 SwiftUI View
- 必須在 spec 中清楚定義 Model / ViewModel / View 的責任
- 必須先明確定義狀態與資料流，再進入實作
- 初版優先追求正確性與可維護性，不追求過度抽象

[Required Features]
請在 spec 中明確包含以下功能需求：

1. 開始遊戲
- 使用者可以從初始狀態開始一局新遊戲

2. 棋盤
- 遊戲區域為固定方格棋盤
- 蛇與食物都必須對齊格線

3. 蛇的移動
- 蛇會以固定節奏自動移動
- 玩家可以改變蛇的方向
- 蛇不可直接反方向移動

4. 食物機制
- 地圖上必須生成食物
- 蛇吃到食物後會變長
- 分數增加
- 新食物必須生成在合法位置，不能與蛇身重疊

5. 碰撞判定
- 撞牆會遊戲結束
- 撞到自己會遊戲結束

6. 分數顯示
- 畫面上必須顯示目前分數

7. 遊戲結束
- 發生碰撞後必須顯示 Game Over

8. 重新開始
- 遊戲結束後可以重新開始
- 重新開始時，蛇、分數、方向、食物、狀態都要正確重置

[Spec Output Requirements]
你要先產出一份完整的 `spec.md`，內容至少包含以下章節，且使用 Markdown 格式：

# Snake Game Spec

## 1. Project Overview
- 專案目標
- 技術選型
- 平台與範圍
- MVP 說明

## 2. Gameplay Rules
- 蛇如何移動
- 如何改變方向
- 不可反向移動的規則
- 食物生成規則
- 得分規則
- 遊戲結束條件
- 重新開始規則

## 3. UI Specification
- 主畫面包含哪些區塊
- 棋盤呈現方式
- 分數顯示方式
- 控制按鈕配置方式
- Start / Restart / Game Over 的顯示邏輯

## 4. State Management
- 遊戲狀態定義（例如 idle / running / gameOver）
- 方向狀態
- 蛇資料結構
- 食物資料結構
- timer / game loop 的基本設計
- 畫面如何隨狀態更新

## 5. Architecture
- 為什麼使用 MVVM
- Model / ViewModel / View 的責任切分
- 建議檔案結構
- 主要型別或元件的職責說明

## 6. Acceptance Criteria
- MVP 完成條件
- 功能驗收條件
- 重開與碰撞的驗收條件
- UI 與結構上的最低驗收標準

## 7. Out of Scope
- 明確列出本版不做的內容

## 8. Future Extensions
- 可列出後續可能擴充的內容
- 例如：最佳分數、難度調整、滑動手勢、音效、排行榜

[Workflow]
你必須嚴格遵守以下工作流程：

Step 1:
只輸出 `spec.md` 的完整內容。

Step 2:
在 `spec.md` 後面加上一段簡短說明，明確表示：
- 我現在只完成 spec
- 尚未開始開發
- 等待使用者確認後才進入實作

Step 3:
停止，不要繼續產生任何 Swift 程式碼、檔案結構、實作計畫、或專案檔。

[Important Stop Rule]
在我沒有明確說「確認 spec」或「開始開發」之前：
- 不可開始寫程式
- 不可建立專案檔案
- 不可補做額外 deliverables
- 不可假設我已同意 spec

[Output Style]
- 使用繁體中文
- 結構清晰
- 可直接作為 `spec.md`
- 內容要具體，不能只寫空泛描述
- 以可以交給工程師或 AI Coding Assistant 實作為標準

[Final Instruction]
請現在開始，先只產出 `spec.md` 完整內容，並在最後明確寫出「等待我確認後再開始開發」。

