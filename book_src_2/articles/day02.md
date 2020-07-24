# 你不可不知的 JavaScript 二三事#Day2：資料型態的夢魘——動態型別加弱型別(1)

「JavaScript 是動態型別」，很多人會說知道。

「JavaScript 是弱型別」，也有很多人會說知道。

「JavaScript 是動態型別加弱型別」，可能很多人就不那麼肯定了。

許多人把這兩件事混淆，其實這是兩個不同的觀念。那麼，究竟**動態型別**和**弱型別**有什麼差別？

**動態型別加上過於寬鬆的弱型別，是我認為 JavaScript 最叫人頭痛的萬惡根源**，因此選擇以這部分做切入。

本篇文章先來看何謂靜態型別與動態型別。


## 靜態型別 vs. 動態型別

### 靜態型別的例子

我們先從比較容易理解的靜態型別來看。以 Java 為例：

```java
int x;
```

這是一個很簡單的變數宣告，沒有給初始值。請問 `x` 這個變數裡未來會放什麼類型的值？

答案是整數。

為什麼我能這麼篤定？因為在宣告 `x` 時，使用了 `int` 這個關鍵字，明確宣告了變數 `x` 是個整數變數。

如果我在使用過程，企圖在 `x` 內放入非整數的值，例如：

```java
int x;
x = "Hello";
```

編譯時就會得到以下錯誤：

```
HelloWorld.java:5: error: incompatible types: String cannot be converted to int
```

這就是典型的靜態型別。這類語言在型別的管理上十分嚴謹，在語法撰寫時就會要求對變數型別有明確定義，有時讓人覺得囉嗦；但相對的，一旦有變數誤用或資料型態上的 Bug，在編譯時期就能發現，降低執行時期的風險。

編譯式語言多半是靜態語言，Java 和 C# 是其中的代表。

### 動態型別的例子

用另外一個語言 Lua 來舉例：

```
local x
x = 123
print(x)
x = "Hello"
print(x)
```

可以發現在用 `local` 宣告變數 `x` 時，沒有事先明確指定 `x` 的型別是什麼，能放入任意類型的資料；甚至中間還一度改變指派值的資料型態，一開始放的是整數 `123`，後來改放字串 `"Hello"`，程式依然可以運作。

這就是一個動態語言的例子，這類語言在程式執行過程才會進行資料型態的檢查或確認，因此直譯式語言都是動態語言。如 Python、PHP、Ruby，還有我們的主角 JavaScript，都屬於此類語言。

這類語言在程式編寫時，不用花太多心思在宣告型別的語法上，簡潔而靈活，可以在過程依需求任意改變型別，做到十分靈活的變數處理；但相對缺乏對當前變數的型別限制，當執行到某一行程式時，無法絕對肯定 `x` 變數現在放了什麼類型的值，容易造成非預期的執行可能性，導致非預期的執行結果。也就是容易埋下 Bug！

### 宣告時沒有指定型別，就是動態型別？

從上面兩個例子可以明顯看出動態語言和靜態語言的差別。可能會覺得：「很好辨認嘛，看宣告變數時有沒有指定型別，就知道是不是動態語言」。

這個理解是不精確的。

因為有的靜態語言在宣告時，也不需要指定型別，是透過**隱性推導**的方式來確認型別，例如 Ocaml、Haskell。

像傳統 C# 是典型的靜態語言，但在 C# 4.0 添加了新特性，允許宣告時不指定型別，但不改變 C# 骨子裡是靜態語言的事實。

例如傳統 C# 的撰寫方式如下：

```c#
int n = 123;
Console.WriteLine(n);
```

C# 4.0 後允許用以下方式撰寫：

```c#
var n = 456;
Console.WriteLine(n);
```

看起來很像動態語言的寫法。但如果企圖在過程放入不同型別的值，在編譯時一樣會被檢查出來，也就是說 C# 骨子還是靜態語言，不允許動態語言的使用方式，比如使用過程任意改變型別。

例如以下例子，將發生 `Cannot implicity convert type 'string' to 'int'` 的編譯錯誤(Compilation Error)：

```c#
var n = 456;
Console.WriteLine(n);
n = "Hello";
```

可能會有疑問：既然沒有指定型別，編譯器怎麼知道 `n` 的型別應該是什麼？

以 C# 4.0 來說，`n` 的型別就是**初始值的型別**，所以宣告時必須被初始化，否則會有 `Implicity-typed variables must be initialized` 的編譯錯誤，如以下例子：

```c#
var n;
n = 123;
Console.WriteLine(n);
```

這種不在語法上指定，而靠隱性推導的方式，稱為**隱性型別(implicity typed)的靜態語言**。

C# 4.0 添加了這個特性，算是吸收了動態語言在宣告語法上簡便的優點，同時仍保有靜態語言的穩定性。



### 總結靜態語言和動態語言的定義和差別

**靜態語言(Statically Typed Languages)：**
* 型別檢查(Type Checking)發生在**編譯時期(Compile Time)**。
* 程式撰寫時必須使用明確的型別宣告。
* 型別一旦宣告後，在執行時期時無法任意更換型別，否則會發生錯誤。

**動態語言(Dynamically Typed Languages)：**
* 型別檢查(Type Checking)發生在**執行時期(Runtime)**。
* 程式撰寫時不用明確的型別宣告。
* 執行時，變數能任意更換型別。

**而靜態語言又分為：**
* 顯性型別(explicitly typed)：型別是語法宣告的一部份，從語法就能得知。
* 隱性型別(implicity typed)：型別是透過編譯過程的推導得知。



## Reference
* [靜態語言 vs. 動態語言的比較](http://blog.sina.com.tw/dotnet/article.php?entryid=614009)
* [動態語言與靜態？直譯與編譯？強型別與弱型別？](https://millenniummeetonce.blogspot.com/2018/04/blog-post_5.html)
* [弱类型、强类型、动态类型、静态类型语言的区别是什么？](https://www.zhihu.com/question/19918532)