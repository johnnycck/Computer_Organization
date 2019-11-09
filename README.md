# Computer_Organization
## LAB_1   
輸入一自然數X，找出最接近的兩質數A與B(X>A, X<B)，以MIPS實作
## LAB_2   
以Verilog 設計硬體 乘法器，完成 signed 以及 unsigned 乘法運算 。
## LAB_3   

使用Verilog實作RISC Processor-瞭解各指令在RISC運作方式</br>
        1. 新增RISC指令</br>
          •R-type：add , sub , and , or , slt</br>
          •I-type：lw , sw , beq</br>
          •J-type：j</br>
        2 . 修改“testbench.v”，使其能執行Lab1的程式</br>
          •從MEM讀出(lw)一個給定的輸入值做運算，並將得出的兩個結果存回(sw)MEM。</br>
## LAB_4   

把作業三完成的 CPU 及求最相近的兩個質數寫入 Nexys4 需要包含：</br>
        •13 個指撥作為輸入值 (sw0~sw12)</br>
        •運算 結果分別以前、後 4 個七段顯示器 顯示</br>
        •使用 reset 重新計算新值</br>
        
## LAB_5   
•LAB5 壓縮檔內容</br>
          •spice.din gcc.din </br>
          •內含約十萬筆資料，以模擬 CPU 到 cache 找資料的行為</br>
        •作業內容</br>
          •利用撰寫一個程式讀取 din 檔，來完成 cache 的行為模擬(最終使用c++)</br>
