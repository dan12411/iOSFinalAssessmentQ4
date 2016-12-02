# iOSFinalAssessmentQ4

[![Travis branch](https://img.shields.io/travis/rust-lang/rust/master.svg)]()

題目：

![](https://github.com/dan12411/iOSFinalAssessmentQ4/blob/master/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7%202016-12-02%20%E4%B8%8B%E5%8D%882.18.36.png)

---

實作過程：

1. 使用CollectionViewController & CollectionViewCell

2. 產生六個 Collection View Custom Cell

3. 調整 Cell 長度/寬度，以符合畫面要求 (by UICollectionViewDelegateFlowLayout - sizeForItemAt)

4. 加上View for Cell，並設定 View 的 border color & width

5. 加上Label for Cell，並設定每個 Cell 要顯示的任務文字 (by switch)

6. 準備在 function - didSelectItemAt 實作各Cell的任務 (by swith & create each function)

7. alertCell() - present 自訂的 UIAlertController

8. colorChange() - 藉由添加變數 selectCell (Bool)，來判斷＆控制 background color

9. Privacy - Motion Usage Description

---

參考資料：


